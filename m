From: christian.glindkamp@taskit.de (Christian Glindkamp)
Date: Tue, 26 Jul 2011 15:37:02 +0200
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
In-Reply-To: <CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
	<CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
	<CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
Message-ID: <20110726133702.GA14526@taskit.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-07-26 16:38, P J wrote:
> On Mon, Jul 25, 2011 at 7:36 PM, P J <pj0585@gmail.com> wrote:
> > Hi Russell,
> >
> > On Fri, Jul 22, 2011 at 7:25 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Fri, Jul 22, 2011 at 07:06:40PM +0530, P J wrote:
> >>> The memory map (required) is as follows:
> >>> ? ? phys ? ? ? ? ? => ? ? ? ? ?virt
> >>> 0x70000000 ? ?=> ? ?0xC0000000 ?(128 MB)
> >>> 0x20000000 ? ?=> ? ?0xC8000000 ?(128 MB)
> >>
> >> There is no way that the kernel will support this kind of hair-brained
> >> memory layout. ?This is even more true than it once was since we've moved
> >> to using memblock to manage the physical memory layout in later kernels.
> >>
> >> What the kernel will support is using 0x20000000 as the first bank and
> >> 0x70000000 as the second bank of memory. ?I suggest trying with it mapped
> >> that way around, and failing that then using highmem support without
> >> sparse.
> >>

Actually, for me it is the other way around. I have an AT91SAM9G45 based
system with 256MB at 0x20000000 and 0x70000000, making a total of 512MB.
If I use mapping like this
 phys  ? ? ? ? => ? ?virt
 0x70000000 ? ?=> ? ?0xC0000000 ?(256 MB)
 0x20000000 ? ?=> ? ?0xD0000000 ?(256 MB)
if seems to work without any problems. This is with Linux 3.0.

If I switch the mapping around and load the zImage to 0x21000000 instead
of 0x71000000, the boot stops with the following message:

 Truncating RAM at 70000000-7fffffff to -96dfffff (vmalloc region overlap).
 Memory policy: ECC disabled, Data cache writeback

The high memory version isn't stable either, but boots at least.
For more see below.

> >
> > I do not completely understand why this layout is not possible.
> >
> > Anyways, my one memory bank (128 MB DDR2) is located at physical
> > address 0x70000000 to 0x77FFFFFF and is virtually mapped to 0xC0000000
> > to 0xC7FFFFFF.
> >
> > If I have to continue to use this bank as per the above mapping then
> > how can I use the other memory bank (128MB DDR2) which is located at
> > physical address 0x20000000 to 0x27FFFFFF ?
> >
> >
> > -Prasant J
> >
> 
> 
> I think that if I change my memory banks (like I use the memory bank
> at 0x20000000 as the first one and the memory bank at 0x70000000 as
> the second one) then also I will have issues.
> 
> The issue is because the memory banks are not getting correctly mapped
> because the __virt_to_phys() and __phys_to_virt() are defined as
> linear:
> 
> #define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
> #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
> 
> where PHYS_OFFSET is 0x70000000 and PAGE_OFFSET is 0xC0000000
> 
> 
> Now the first bank which is at 0x70000000 gets correctly mapped
> virtually but the second bank which is at 0x20000000 gets mapped
> incorrectly. Even if I change the order of banks, (also I change the
> PHYS_OFFSET to 0x20000000) then, always, only one bank gets mapped
> correctly and the other one gets incorrectly mapped.
> 
> If I change the above defines to map both my memories correctly then
> Linux does not boot.
> 
> 
> Any suggestions, as to how I can get the mappings correct.

Have you also switched the order of the atags, so that 0x20000000 comes
first? And you do not have to edit these macros if you enable
CONFIG_AUTO_ZRELADDR. At least that worked for me with high memory.
You should also load the kernel into the RAM bank at 0x20000000.

The only problem that still exits with highmem for me is the following:
Even on non-highmem/non-sparsemem systems I get the following warning
when using an mmc as the rootfs:

------------[ cut here ]------------
WARNING: at kernel/irq/handle.c:130 handle_irq_event_percpu+0x70/0x194()
irq 29 handler atmci_interrupt+0x0/0x64c enabled interrupts
Backtrace: 
[<c018ed00>] (dump_backtrace+0x0/0x110) from [<c018f274>] (dump_stack+0x18/0x1c)
 r6:c01c9254 r5:c04831ac r4:00000082
