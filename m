From: trblinux@gmail.com (Tushar Behera)
Date: Wed, 25 Jun 2014 17:43:41 +0530
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <53A9FBB5.60709@codeaurora.org>
References: <539fdd37.e7bc420a.76b9.ffffb583@mx.google.com>
 <CAGa+x85nqPbH-sye28ni=gUEdgjGdUDqHhv1+0pV5aO8y1+wHQ@mail.gmail.com>
 <53A106F1.10201@gmail.com>
 <CAGa+x8527FEPk6fg5kv-fbOzK3MzcFooFGE9Me12b9C_Pv=UzA@mail.gmail.com>
 <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
 <53A7A579.4010702@gmail.com>
 <CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>
 <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
Message-ID: <53AABCF5.4050403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 03:59 AM, Laura Abbott wrote:
> On 6/24/2014 10:47 AM, Laura Abbott wrote:
>> On 6/23/2014 11:32 AM, Kevin Hilman wrote:
>>> On Sun, Jun 22, 2014 at 8:56 PM, Tushar Behera <trblinux@gmail.com> wrote:
>>>> Adding linux-samsung-soc and linux-arm-kernel ML for wider audience.
>>>>
>>>> On 06/19/2014 04:12 PM, Tushar Behera wrote:
>>>>> On 06/19/2014 03:02 PM, Tushar Behera wrote:
>>>>>> On 06/18/2014 09:22 AM, Kevin Hilman wrote:
>>>>>>> On Tue, Jun 17, 2014 at 8:26 PM, Tushar Behera <trblinux@gmail.com> wrote:
>>>>>>>> On 06/17/2014 10:23 PM, Kevin Hilman wrote:
>>>>>>>>> Sachin,
>>>>>>>>>
>>>>>>>>> On Mon, Jun 16, 2014 at 11:16 PM, Kevin's boot bot <khilman@linaro.org> wrote:
>>>>>>>>>>
>>>>>>>>>> Tree/Branch: mainline
>>>>>>>>>> Git describe: v3.16-rc1-2-gebe0618
>>>>>>>>>> Failed boot tests (console logs at the end)
>>>>>>>>>> ===========================================
>>>>>>>>>>      exynos5420-arndale-octa:     FAIL:    arm-exynos_defconfig
>>>>>>>>>>                 ste-snowball:     FAIL:    arm-u8500_defconfig
>>>>>>>>>
>>>>>>>>> FYI... these failures are getting more consistent on my octa board,
>>>>>>>>> but still not failing every time.
>>>>>>>>>
>>>>>>>>> Kevin
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Kevin,
>>>>>>>>
>>>>>>>> Same here.
>>>>>>>>
>>>>>>>> Observation: If you soft-reset the board (through the jumpers) after
>>>>>>>> getting this problem, the problem keeps repeating. But if you hard-reset
>>>>>>>> the board (by removing the power cord), the problem doesn't occur during
>>>>>>>> next iteration.
>>>>>>>
>>>>>>> I don't ever use the soft-reset, I only toggle the wall power.  I
>>>>>>> don't ever actually remove the power cord though, I'm using a
>>>>>>> USB-controlled relay to toggle the wall power.
>>>>>>>
>>>>>>> Kevin
>>>>>>>
>>>>>>
>>>>>> Laura,
>>>>>>
>>>>>> We are getting following kernel panic [1] (not always, but quite
>>>>>> regularly) while booting Arndale-Octa (based on Samsung's Exynos5420)
>>>>>> board with upstream kernel. I haven't observed this issue with other
>>>>>> boards yet.
>>>>>>
>>>>>> This issue is observed when I am booting with uImage + dtb (within
>>>>>> roughly ~10 iterations).
>>>>>>
>>>>>
>>>>> Some more information:
>>>>>
>>>>> The boot logs are provided in pastebin, okay[2] and failed[3].
>>>>>
>>>>> In case of boot failures, I am getting a higher value for vm_total_pages
>>>>> (684424 in [3]). In case of successful boot on my board, it is always
>>>>> 521232 [2] on my board.
>>>
>>> I can confirm that reverting the "Get rid of meminfo" patch gets the
>>> Octa board booting reliably again for me also.
>>>
>>> In case it helps, some boot logs for failures from the last copule
>>> linux-next build/boot cycles can be seen here:
>>> http://armcloud.us/kernel-ci/next/next-20140623/arm-exynos_defconfig/boot-exynos5420-arndale-octa.log
>>> http://armcloud.us/kernel-ci/next/next-20140620/arm-exynos_defconfig/boot-exynos5420-arndale-octa.log
>>>
>>
>> Sorry, I missed this yesterday. I'm going to take a look.
>>
> 
> Were all of 
> 
> http://pastebin.com/1iLaizuL
> http://pastebin.com/5tdDt4GL
> http://armcloud.us/kernel-ci/next/next-20140623/arm-exynos_defconfig/boot-exynos5420-arndale-octa.log
> http://armcloud.us/kernel-ci/next/next-20140620/arm-exynos_defconfig/boot-exynos5420-arndale-octa.log
> 
> collected on the same type of board with the same amount of DRAM? I'm seeing a
> different amount of total pages across all those logs. All the logs have the
> same lowmem limit so it seems like the upper bound was being calculated
> incorrectly for passing to free_area_init_node. Nothing is immediately jumping
> out at me so can you boot up with a small debug patch?
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 659c75d..88eac1f 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -187,6 +187,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
>         unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
>         struct memblock_region *reg;
>  
> +       pr_err("XXXXXXX min %lx max_low %lx max_high %lx\n", min, max_low, max_high);
> +       __memblock_dump_all();
>         /*
>          * initialise the zones.
>          */
> 
> It would be helpful to do this across a few bootups to see if the values are
> actually consistent. I'll keep looking in the meantime.
> 
> Thanks,
> Laura
> 

Thanks Laura for the pointer. In case of error, I am getting some random
memblock_add() calls from drivers/of/fdt.c:early_init_dt_scan_memory.

The issue seems to be from u-boot, where it is not updating the memory
subnode properly. I have got a fix for the u-boot, which I am testing
right now. I will update tomorrow after I do some more test.

Additional changes in kernel.
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c4cddf0..bca82b3 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -817,7 +817,7 @@ int __init early_init_dt_scan_memory(unsigned long
node, const char *uname,

        endp = reg + (l / sizeof(__be32));

-       pr_debug("memory scan node %s, reg size %d, data: %x %x %x %x,\n",
+       pr_err("memory scan node %s, reg size %d, data: %x %x %x %x,\n",
            uname, l, reg[0], reg[1], reg[2], reg[3]);

        while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
@@ -891,6 +891,7 @@ void __init __weak early_init_dt_add_memory_arch(u64
base, u64 size)
                size -= phys_offset - base;
                base = phys_offset;
        }
+       printk("trb: memblock_add base (%llx) size(%llx)\n", base, size);
        memblock_add(base, size);
 }


Kernel log:

memory scan node memory, reg size 96, data: 20 10 30 10,
trb: memblock_add base (20000000) size(10000000)
trb: memblock_add base (30000000) size(10000000)
trb: memblock_add base (40000000) size(10000000)
trb: memblock_add base (50000000) size(10000000)
trb: memblock_add base (60000000) size(10000000)
trb: memblock_add base (70000000) size(10000000)
trb: memblock_add base (80000000) size(10000000)
trb: memblock_add base (90000000) size(fa00000)
trb: memblock_add base (fffff000) size(fffff000)
trb: memblock_add base (ffeff000) size(fffff000)
trb: memblock_add base (fbfff000) size(fffff000)
trb: memblock_add base (fffff000) size(effff000)
Machine model: Insignal Arndale Octa evaluation board based on EXYNOS5420
bootconsole [earlycon0] enabled
Memory policy: Data cache writealloc
XXXXXXX min 20000 max_low 4f800 max_high fffff
MEMBLOCK configuration:
 memory size = 0x82a00fff reserved size = 0x75e947
 memory.cnt  = 0x4
 memory[0x0]     [0x00000020000000-0x00000042ffffff], 0x23000000 bytes
flags: 0x0
 memory[0x1]     [0x00000043800000-0x00000050ffffff], 0xd800000 bytes
flags: 0x0
 memory[0x2]     [0x00000051800000-0x0000009f9fffff], 0x4e200000 bytes
flags: 0x0
 memory[0x3]     [0x000000fbfff000-0x000000fffffffe], 0x4000fff bytes
flags: 0x0
 reserved.cnt  = 0x6
 reserved[0x0]   [0x00000020004000-0x00000020007fff], 0x4000 bytes
flags: 0x0
 reserved[0x1]   [0x000000200082c0-0x0000002059cb7f], 0x5948c0 bytes
flags: 0x0
 reserved[0x2]   [0x0000002fe45000-0x0000002fe4fea7], 0xaea8 bytes
flags: 0x0
 reserved[0x3]   [0x0000002fe50000-0x0000002ffff09e], 0x1af09f bytes
flags: 0x0
 reserved[0x4]   [0x0000004f7f3000-0x0000004f7fbfff], 0x9000 bytes
flags: 0x0
 reserved[0x5]   [0x0000004f7fcec0-0x0000004f7fffff], 0x3140 bytes
flags: 0x0


-- 
Tushar Behera
