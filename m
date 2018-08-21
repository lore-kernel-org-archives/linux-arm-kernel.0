From: james.morse@arm.com (James Morse)
Date: Tue, 21 Aug 2018 11:22:50 +0100
Subject: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
In-Reply-To: <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
Message-ID: <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 08/21/2018 05:39 AM, John Stultz wrote:
> On Sun, Jul 22, 2018 at 6:57 PM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> There has been some confusion around what is necessary to prevent kexec
>> overwriting important memory regions. memblock: reserve, or nomap?
>> Only memblock nomap regions are reported via /proc/iomem, kexec's
>> user-space doesn't know about memblock_reserve()d regions.
>>
>> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
>> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
>> and thus possible for kexec to overwrite with the new kernel or initrd.
>> But this was always broken, as the UEFI memory map is also reserved
>> and not marked as nomap.
>>
>> Exporting both nomap and reserved memblock types is a nuisance as
>> they live in different memblock structures which we can't walk at
>> the same time.
>>
>> Take a second walk over memblock.reserved and add new 'reserved'
>> subnodes for the memblock_reserved() regions that aren't already
>> described by the existing code. (e.g. Kernel Code)
>>
>> We use reserve_region_with_split() to find the gaps in existing named
>> regions. This handles the gap between 'kernel code' and 'kernel data'
>> which is memblock_reserve()d, but already partially described by
>> request_standard_resources(). e.g.:
>> | 80000000-dfffffff : System RAM
>> |   80080000-80ffffff : Kernel code
>> |   81000000-8158ffff : reserved
>> |   81590000-8237efff : Kernel data
>> |   a0000000-dfffffff : Crash kernel
>> | e00f0000-f949ffff : System RAM
>>
>> reserve_region_with_split needs kzalloc() which isn't available when
>> request_standard_resources() is called, use an initcall.

>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 30ad2f085d1f..5b4fac434c84 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -241,6 +241,44 @@ static void __init request_standard_resources(void)

>> +static int __init reserve_memblock_reserved_regions(void)

>> +       for_each_reserved_mem_region(i, &start, &end) {
>> +               if (end <= roundup_end)
>> +                       continue; /* done already */
>> +
>> +               start = __pfn_to_phys(PFN_DOWN(start));
>> +               end = __pfn_to_phys(PFN_UP(end)) - 1;
>> +               roundup_end = end;
>> +
>> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
>> +               if (WARN_ON(!res))
>> +                       return -ENOMEM;
>> +               res->start = start;
>> +               res->end = end;
>> +               res->name  = "reserved";
>> +               res->flags = IORESOURCE_MEM;
>> +
>> +               mem = request_resource_conflict(&iomem_resource, res);
>> +               /*
>> +                * We expected memblock_reserve() regions to conflict with
>> +                * memory created by request_standard_resources().
>> +                */
>> +               if (WARN_ON_ONCE(!mem))
>> +                       continue;
>> +               kfree(res);
>> +
>> +               reserve_region_with_split(mem, start, end, "reserved");
>> +       }
>> +
>> +       return 0;
>> +}
>> +arch_initcall(reserve_memblock_reserved_regions);
>> +
> 
> Since this patch landed, on the HiKey board at bootup I'm seeing:
> 
> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
> reserve_memblock_reserved_regions+0xd4/0x13c
> [    0.451896] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 4.18.0-10758-ga534dc3 #709
> [    0.451903] Hardware name: HiKey Development Board (DT)
> [    0.451913] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [    0.451922] pc : reserve_memblock_reserved_regions+0xd4/0x13c
> [    0.451931] lr : reserve_memblock_reserved_regions+0xcc/0x13c
> [    0.451938] sp : ffffff8008053d30
> [    0.451945] x29: ffffff8008053d30 x28: ffffff8008ebe650
> [    0.451957] x27: ffffff8008ead060 x26: ffffff8008e113b0
> [    0.451969] x25: 0000000000000000 x24: 0000000000488020
> [    0.451981] x23: 0000000021ffffff x22: ffffff8008e0d860
> [    0.451993] x21: ffffff8008d74370 x20: ffffff8009019000
> [    0.452005] x19: ffffffc07507a400 x18: ffffff8009019a48
> [    0.452017] x17: 0000000000000000 x16: 0000000000000000
> [    0.452028] x15: ffffff80890e973f x14: 0000000000000006
> [    0.452040] x13: 0000000000000000 x12: 0000000000000000
> [    0.452051] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [    0.452063] x9 : 0000000000000000 x8 : ffffffc07507a480
> [    0.452074] x7 : 0000000000000000 x6 : ffffffc07ffffc30
> [    0.452086] x5 : 0000000000000000 x4 : 0000000021ffffff
> [    0.452097] x3 : 0000000000000001 x2 : 0000000000000001
> [    0.452109] x1 : 0000000000000000 x0 : 0000000000000000
> [    0.452121] Call trace:
> [    0.452130]  reserve_memblock_reserved_regions+0xd4/0x13c
> [    0.452140]  do_one_initcall+0x78/0x150
> [    0.452148]  kernel_init_freeable+0x198/0x258
> [    0.452159]  kernel_init+0x10/0x108
> [    0.452170]  ret_from_fork+0x10/0x18
> [    0.452181] ---[ end trace b4b78c443df3a750 ]---
> 
>  From skimming the patch, it seems this is maybe expected? Or should
> this warning raise eyebrows? I can't quite figure it out.

Ugh, sorry for the noise! This is warning that there is something wrong
with our assumptions about what types of memory exist.


> It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.

... pmem ...

> 
> /proc/iomem now has:
> ...
> 07410000-21efffff : System RAM
>    11000000-1113cfff : reserved

> 21f00000-21ffffff : reserved

^ This entry is what triggered the warning.

It expects that meblock_reserved() memory is also described as memory.
(memblock keeps them as separate lists, so its possible to reserve
memory that doesn't exist... which it looks like your system is doing)

If this region was described as memory, request_standard_resources()
would have put down a "System RAM" resource to cover it. This code is
trying to add a "reserved" underneath that, to discover the top level
doesn't exist. The reserved entry gets left in place as this region is
described as reserved...

Akashi and I figured this would only happen if a region is described as
nomap-memory and memblock_reserved() at the same time, which we don't
think is valid, hence the warning.

This avoided walking each reserved region, to work out which parts of it
were memory, nomap-memory (and now, not memory at all!)


>    21f00000-21f1ffff : persistent_ram
>    21f20000-21f3ffff : persistent_ram
>    21f40000-21f5ffff : persistent_ram
>    21f60000-21f7ffff : persistent_ram
>    21f80000-21f9ffff : persistent_ram
>    21fa0000-21fbffff : persistent_ram
>    21fc0000-21fdffff : persistent_ram
>    21fe0000-21ffffff : persistent_ram
> 22000000-34ffffff : System RAM
> ...
> 
> Where previously it had:
> ...
> 07410000-21efffff : System RAM
> 21f00000-21f1ffff : persistent_ram
> 21f20000-21f3ffff : persistent_ram
> 21f40000-21f5ffff : persistent_ram
> 21f60000-21f7ffff : persistent_ram
> 21f80000-21f9ffff : persistent_ram
> 21fa0000-21fbffff : persistent_ram
> 21fc0000-21fdffff : persistent_ram
> 21fe0000-21ffffff : persistent_ram
> 22000000-34ffffff : System RAM

So, this is a memblock_reserved() range that isn't actually memory.

This happens because your DT has carved these regions out of the memory
node, but added a named 'reserved-memory' region for them, just in case?
I'm not sure what it means if 'reserved-memory' is not also described as
memory....

You do need the carve-out, otherwise this gets covered by the linear
map, and when you throw in that 'unbuffered' property you get both a
cacheable and uncacheable mapping of the same page.

... and if you have the carve-out, you don't need the reserved-memory as
this is effectively a device which the driver knows the
memory-attributes for...

I think the problem here is making 'persistent memory' e.g. byte-addressable flash 
and 'reserved memory' (RAM) mean the same thing.

Something like [0] should mute the warning, but this assumes your
memblock_reserved() region didn't get merged with another reserved region
that really is memory, so just doing this makes it more fragile...

I will see if I can come up with something better.


Thanks,

James


[0] not even build tested
----------------------%<----------------------
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b4fac4..c64541b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -266,10 +266,15 @@ static int __init reserve_memblock_reserved_regions(void)
                 mem = request_resource_conflict(&iomem_resource, res);
                 /*
                  * We expected memblock_reserve() regions to conflict with
-                * memory created by request_standard_resources().
+                * memory created by request_standard_resources(). This doesn't
+                * happen if we found a region that is memblock_reserved(), but
+                * not actually memory.
                  */
-               if (WARN_ON_ONCE(!mem))
+               if (!mem) {
+                       remove_resource(res);
+                       kfree(res);
                         continue;
+               }
                 kfree(res);

                 reserve_region_with_split(mem, start, end, "reserved");
----------------------%<----------------------
