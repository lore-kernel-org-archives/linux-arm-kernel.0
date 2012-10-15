From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 15 Oct 2012 14:51:25 -0700
Subject: [PATCH 01/10] ARM: mach-rpc: Don't register FIQs with genirq
In-Reply-To: <20121015214954.GA3352@lizard>
References: <20121015214954.GA3352@lizard>
Message-ID: <1350337894-9744-1-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-rps registers FIQ controller with genirq, which makes no sense:
these FIQs cannot be routed to IRQs, so there is no need to register
it with genirq.

This effectively makes FIQ_START irrelevant.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/mach-rpc/dma.c               |  4 ++--
 arch/arm/mach-rpc/include/mach/irqs.h |  5 +++++
 arch/arm/mach-rpc/irq.c               | 19 ++++---------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 85883b2..4a525be 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -289,13 +289,13 @@ static void floppy_enable_dma(unsigned int chan, dma_t *dma)
 
 	set_fiq_handler(fiqhandler_start, fiqhandler_length);
 	set_fiq_regs(&regs);
-	enable_fiq(fdma->fiq);
+	iomd_unmask_fiq(fdma->fiq);
 }
 
 static void floppy_disable_dma(unsigned int chan, dma_t *dma)
 {
 	struct floppy_dma *fdma = container_of(dma, struct floppy_dma, dma);
-	disable_fiq(fdma->fiq);
+	iomd_mask_fiq(fdma->fiq);
 	release_fiq(&fh);
 }
 
diff --git a/arch/arm/mach-rpc/include/mach/irqs.h b/arch/arm/mach-rpc/include/mach/irqs.h
index 6868e17..f27ead1 100644
--- a/arch/arm/mach-rpc/include/mach/irqs.h
+++ b/arch/arm/mach-rpc/include/mach/irqs.h
@@ -37,6 +37,11 @@
 #define FIQ_EXPANSIONCARD	6
 #define FIQ_FORCE		7
 
+#ifndef __ASSEMBLY__
+extern void iomd_mask_fiq(int fiq);
+extern void iomd_unmask_fiq(int fiq);
+#endif
+
 /*
  * This is the offset of the FIQ "IRQ" numbers
  */
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 3e4fa84..a4221b3 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -89,30 +89,24 @@ static struct irq_chip iomd_dma_chip = {
 	.irq_unmask	= iomd_unmask_irq_dma,
 };
 
-static void iomd_mask_irq_fiq(struct irq_data *d)
+void iomd_mask_fiq(int fiq)
 {
 	unsigned int val, mask;
 
-	mask = 1 << (d->irq & 7);
+	mask = 1 << (fiq & 7);
 	val = iomd_readb(IOMD_FIQMASK);
 	iomd_writeb(val & ~mask, IOMD_FIQMASK);
 }
 
-static void iomd_unmask_irq_fiq(struct irq_data *d)
+void iomd_unmask_fiq(int fiq)
 {
 	unsigned int val, mask;
 
-	mask = 1 << (d->irq & 7);
+	mask = 1 << (fiq & 7);
 	val = iomd_readb(IOMD_FIQMASK);
 	iomd_writeb(val | mask, IOMD_FIQMASK);
 }
 
-static struct irq_chip iomd_fiq_chip = {
-	.irq_ack	= iomd_mask_irq_fiq,
-	.irq_mask	= iomd_mask_irq_fiq,
-	.irq_unmask	= iomd_unmask_irq_fiq,
-};
-
 extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
 
 void __init rpc_init_irq(void)
@@ -155,11 +149,6 @@ void __init rpc_init_irq(void)
 						 handle_level_irq);
 			set_irq_flags(irq, flags);
 			break;
-
-		case 64 ... 71:
-			irq_set_chip(irq, &iomd_fiq_chip);
-			set_irq_flags(irq, IRQF_VALID);
-			break;
 		}
 	}
 
-- 
1.7.12.3
