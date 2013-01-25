From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jan 2013 11:36:50 +0100
Subject: arm: Kernel failures when several memory banks are used with
 starting address above 128MB
In-Reply-To: <alpine.LFD.2.02.1301221528050.6300@xanadu.home>
References: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
 <alpine.LFD.2.02.1301221528050.6300@xanadu.home>
Message-ID: <CAHTX3dJSiD7-Qw5Goc1ROWym=eyxto+ORiz8tQ9R+irMVpSvXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

2013/1/22 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Tue, 22 Jan 2013, Michal Simek wrote:
>
>> Hi,
>>
>> I have a question regarding to the case where DTS specify one memory bank
>> for example <0x0 0x40000000> with CONFIG_ARM_PATCH_PHYS_VIRT=y
>> where the kernel can be loaded at a 16MB boundary.
>> I was testing it on the 3.8-rc4 on arm zynq.
>>
>> 1. If the kernel is loaded within 0 - 127MB memory then the kernel can
>> work with the whole
>> 1GB memory. It shows that the memory in front of the kernel is also
>> available for the kernel.
>>
>> 2. If the kernel is loaded on the higher addresses then it fails by
>> these error messages.
>> "Ignoring RAM at 00000000-3fffffff (vmalloc region overlap).
>> Memory policy: ECC disabled, Data cache writeback
>> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0."
>>
>> 3. If I use several memory banks solution
>> for example
>> reg = <0 0x10000000 0x10000000 0x30000000>;
>> and the kernel is loaded to 0x10008000 then the first memory bank is
>> ignored and kernel will boot.
>> "Ignoring RAM at 00000000-0fffffff (vmalloc region overlap)." with
>> 768MB of memory.
>>
>> 4. The next interesting example is description with 3 memory banks.
>> reg = <0 0x10000000 0x10000000 0x20000000 0x30000000 0x10000000>;
>> which behaves as point 3. It means the first 128MB is ignored and only
>> 768MB of ram is available.
>>
>>
>> The real question is how the kernel should behave for these situations.
>> I would expect that if the kernel is within one memory bank
>> then it will use this whole bank
>> Or
>> I would expect that the memory which is in front of the kernel start address
>> will be simple ignored and the kernel will find out which memory bank
>> is used and will use it.
>> Not just caused kernel panic.
>> Or
>> Is there any expectation that you have to run the relocatable kernel
>> in the first 128MB of the memory
>> or changing DTS depending on the kernel position where it is loaded?
>
> There are two kernel config symbols influencing this:
>
> config AUTO_ZRELADDR
>         bool "Auto calculation of the decompressed kernel image address"
>         depends on !ZBOOT_ROM && !ARCH_U300
>         help
>           ZRELADDR is the physical address where the decompressed kernel
>           image will be placed. If AUTO_ZRELADDR is selected, the address
>           will be determined at run-time by masking the current IP with
>           0xf8000000. This assumes the zImage being placed in the first 128MB
>           from start of memory.
>
> config ARM_PATCH_PHYS_VIRT
>         bool "Patch physical to virtual translations at runtime" if EMBEDDED
>         default y
>         depends on !XIP_KERNEL && MMU
>         depends on !ARCH_REALVIEW || !SPARSEMEM
>         help
>           Patch phys-to-virt and virt-to-phys translation functions at
>           boot and module load time according to the position of the
>           kernel in system memory.
>
>           This can only be used with non-XIP MMU kernels where the base
>           of physical memory is at a 16MB boundary.
>
>           Only disable this option if you know that you do not require
>           this feature (eg, building a kernel for a single machine) and
>           you need to shrink the kernel to the minimal size.

ok. This is on zynq platform which enables ARCH_MULTIPLATFORM.
It means that both these options are enabled by default and


> Of course, the kernel must be loaded at some address within the provided
> RAM information in DT as well.  If you cannot meet those restrictions
> then the corresponding features have to be disabled in your build.

Does it mean what Russel mention that within means from ram start address
+ 16MB (from my test that limit is 128MB - but maybe memory tests can
find some bugs
but the kernel boots)

The fact is that I can't disabled these options because of
ARCH_MULTIPLATFORM option.
I am running AMP which means on the second ARM runs rtos.
Rtos on the second cpu needs to access vectors started at 0x0 that's
why I need to move
the kernel to higher addresses.

As I see from the exynos4210-origen.dts they use 4 memory banks
        memory {
                reg = <0x40000000 0x10000000
                       0x50000000 0x10000000
                       0x60000000 0x10000000
                       0x70000000 0x10000000>;
        };

I expect that kernel starting address is 0x40000000 (+0x8000) and
everything works as expected
but if they will try to use( without changing dts which describe exact
and real hardware configuration)
0x50000000 starting address than kernel won't boot.
What it is interesting on this is that Linux can work with all memory
banks which are in DTS
on higher addresses than starting address but can't work with memory
banks which are on lower addresses.

That's why I have created these patches (it is just c&p just to see
what I am talking about)
which ensure that kernel will boot not failed in these two cases.

Case 1:
The kernel starting address is at 0x10008000
dts memory reg = <0x0 0x40000000>;
which ensure that kernel will work only with 0x10000000 - 0x40000000
address space
Kernel bootlog will contain: "Change memory bank to 10000000-3fffffff"

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f06102..377d600 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -936,7 +936,26 @@ void __init sanity_check_meminfo(void)
                if (bank->start > ULONG_MAX)
                        highmem = 1;

+               if (bank->start < __pa(PAGE_OFFSET) &&
+                       __pa(PAGE_OFFSET) <= (bank->start + bank->size - 1)) {
+                               int offset = __pa(PAGE_OFFSET) - bank->start;
+                               bank->start += offset;
+                               bank->size -= offset;
+                               pr_crit("Change memory bank to %.8llx-%.8llx\n",
+                                       (unsigned long long)bank->start,
+                                       (unsigned long long)bank->start +
+                                                               bank->size - 1);
+               }
+


Case 2:
In two bank solution with the kernel starting address at 0x10008000
will be the first bank ignored
which ensure that HIGHMEM will work and kernel will boot
reg = <0x0 0x10000000 0x10000000 0x30000000>;
Kernel bootlog will contain: "Ignoring RAM at 00000000-0fffffff
(CONFIG_HIGHMEM)."


diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 048a199..377d600 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -948,6 +948,14 @@ void __init sanity_check_meminfo(void)
                }

 #ifdef CONFIG_HIGHMEM
+               if (__va(bank->start + bank->size - 1) < (void *)PAGE_OFFSET) {
+                       pr_notice("Ignoring RAM@%.8llx-%.8llx "
+                               "(CONFIG_HIGHMEM).\n",
+                               (unsigned long long)bank->start,
+                               (unsigned long long)bank->start +
bank->size - 1);
+                       continue;
+               }
+
                if (__va(bank->start) >= vmalloc_min ||
                    __va(bank->start) < (void *)PAGE_OFFSET)
                        highmem = 1;


Also these two patches ensure that kernel can be placed to any memory location
and will work with the rest of memory which is defined in the dts
without changing
dts to reflect different loading address.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