[<c018f25c>] (dump_stack+0x0/0x1c) from [<c019c73c>] (warn_slowpath_common+0x54/0x6c)
[<c019c6e8>] (warn_slowpath_common+0x0/0x6c) from [<c019c7f8>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:c04ba500 r6:00000001 r5:0000001d r4:cf8f7b40
[<c019c7c0>] (warn_slowpath_fmt+0x0/0x40) from [<c01c9254>] (handle_irq_event_percpu+0x70/0x194)
 r3:0000001d r2:c04831c0
[<c01c91e4>] (handle_irq_event_percpu+0x0/0x194) from [<c01c93ac>] (handle_irq_event+0x34/0x44)
[<c01c9378>] (handle_irq_event+0x0/0x44) from [<c01cb6c0>] (handle_level_irq+0xd4/0xe8)
 r4:c04ba500
[<c01cb5ec>] (handle_level_irq+0x0/0xe8) from [<c01c8f5c>] (generic_handle_irq+0x34/0x3c)
 r4:0000001d
[<c01c8f28>] (generic_handle_irq+0x0/0x3c) from [<c018b068>] (asm_do_IRQ+0x68/0x98)
 r4:0000001d
[<c018b000>] (asm_do_IRQ+0x0/0x98) from [<c018ba54>] (__irq_svc+0x34/0x60)
Exception stack(0xc04b1f40 to 0xc04b1f88)
1f40: 00000000 0005317f 0005217f 60000013 c04b0000 c04b4b80 c04d32b0 c04b2000
1f60: 70004000 41069265 70022940 c04b1f94 600000d3 c04b1f88 c018cdb0 c018cdbc
1f80: 60000013 ffffffff
 r5:fefff000 r4:ffffffff
[<c018cd80>] (default_idle+0x0/0x40) from [<c018cbcc>] (cpu_idle+0x68/0xb0)
[<c018cb64>] (cpu_idle+0x0/0xb0) from [<c041db78>] (rest_init+0x5c/0x74)
 r6:c018730c r5:c04d3200 r4:c04b20e4
[<c041db1c>] (rest_init+0x0/0x74) from [<c0008d08>] (start_kernel+0x358/0x3c8)
[<c00089b0>] (start_kernel+0x0/0x3c8) from [<70008040>] (0x70008040)
---[ end trace ac1fb351351e0957 ]---

The system is still stable, but if switch to highmem, the kernel crashes
completely when doing this (using and USB drive as rootfs still works
flawlessly):

Unable to handle kernel NULL pointer dereference at virtual address 00000002
pgd = c0004000
[00000002] *pgd=00000000
Internal error: Oops: 817 [#1]
CPU: 0    Not tainted  (3.0.0+ #678)
PC is at atmci_interrupt+0x198/0x64c
LR is at 0x46
pc : [<c038ba4c>]    lr : [<00000046>]    psr: 80000093
sp : c04b1e58  ip : 00000000  fp : c04b1e9c
r10: 00464c45  r9 : cf999e94  r8 : 00000000
r7 : 00000004  r6 : 00000000  r5 : cf96a500  r4 : cf97ac00
r3 : 0000464c  r2 : 00001000  r1 : 464c457f  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 2f9c8000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc04b0270)
Stack: (0xc04b1e58 to 0xc04b2000)
1e40:                                                       cf96a52c 00000017
1e60: 00000002 00000000 c038aad8 464c457f 00000004 cf87cfc0 0000001d 0000001d
1e80: c04ba500 00000000 c04dc040 00000000 c04b1ed4 c04b1ea0 c01c8cb8 c038b8c4
1ea0: 90848946 00000003 c04b2000 c04ba500 00000000 0000001d c018693c c04b2000
1ec0: 41069265 20021cc4 c04b1eec c04b1ed8 c01c8e48 c01c8c90 c01c1d04 c04ba500
1ee0: c04b1f04 c04b1ef0 c01cb15c c01c8e24 c01a190c 0000001d c04b1f1c c04b1f08
1f00: c01c89f8 c01cb098 c0196f68 0000001d c04b1f34 c04b1f20 c018b068 c01c89d4
1f20: ffffffff fefff000 c04b1f8c c04b1f38 c018ba54 c018b010 00000000 0005317f
1f40: 0005217f 60000013 c04b0000 c04b4b80 c04d32d0 c018693c c04b2000 41069265
1f60: 20021cc4 c04b1f8c 600000d3 c04b1f80 c018cdb0 c018cdbc 60000013 ffffffff
1f80: c04b1fac c04b1f90 c018cbcc c018cd90 c018693c c04b20e4 c04d3288 c04d3220
1fa0: c04b1fbc c04b1fb0 c041c52c c018cb74 c04b1ff4 c04b1fc0 c0008c4c c041c4e0
1fc0: c0008578 00000000 00000000 c018693c 00000000 00053175 c04b200c c0186d40
1fe0: c04b4b74 20004000 00000000 c04b1ff8 20008040 c00089c0 00000000 00000000
Backtrace: 
[<c038b8b4>] (atmci_interrupt+0x0/0x64c) from [<c01c8cb8>] (handle_irq_event_percpu+0x38/0x194)
[<c01c8c80>] (handle_irq_event_percpu+0x0/0x194) from [<c01c8e48>] (handle_irq_event+0x34/0x44)
[<c01c8e14>] (handle_irq_event+0x0/0x44) from [<c01cb15c>] (handle_level_irq+0xd4/0xe8)
 r4:c04ba500
[<c01cb088>] (handle_level_irq+0x0/0xe8) from [<c01c89f8>] (generic_handle_irq+0x34/0x3c)
 r4:0000001d
[<c01c89c4>] (generic_handle_irq+0x0/0x3c) from [<c018b068>] (asm_do_IRQ+0x68/0x98)
 r4:0000001d
[<c018b000>] (asm_do_IRQ+0x0/0x98) from [<c018ba54>] (__irq_svc+0x34/0x60)
Exception stack(0xc04b1f38 to 0xc04b1f80)
1f20:                                                       00000000 0005317f
1f40: 0005217f 60000013 c04b0000 c04b4b80 c04d32d0 c018693c c04b2000 41069265
1f60: 20021cc4 c04b1f8c 600000d3 c04b1f80 c018cdb0 c018cdbc 60000013 ffffffff
 r5:fefff000 r4:ffffffff
[<c018cd80>] (default_idle+0x0/0x40) from [<c018cbcc>] (cpu_idle+0x68/0xb0)
[<c018cb64>] (cpu_idle+0x0/0xb0) from [<c041c52c>] (rest_init+0x5c/0x74)
 r6:c04d3220 r5:c04d3288 r4:c04b20e4
[<c041c4d0>] (rest_init+0x0/0x74) from [<c0008c4c>] (start_kernel+0x29c/0x308)
[<c00089b0>] (start_kernel+0x0/0x308) from [<20008040>] (0x20008040)
 r8:20004000 r7:c04b4b74 r6:c0186d40 r5:c04b200c r4:00053175
Code: e1a0ec23 e1a0a421 e1a03823 8a000017 (e5c03002) 
---[ end trace b6fce2ac8e8c707d ]---
Kernel panic - not syncing: Fatal exception in interrupt
Backtrace: 
[<c018ed00>] (dump_backtrace+0x0/0x110) from [<c018f274>] (dump_stack+0x18/0x1c)
 r6:c04b0000 r5:00000000 r4:c04d3654
[<c018f25c>] (dump_stack+0x0/0x1c) from [<c019c440>] (panic+0x60/0x1a4)
[<c019c3e0>] (panic+0x0/0x1a4) from [<c018f0c4>] (die+0x2b4/0x30c)
 r3:00010000 r2:c0484cf4 r1:00000000 r0:c047bc4c
[<c018ee10>] (die+0x0/0x30c) from [<c01908ac>] (__do_kernel_fault+0x70/0x90)
[<c019083c>] (__do_kernel_fault+0x0/0x90) from [<c0190a8c>] (do_page_fault+0x1c0/0x1d8)
 r8:00000817 r7:00000000 r6:c04b3f28 r5:00000002 r4:ffffffff
[<c01908cc>] (do_page_fault+0x0/0x1d8) from [<c018b2a8>] (do_DataAbort+0x40/0xa4)
[<c018b268>] (do_DataAbort+0x0/0xa4) from [<c018ba0c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc04b1e10 to 0xc04b1e58)
1e00:                                     00000000 464c457f 00001000 0000464c
1e20: cf97ac00 cf96a500 00000000 00000004 00000000 cf999e94 00464c45 c04b1e9c
1e40: 00000000 c04b1e58 00000046 c038ba4c 80000093 ffffffff
 r8:00000000 r7:00000004 r6:00000000 r5:c04b1e44 r4:ffffffff
[<c038b8b4>] (atmci_interrupt+0x0/0x64c) from [<c01c8cb8>] (handle_irq_event_percpu+0x38/0x194)
[<c01c8c80>] (handle_irq_event_percpu+0x0/0x194) from [<c01c8e48>] (handle_irq_event+0x34/0x44)
[<c01c8e14>] (handle_irq_event+0x0/0x44) from [<c01cb15c>] (handle_level_irq+0xd4/0xe8)
 r4:c04ba500
[<c01cb088>] (handle_level_irq+0x0/0xe8) from [<c01c89f8>] (generic_handle_irq+0x34/0x3c)
 r4:0000001d
[<c01c89c4>] (generic_handle_irq+0x0/0x3c) from [<c018b068>] (asm_do_IRQ+0x68/0x98)
 r4:0000001d
[<c018b000>] (asm_do_IRQ+0x0/0x98) from [<c018ba54>] (__irq_svc+0x34/0x60)
Exception stack(0xc04b1f38 to 0xc04b1f80)
1f20:                                                       00000000 0005317f
1f40: 0005217f 60000013 c04b0000 c04b4b80 c04d32d0 c018693c c04b2000 41069265
1f60: 20021cc4 c04b1f8c 600000d3 c04b1f80 c018cdb0 c018cdbc 60000013 ffffffff
 r5:fefff000 r4:ffffffff
[<c018cd80>] (default_idle+0x0/0x40) from [<c018cbcc>] (cpu_idle+0x68/0xb0)
[<c018cb64>] (cpu_idle+0x0/0xb0) from [<c041c52c>] (rest_init+0x5c/0x74)
 r6:c04d3220 r5:c04d3288 r4:c04b20e4
[<c041c4d0>] (rest_init+0x0/0x74) from [<c0008c4c>] (start_kernel+0x29c/0x308)
[<c00089b0>] (start_kernel+0x0/0x308) from [<20008040>] (0x20008040)
 r8:20004000 r7:c04b4b74 r6:c0186d40 r5:c04b200c r4:00053175

> 
> -Prasant J
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
