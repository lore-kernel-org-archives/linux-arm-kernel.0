From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 12 Dec 2010 22:50:14 +0800
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
	<AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
	<20101206101100.GB29563@n2100.arm.linux.org.uk>
	<AANLkTinuQWszBuA01zDkXBM5gWOsxYufWQFyqYQmOcbP@mail.gmail.com>
	<20101208134140.GB9777@n2100.arm.linux.org.uk>
	<AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
Message-ID: <AANLkTindK=GfvBGdfq+38qu7fcCi8rRv0NP1FYO4Dkyb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 10:33 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Dec 8, 2010 at 9:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Dec 07, 2010 at 09:31:11PM +0800, Eric Miao wrote:
>>> Ah silly me, the patch below fixed this, and tested on Marvell Dove:
>> ...
>>> diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
>>> index ce3eee9..6ecdad9 100644
>>> --- a/arch/arm/include/asm/mach/irq.h
>>> +++ b/arch/arm/include/asm/mach/irq.h
>>> @@ -22,6 +22,10 @@ extern void (*init_arch_irq)(void);
>>> ?extern void init_FIQ(void);
>>> ?extern int show_fiq_list(struct seq_file *, void *);
>>>
>>> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>>> +extern void (*handle_arch_irq)(struct pt_regs *);
>>> +#endif
>>> +
>>> ?/*
>>> ? * This is for easy migration, but should be changed in the source
>>> ? */
>>> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
>>> index c09e357..d29e31b 100644
>>> --- a/arch/arm/kernel/entry-armv.S
>>> +++ b/arch/arm/kernel/entry-armv.S
>>> @@ -30,6 +30,14 @@
>>> ? * Interrupt handling. ?Preserves r7, r8, r9
>>> ? */
>>> ? ? ? .macro ?irq_handler
>>> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>>> + ? ? ldr ? ? r1, =handle_arch_irq
>>> + ? ? ldr ? ? r0, [r1]
>>> + ? ? cmp ? ? r0, #0
>>> + ? ? movne ? r0, sp
>>> + ? ? adrne ? lr, BSYM(9997f)
>>> + ? ? ldrne ? pc, [r1]
>>> +#endif
>>
>> You might as well do this:
>>
>> ? ? ? ?ldr ? ? r5, =handle_arch_irq
>> ? ? ? ?mov ? ? r0, sp
>> ? ? ? ?ldr ? ? r5, [r5]
>> ? ? ? ?adr ? ? lr, BSYM(9997f)
>> ? ? ? ?teq ? ? r5, #0
>> ? ? ? ?movne ? pc, r5
>>
>> which also helps to fill the load delay slots with useful work.
>>
>>> ? ? ? get_irqnr_preamble r5, lr
>>> ?1: ? get_irqnr_and_base r0, r6, r5, lr
>>> ? ? ? movne ? r1, sp
>>> @@ -58,9 +66,8 @@
>>> ? ? ? adrne ? lr, BSYM(1b)
>>> ? ? ? bne ? ? do_local_timer
>>> ?#endif
>>> -9997:
>>> ?#endif
>>> -
>>> +9997:
>>> ? ? ? .endm
>>>
>>> ?#ifdef CONFIG_KPROBES
>>> @@ -1245,3 +1252,9 @@ cr_alignment:
>>> ? ? ? .space ?4
>>> ?cr_no_alignment:
>>> ? ? ? .space ?4
>>> +
>>> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>>> + ? ? .globl ?handle_arch_irq
>>> +handle_arch_irq:
>>> + ? ? .long ? 0
>>
>> ? ? ? ?.space 4
>>
>> as above please
>>
>
> Updated the patch following your suggestions, verified on Marvell Dove
> platform and it worked all right. Do you want me to submit this to the
> patch tracking system?
>

(ignore my last mail with the wrong patch, my brain short circuited today,
here's the updated one):

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
index c09e357..e6c08ac 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -30,6 +30,14 @@
  * Interrupt handling.  Preserves r7, r8, r9
  */
 	.macro	irq_handler
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	ldr	r5, =handle_arch_irq
+	mov	r0, sp
+	ldr	r5, [r5]
+	adr	lr, BSYM(9997f)
+	teq	r5, #0
+	movne	pc, r5
+#endif
 	get_irqnr_preamble r5, lr
 1:	get_irqnr_and_base r0, r6, r5, lr
 	movne	r1, sp
@@ -58,9 +66,8 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
-9997:
 #endif
-
+9997:
 	.endm

 #ifdef CONFIG_KPROBES
@@ -1245,3 +1252,9 @@ cr_alignment:
 	.space	4
 cr_no_alignment:
 	.space	4
+
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.globl	handle_arch_irq
+handle_arch_irq:
+	.space	4
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
