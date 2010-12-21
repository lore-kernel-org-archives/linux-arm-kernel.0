From: damjan.marion@gmail.com (Damjan Marion)
Date: Tue, 21 Dec 2010 12:26:39 +0100
Subject: Help with cleaning CNS21xx code
Message-ID: <EDE16191-967E-4BBA-A398-EDCBEC4A7A2B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Cavium Networks provided SDK for CNS21XX SoCs which is actually patched 2.6.24 kernel.
It is Faraday FA526 based platform with some embedded peripherals (http://www.caviumnetworks.com/ECONA_CNS2XXX.html).
I'm trying to clean up the code and submit this as a new architecture, and I have few issues.
Seems that they patched some common code, and this doesn't look to me like something what I should do.

I will appreciate any comments/hints how to address it. Diffs are below and here is summary:

1. modification of irq_handler when VIC is enabled [arch/arm/kernel/entry-armv.S] 
2. redefinition of PROCINFO_INITFUNC=12 in [arch/arm/kernel/head.S]
3. 4 extra nops in __turn_mmu_on in [arch/arm/kernel/head.S]
4. excluded code [drivers/usb/core/buffer.c]
5. 250ms delay in ehci_run [drivers/usb/host/ehci-hcd.c]


Excuse me if asking obvious things. I'm still kernel newbie.

Thanks,

Damjan

--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -31,6 +31,11 @@
  */
 	.macro	irq_handler
 	get_irqnr_preamble r5, lr
+#ifdef CONFIG_VIC_INTERRUPT
+	get_irqnr_and_base r0, r6, r5, lr
+	mov	r1, sp
+	bl	asm_do_IRQ
+#else
 1:	get_irqnr_and_base r0, r6, r5, lr
 	movne	r1, sp
 	@
@@ -38,6 +43,7 @@
 	@
 	adrne	lr, BSYM(1b)
 	bne	asm_do_IRQ
+#endif


--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -26,6 +26,10 @@
 #include <mach/debug-macro.S>
 #endif
 
+#ifdef CONFIG_ARCH_CNS21XX
+#define PROCINFO_INITFUNC	12
+#endif
+
 #if (PHYS_OFFSET & 0x001fffff)
 #error "PHYS_OFFSET must be at an even 2MiB boundary!"
 #endif
@@ -377,6 +381,12 @@ ENDPROC(__enable_mmu)
 __turn_mmu_on:
 	mov	r0, r0
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
+#ifdef CONFIG_ARCH_CNS21XX
+	nop
+	nop
+	nop
+	nop
+#endif	
 	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
 	mov	r3, r3
 	mov	r3, r13


--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -53,9 +53,11 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int 		i, size;
 
+#if !defined(CONFIG_ARCH_CNS21XX)
 	if (!hcd->self.controller->dma_mask &&
 	    !(hcd->driver->flags & HCD_LOCAL_MEM))
 		return 0;
+#endif
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
 		size = pool_max[i];


--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -725,6 +725,15 @@ static int ehci_run (struct usb_hcd *hcd)
 	up_write(&ehci_cf_port_reset_rwsem);
 	ehci->last_periodic_enable = ktime_get_real();
 
+#ifdef CONFIG_ARCH_CNS21XX
+	/*
+	 * To prevent high speed device being recognized to full speed device,
+	 * need to add this delay. If this 250 ms delay removed, there are
+	 * 20% probability connect as full speed device when plug a hogh speed
+	 * device.
+	 */
+	mdelay(250);
+#endif
 	temp = HC_VERSION(ehci_readl(ehci, &ehci->caps->hc_capbase));
 	ehci_info (ehci,
 		"USB %x.%x started, EHCI %x.%02x%s\n",
@@ -766,7 +775,11 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 	masked_status = status & INTR_MASK;
 	if (!masked_status) {		/* irq sharing? */
 		spin_unlock(&ehci->lock);
+#ifdef CONFIG_VIC_INTERRUPT
+		return IRQ_HANDLED;
+#else
 		return IRQ_NONE;
+#endif
 	}
 
 	/* clear (just) interrupts */
