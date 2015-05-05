From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 05 May 2015 16:38:19 +0200
Subject: [REGRESSION?] ARM: 7677/1: LPAE: Fix mapping in alloc_init_section
 for unaligned addresses  (was Re: Memory size unaligned to section boundary)
In-Reply-To: <20150505142210.GB20402@leverpostej>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <553F5B71.8030309@redhat.com> <20150505142210.GB20402@leverpostej>
Message-ID: <5548D5DB.4020407@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 05-05-15 16:22, Mark Rutland wrote:
> [Adding potentially interested parties, those involved in 7677/1]
>
> On Tue, Apr 28, 2015 at 11:05:37AM +0100, Hans de Goede wrote:
>> Hi all,
>>
>> On 23-04-15 15:19, Stefan Agner wrote:
>>> Hi,
>>>
>>> It seems to me that I hit an issue in low memory mapping (map_lowmem).
>>> I'm using a custom memory size, which leads to an freeze on Linux 4.0
>>> and also with Linus master on two tested ARMv7-A SoC's (Freescale Vybrid
>>> and NVIDIA Tegra 3):
>>>
>>> With mem=259744K
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 4.0.0-00189-ga4d2a4c3-dirty
>>> (ags at trochilidae) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC
>>> 4.8-2014.04) ) #506 Thu Apr 23 14:13:21 CEST 2015
>>> [    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7),
>>> cr=10c5387d
>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
>>> instruction cache
>>> [    0.000000] Machine model: Toradex Colibri VF61 on Colibri Evaluation
>>> Board
>>> [    0.000000] bootconsole [earlycon0] enabled
>>> [    0.000000] cma: Reserved 16 MiB at 0x8e400000
>>> [    0.000000] Memory policy: Data cache writeback
>>> <freeze>
>>>
>>> I dug a bit more into that, and it unveiled that when creating the
>>> mapping for the non-kernel_x part (if (kernel_x_end < end) in
>>> map_lowmem), the unaligned section at the end leads to the freeze. In
>>> alloc_init_pmd, if the memory end is section unaligned, alloc_init_pte
>>> gets called which allocates a PTE outside of the initialized region (in
>>> early_alloc_aligned). The system freezes at the call of memset in
>>> early_alloc_aligned function.
>>>
>>> With some debug print, this can be better illustrated:
>>> [    0.000000] pgd 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
>>> [    0.000000] pud 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
>>> [    0.000000] pmd 800063f0, addr 8fc00000, next 8fda8000
>>>                            => actual end of memory ^^^^^^^^
>>> [    0.000000] alloc_init_pte
>>> [    0.000000] set_pte_ext, pte 00000000, addr 8fc00000, end 8fda8000
>>> [    0.000000] early_pte_alloc
>>> [    0.000000] early_alloc_aligned, 00001000, ptr 8fcff000, align
>>> 00001000
>>>        => PTE allocated outside of initialized area ^^^^^^^^
>>>
>>> It seems that memory gets allocation in the last section. When the last
>>> section was in the previous PMD, the allocation works, however if the
>>> last section is within the same PMD, the allocation ends up in the
>>> non-initialized area. So:
>>>
>>> In other words, sizes which end in a upper part of the 2MB sized PMD
>>> fail, while sizes in the lower part of a PMD work.
>>> 0xFF80000 => fails (mem=261632K)
>>> 0xFE80000 => works (mem=260608K)
>>> 0xFD80000 => fails (mem=261632K)
>>> ...
>>>
>>> While I understand the reason for the freeze, I don't know to properly
>>> fix it. It looks to me that in alloc_init_pmd, we should use
>>> __map_init_section first to map the last aligned section, before calling
>>> alloc_init_pte on the non aligned section.
>>>
>>> Background: I tried to reuse the boot loader part of the simplefb
>>> implementation for sunxi. It decreases memory size by the size of the
>>> framebuffer. Hence the actually memory size can be unaligned, depending
>>> on the display size used. In the case at hand, a framebuffer of the size
>>> 800x600 worked while 1024x600 did not work... The implementation uses
>>> device tree to report the memory size, but the kernel arguments show the
>>> same behavior.
>>>
>>> Maybe a regression of e651eab0af ("ARM: 7677/1: LPAE: Fix mapping in
>>> alloc_init_section for unaligned addresses"). I currently do not have a
>>> platform at hand which works on that Linux version out of the box.
>>
>> I'm seeing this to an Allwinner Cortex A7 based SoCs, specifically
>> on tablets with a 1024x600 lcd screen it seems that shaving exactly the
>> amount of memory needed for a 32bpp 1024x600 framebuffer of from the
>> top of memory triggers this.
>
> I'm able to trigger the issue on TC2 by passing mem=259744K. If I hack
> sanity_check_meminfo to round the memblock limit down to PMD_SIZE I
> avoid the immediate freeze, but later things blew up seemingly due to an
> unmapped DTB (panic below) I'm not entirely sure why that's the case.

Thank you for looking into this.

> I wasn't able to come up with a DTB that would trigger this. Do you have
> an example set of memory nodes + memreserves? Where are your kernel and
> DTB loaded in memory?

We've a single memory node/bank from 0x40000000 to end of memory, we
carve out a framebuffer at the end, and do not report that to Linux, so
the end becomes 0x40000000 + memory-size - fb-size, and we use no mem
reserves, because if we do use mem-reserves the mmap of the fbmem by
the simplefb driver fails as that maps it non cach-able and if it is
part of the main membank it already is mapped cachable.

We substract exactly the necessary fb-size, one known fb-size which
triggers this is 1024x600 which means we end up substracting
1024x600x4 bytes from the end of memory, so effectively we are
doing the same as passing a mem= argument which is not 2MiB aligned.

As for our kernel location, we have the following in u-boot's
environment:

         "kernel_addr_r=0x42000000\0" \
         "fdt_addr_r=0x43000000\0" \
         "scriptaddr=0x43100000\0" \
         "pxefile_addr_r=0x43200000\0" \
         "ramdisk_addr_r=0x43300000\0"

Regards,

Hans


> Unable to handle kernel paging request at virtual address 9fee6000
> pgd = 80004000
> [9fee6000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.0-rc1+ #17
> Hardware name: ARM-Versatile Express
> task: 8065e7a8 ti: 8065a000 task.ti: 8065a000
> PC is at fdt_check_header+0x0/0x74
> LR is at __unflatten_device_tree+0x1c/0x128
> pc : [<80490350>]    lr : [<803a1554>]    psr: a00001d3
> sp : 8065bf28  ip : 806a7d77  fp : 80000200
> r10: 8056d84c  r9 : 8069fc9c  r8 : 80635b0c
> r7 : 80683140  r6 : 9fee6000  r5 : 8063eac4  r4 : 80635b0c
> r3 : 8069fcb4  r2 : 80635b0c  r1 : 8069fc9c  r0 : 9fee6000
> Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 8000406a  DAC: 00000015
> Process swapper (pid: 0, stack limit = 0x8065a210)
> Stack: (0x8065bf28 to 0x8065c000)
> bf20:                   ffffffff 00000000 ffffffff 0008fbfd 00000000 00000000
> bf40: 00000000 80635b0c 8063eac4 8065f79c 80683140 8068d5e4 806650e0 806366e8
> bf60: 8065c3c8 8061b43c ffffffff 10c5387d 80683000 8fbfb340 80008000 8064aa88
> bf80: 00000000 00000000 00000000 80058674 8056c3e8 8065bfb4 00000000 00000000
> bfa0: 80683000 00000001 8065c3c0 ffffffff 00000000 00000000 00000000 8061895c
> bfc0: 00000000 00000000 00000000 00000000 00000000 8064aa88 80683394 8065c440
> bfe0: 8064aa84 8065f8bc 8000406a 412fc0f1 00000000 8000807c 00000000 00000000
> [<80490350>] (fdt_check_header) from [<803a1554>] (__unflatten_device_tree+0x1c/0x128)
> [<803a1554>] (__unflatten_device_tree) from [<806366e8>] (unflatten_device_tree+0x28/0x34)
> [<806366e8>] (unflatten_device_tree) from [<8061b43c>] (setup_arch+0x778/0x984)
> [<8061b43c>] (setup_arch) from [<8061895c>] (start_kernel+0x9c/0x3ac)
> [<8061895c>] (start_kernel) from [<8000807c>] (0x8000807c)
> Code: e3e0300d eafd2608 e3e0300d eafd260d (e5903000)
> ---[ end trace cb88537fdc8fa200 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>
