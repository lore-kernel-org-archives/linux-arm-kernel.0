From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 7 Feb 2012 18:03:14 +0100 (CET)
Subject: [PATCH] genirq: Fix race condition in ONESHOT irq handler
In-Reply-To: <1328621921-17404-1-git-send-email-LW@KARO-electronics.de>
References: <4F31220A.2050708@metafoo.de>
 <1328621921-17404-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <alpine.LFD.2.02.1202071719340.2794@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Feb 2012, Lothar Wa?mann wrote:

> There is a race condition in the threaded IRQ handler code for oneshot
> interrupts that may lead to disabling an IRQ indefinitely. IRQs are
> masked before calling the hard-irq handler and are unmasked only after
> the soft-irq handler has been run. Thus if the hard-irq handler
> returns IRQ_HANDLED instead of IRQ_WAKE_THREAD, meaning the soft-irq

Well, oneshot mode interrupts always had the semantics that the
threaded handler needs to run unconditionally. In fact the oneshot
mode was implemented to handle hardware which cannot do anything in
hard interrupt context to avoid the ugliness of a primary handler
calling disable_irq_nosync().

So it looks like driver developers decided that the oneshot mode might
be interesting with a primary handler as well. I can see the reason
why the tsc2007 driver uses it, but that does not make it a bug in the
core code in the first place.

Though we should handle it and the problem not only arises with the
IRQ_HANDLED return code, it also arises with IRQ_NONE.

> will not be called, the interrupt will remain masked forever.
> 
> This can happen due to a short pulse on the interrupt line, that
> triggers the interrupt logic, but goes undetected by the hard-irq
> handler. The problem can be reproduced with the TSC2007 touch
> controller driver that uses ONESHOT interrupts.

It should not return IRQ_HANDLED in that case, as the real thing is a
spurious interrupt.
 
> The problem arises also with interrupt controllers that latch a level
> triggered IRQ until it is acknowledged (like the i.MX28 does).
> In this case the IRQ status bit will remain asserted after the
> soft-irq finishes and retrigger the interrupt while the interrupt line
> is already deasserted.

This does not make sense. We acknowledge interrupts via mask_ack_irq()
right on entry of handle_level_irq(). So either the interrupt
controller is completely hosed or this explanation is bogus.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  kernel/irq/chip.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index f7c543a..74fdef9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -343,6 +343,8 @@ EXPORT_SYMBOL_GPL(handle_simple_irq);
>  void
>  handle_level_irq(unsigned int irq, struct irq_desc *desc)
>  {
> +	irqreturn_t ret;
> +
>  	raw_spin_lock(&desc->lock);
>  	mask_ack_irq(desc);
>  
> @@ -360,10 +362,13 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
>  	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
>  		goto out_unlock;
>  
> -	handle_irq_event(desc);
> +	ret = handle_irq_event(desc);
>  
> -	if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
> +	if (!irqd_irq_disabled(&desc->irq_data) &&
> +			(!(desc->istate & IRQS_ONESHOT) ||
> +				!(ret & IRQ_WAKE_THREAD)))

Hmm, that looks ugly and it misses the same fixup for
handle_fasteoi_irq() including proper comments.

The following patch should address both cases.

Thanks,

	tglx

===================================================================
--- linux-3.2.orig/kernel/irq/chip.c +++ linux-3.2/kernel/irq/chip.c
@@ -330,6 +330,24 @@ out_unlock: }
EXPORT_SYMBOL_GPL(handle_simple_irq);
 
+/*
+ * Called unconditionally from handle_level_irq() and only for oneshot
+ * interrupts from handle_fasteoi_irq()
+ */
+static void cond_unmask_irq(struct irq_desc *desc)
+{
+	/*
+	 * We need to unmask in the following cases:
+	 * - Standard level irq (IRQF_ONESHOT is not set)
+	 * - Oneshot irq which did not wake the thread (caused by a
+	 *   spurious interrupt or a primary handler handling it
+	 *   completely).
+	 */
+	if (!irqd_irq_disabled(&desc->irq_data) &&
+	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot)
+		unmask_irq(desc);
+}
+
 /**
  *	handle_level_irq - Level type irq handler
  *	@irq:	the interrupt number
@@ -362,8 +380,8 @@ handle_level_irq(unsigned int irq, struc
 
 	handle_irq_event(desc);
 
-	if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
-		unmask_irq(desc);
+	cond_unmask_irq(desc);
+
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
@@ -417,6 +435,9 @@ handle_fasteoi_irq(unsigned int irq, str
 	preflow_handler(desc);
 	handle_irq_event(desc);
 
+	if (desc->istate & IRQS_ONESHOT)
+		cond_unmask_irq(desc);
+
 out_eoi:
 	desc->irq_data.chip->irq_eoi(&desc->irq_data);
 out_unlock:
