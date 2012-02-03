From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:59:17 +0000
Subject: [PATCH 14/20] ARM: sa1111: move PCMCIA interface register
 definitions to sa1111_generic.c
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPHx-00044Z-Ak@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the PCMCIA interface register definitions into the driver, rather
than keeping them in a common place.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/sa1111.h |   45 +------------------------------
 drivers/pcmcia/sa1111_generic.c        |   44 +++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index dc15bf8..29e3e56 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -413,50 +413,9 @@
 #define SA1111_KBD		0x0a00
 #define SA1111_MSE		0x0c00
 
-/*
- * PCMCIA Interface
- *
- * Registers
- *    PCSR	Status Register
- *    PCCR	Control Register
- *    PCSSR	Sleep State Register
- */
+/* PCMCIA Interface */
+#define SA1111_PCMCIA		0x1600
 
-#define SA1111_PCMCIA	0x1600
-
-/*
- * These are offsets from the above base.
- */
-#define SA1111_PCCR	0x0000
-#define SA1111_PCSSR	0x0004
-#define SA1111_PCSR	0x0008
-
-#define PCSR_S0_READY	(1<<0)
-#define PCSR_S1_READY	(1<<1)
-#define PCSR_S0_DETECT	(1<<2)
-#define PCSR_S1_DETECT	(1<<3)
-#define PCSR_S0_VS1	(1<<4)
-#define PCSR_S0_VS2	(1<<5)
-#define PCSR_S1_VS1	(1<<6)
-#define PCSR_S1_VS2	(1<<7)
-#define PCSR_S0_WP	(1<<8)
-#define PCSR_S1_WP	(1<<9)
-#define PCSR_S0_BVD1	(1<<10)
-#define PCSR_S0_BVD2	(1<<11)
-#define PCSR_S1_BVD1	(1<<12)
-#define PCSR_S1_BVD2	(1<<13)
-
-#define PCCR_S0_RST	(1<<0)
-#define PCCR_S1_RST	(1<<1)
-#define PCCR_S0_FLT	(1<<2)
-#define PCCR_S1_FLT	(1<<3)
-#define PCCR_S0_PWAITEN	(1<<4)
-#define PCCR_S1_PWAITEN	(1<<5)
-#define PCCR_S0_PSE	(1<<6)
-#define PCCR_S1_PSE	(1<<7)
-
-#define PCSSR_S0_SLEEP	(1<<0)
-#define PCSSR_S1_SLEEP	(1<<1)
 
 
 
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 0735c3e..33568e1 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -22,6 +22,40 @@
 
 #include "sa1111_generic.h"
 
+/*
+ * These are offsets from the above base.
+ */
+#define PCCR	0x0000
+#define PCSSR	0x0004
+#define PCSR	0x0008
+
+#define PCSR_S0_READY	(1<<0)
+#define PCSR_S1_READY	(1<<1)
+#define PCSR_S0_DETECT	(1<<2)
+#define PCSR_S1_DETECT	(1<<3)
+#define PCSR_S0_VS1	(1<<4)
+#define PCSR_S0_VS2	(1<<5)
+#define PCSR_S1_VS1	(1<<6)
+#define PCSR_S1_VS2	(1<<7)
+#define PCSR_S0_WP	(1<<8)
+#define PCSR_S1_WP	(1<<9)
+#define PCSR_S0_BVD1	(1<<10)
+#define PCSR_S0_BVD2	(1<<11)
+#define PCSR_S1_BVD1	(1<<12)
+#define PCSR_S1_BVD2	(1<<13)
+
+#define PCCR_S0_RST	(1<<0)
+#define PCCR_S1_RST	(1<<1)
+#define PCCR_S0_FLT	(1<<2)
+#define PCCR_S1_FLT	(1<<3)
+#define PCCR_S0_PWAITEN	(1<<4)
+#define PCCR_S1_PWAITEN	(1<<5)
+#define PCCR_S0_PSE	(1<<6)
+#define PCCR_S1_PSE	(1<<7)
+
+#define PCSSR_S0_SLEEP	(1<<0)
+#define PCSSR_S1_SLEEP	(1<<1)
+
 #define IDX_IRQ_S0_READY_NINT	(0)
 #define IDX_IRQ_S0_CD_VALID	(1)
 #define IDX_IRQ_S0_BVD1_STSCHG	(2)
@@ -49,7 +83,7 @@ static void sa1111_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
 	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned long status = sa1111_readl(s->dev->mapbase + SA1111_PCSR);
+	unsigned long status = sa1111_readl(s->dev->mapbase + PCSR);
 
 	switch (skt->nr) {
 	case 0:
@@ -105,10 +139,10 @@ int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 		pccr_set_mask |= PCCR_S0_FLT|PCCR_S1_FLT;
 
 	local_irq_save(flags);
-	val = sa1111_readl(s->dev->mapbase + SA1111_PCCR);
+	val = sa1111_readl(s->dev->mapbase + PCCR);
 	val &= ~pccr_skt_mask;
 	val |= pccr_set_mask & pccr_skt_mask;
-	sa1111_writel(val, s->dev->mapbase + SA1111_PCCR);
+	sa1111_writel(val, s->dev->mapbase + PCCR);
 	local_irq_restore(flags);
 
 	return 0;
@@ -187,8 +221,8 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 	/*
 	 * Initialise the suspend state.
 	 */
-	sa1111_writel(PCSSR_S0_SLEEP | PCSSR_S1_SLEEP, base + SA1111_PCSSR);
-	sa1111_writel(PCCR_S0_FLT | PCCR_S1_FLT, base + SA1111_PCCR);
+	sa1111_writel(PCSSR_S0_SLEEP | PCSSR_S1_SLEEP, base + PCSSR);
+	sa1111_writel(PCCR_S0_FLT | PCCR_S1_FLT, base + PCCR);
 
 #ifdef CONFIG_SA1100_BADGE4
 	pcmcia_badge4_init(&dev->dev);
-- 
1.7.4.4
