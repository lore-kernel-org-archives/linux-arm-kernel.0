From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 6 Dec 2010 17:31:46 +0800
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <20101206080606.GA29563@n2100.arm.linux.org.uk>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 4:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 06, 2010 at 02:12:54PM +0800, Eric Miao wrote:
>> On Sun, Dec 5, 2010 at 5:23 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Nov 22, 2010 at 04:26:50PM +0800, Eric Miao wrote:
>> >> I wonder if it's still acceptable for a patch like below to have a dynamic IRQ
>> >> handler at run-time. There is some changes to the irq_handler, esp. some
>> >> SMP changes.
>> >>
>> >> Magnus had some similar patches to have a run-time irq_handler, which is
>> >> a bit more complicated, but I'm also very happy with.
>> >
>> > I'd prefer a simple but efficient approach. ?I am worried about
>> > unnecessarily increasing the IRQ latency - and IRQ latency is something
>> > that we should be concerned about. ?It has the ability to make platforms
>> > useless.
>> >
>> > Eg, we know that SMC91x net interfaces are sensitive to IRQ latency, and
>> > the same is true of serial ports with small FIFOs.
>> >
>> > Any attempt to support multiple IRQ handlers is going to increase IRQ
>> > handling latency - I don't think that's something which can be avoided,
>> > and I'm wondering what effect this and the recent genirq changes is going
>> > to have. ?Has anyone been keeping an eye on IRQ handling latency?
>> >
>> > Lastly, this patch is dependent on your machine class patches, which makes
>> > it unsuitable as-is for mainline.
>> >
>>
>> This one isn't. I've rebased this on top of v2.6.37-rc1.
>>
>> >> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>> >> + ? ? handle_arch_irq = class ? class->handle_irq : NULL;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ^^^^^^^^^^^^^^^^^^^^^^^^^
>

Grrrr... wrong copy indeed. Corrected version below, I also made it less
intrusive by judging on handle_arch_irq being NULL or not so to fall back
to the original way of handling.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..0cecffb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1017,6 +1017,11 @@ config CPU_HAS_PMU
 	default y
 	bool

+config MULTI_IRQ_HANDLER
+	bool
+	help
+	  Allow each machine to specify it's own IRQ handler at run time.
+
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index d97a964..7d55356 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -40,6 +40,9 @@ struct machine_desc {
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
 	void			(*init_machine)(void);
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	void			(*handle_irq)(struct pt_regs *);
+#endif
 };

 /*
diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index ce3eee9..6ecdad9 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -22,6 +22,10 @@ extern void (*init_arch_irq)(void);
 extern void init_FIQ(void);
 extern int show_fiq_list(struct seq_file *, void *);

+#ifdef CONFIG_MULTI_IRQ_HANDLER
+extern void (*handle_arch_irq)(struct pt_regs *);
+#endif
+
 /*
  * This is for easy migration, but should be changed in the source
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..4f446a2 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -30,6 +30,13 @@
  * Interrupt handling.  Preserves r7, r8, r9
  */
 	.macro	irq_handler
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	ldr	r1, =handle_arch_irq
+	cmp	r1, #0
+	movne	r0, sp
+	adrne	lr, BSYM(9997f)
+	ldrne	pc, [r1]
+#endif
 	get_irqnr_preamble r5, lr
 1:	get_irqnr_and_base r0, r6, r5, lr
 	movne	r1, sp
@@ -1245,3 +1252,9 @@ cr_alignment:
 	.space	4
 cr_no_alignment:
 	.space	4
+
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.globl	handle_arch_irq
+handle_arch_irq:
+	.long	0
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..b809521 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -875,6 +875,9 @@ void __init setup_arch(char **cmdline_p)
 	init_arch_irq = mdesc->init_irq;
 	system_timer = mdesc->timer;
 	init_machine = mdesc->init_machine;
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	handle_arch_irq = mdesc->handle_irq;
+#endif

 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
