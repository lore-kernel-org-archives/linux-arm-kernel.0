From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 14 Nov 2011 22:19:44 +0900
Subject: [PATCH v2] ARM: gic: fix irq_alloc_descs handling for sparse irq
In-Reply-To: <1319466969-5034-1-git-send-email-robherring2@gmail.com>
References: <1319314808-27007-1-git-send-email-robherring2@gmail.com>
 <1319466969-5034-1-git-send-email-robherring2@gmail.com>
Message-ID: <CANqRtoQnw6dQM2MFWV0jwbXTSKNLD0Tipv9+pdje1ki3bbPuCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 11:36 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Commit "ARM: gic: add irq_domain support" (2071a2a4b8ed5292) broke SPARSE_IRQ
> on platforms with GIC. When SPARSE_IRQ is enabled, all NR_IRQS or
> mach_desc->nr_irqs will be allocated by arch_probe_nr_irqs(). This caused
> irq_alloc_descs to allocate irq_descs after the pre-allocated space.
>
> Make irq_alloc_descs search for an exact irq range and assume it has
> been pre-allocated on failure. For DT probing dynamic allocation is used.
> DT enabled platforms should set their nr_irqs to NR_IRQ_LEGACY and have all
> irq_chips allocate their irq_descs with irq_alloc_descs if SPARSE_IRQ is
> enabled.
>
> gic_init irq_start param is changed to be signed with negative meaning do
> dynamic Linux irq assigment.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> v2:
> ?- make irq_start signed

Hi Rob,

[Added Paul Mundt as CC]

Thanks for your work on improving the GIC code. I tested latest 3.2-rc
on some of our GIC platforms without DT earlier today and I ran into
some issues that I believe are related to the following commit:

f37a53c ARM: gic: fix irq_alloc_descs handling for sparse irq

With this patch included I get the following warning on SH-Mobile
AG5EVM and Kota2:

NR_IRQS:1024 nr_irqs:1024 1024
------------[ cut here ]------------
WARNING: at arch/arm/common/gic.c:607 gic_init+0x90/0x2e4()
Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
[<c000c868>] (unwind_backtrace+0x0/0xe0) from [<c001857c>] (warn_slowpath_commo)
[<c001857c>] (warn_slowpath_common+0x48/0x60) from [<c00185d8>] (warn_slowpath_)
[<c00185d8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c029ee08>] (gic_init+0x90/0x2)
[<c029ee08>] (gic_init+0x90/0x2e4) from [<c029f278>] (sh73a0_init_irq+0x30/0x18)
[<c029f278>] (sh73a0_init_irq+0x30/0x184) from [<c029c0b4>] (init_IRQ+0x14/0x1c)
[<c029c0b4>] (init_IRQ+0x14/0x1c) from [<c029a5cc>] (start_kernel+0x15c/0x2b8)
[<c029a5cc>] (start_kernel+0x15c/0x2b8) from [<4000803c>] (0x4000803c)
---[ end trace 1b75b31a2719ed1c ]---

The sh73a0 used on the AG5EVM board has a bunch of interrupt
controllers, but the GIC is initialized first.

As you can see by the printout above "nr_irqs" is set to 1024, but I
believe this may be a misconfiguration on my side. Or perhaps it's the
ARM default that needs to be adjusted, because it's certainly not
behaving like other architectures such as x86 and SH.

The x86 and SH implementations of sparse IRQ seem to return
NR_IRQS_LEGACY from arch_probe_nr_irqs(), but on ARM we default to
NR_IRQS unless the machine descriptor gives a different hint.

I could easily "fix" my platform by making it behave like x86 and SH:
--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-11-14
21:45:24.000000000 +0900
@@ -607,6 +607,7 @@ struct sys_timer ag5evm_timer = {

 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= ag5evm_map_io,
+	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
 	.init_machine	= ag5evm_init,

The above code makes sure that only 16 interrupts are reserved early
on, so the warning disappears and the nr_irqs is different:
NR_IRQS:1024 nr_irqs:16 16

I do however wonder if the ARM default is sane. Perhaps it is, but
just to experiment I decided to modify the common ARM code like this:
--- 0001/arch/arm/kernel/irq.c
+++ work/arch/arm/kernel/irq.c	2011-11-14 22:06:02.000000000 +0900
@@ -130,7 +130,7 @@ void __init init_IRQ(void)
 int __init arch_probe_nr_irqs(void)
 {
 	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	return NR_IRQS_LEGACY;
 }
 #endif

With the patch above the warning printout is disappeared and the
nr_irqs message is slightly different:
NR_IRQS:1024 nr_irqs:1024 16

I don't really have any strong feelings exactly how to fix this, but I
suspect that other non-DT GIC-enabled platforms will run into the same
problem unless they set .nr_irqs in their machine descriptor table.

Any ideas?

Thanks,

/ magnus
