From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:07 +0800
Subject: [PATCH 6/7] [ARM] sa1111: allow cascaded IRQs to be used by platforms
In-Reply-To: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1261977488-18271-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/common/sa1111.c                 |  112 +++++++++++++++++++++++-------
 arch/arm/include/asm/hardware/sa1111.h   |    4 +
 arch/arm/mach-pxa/include/mach/irqs.h    |   54 +--------------
 arch/arm/mach-pxa/lubbock.c              |    7 ++
 arch/arm/mach-sa1100/badge4.c            |    5 ++
 arch/arm/mach-sa1100/include/mach/irqs.h |   54 +--------------
 arch/arm/mach-sa1100/jornada720.c        |    5 ++
 arch/arm/mach-sa1100/neponset.c          |    5 ++
 8 files changed, 116 insertions(+), 130 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 8ba7044..a52a27c 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -35,6 +35,58 @@
 
 #include <asm/hardware/sa1111.h>
 
+/* SA1111 IRQs */
+#define IRQ_GPAIN0		(0)
+#define IRQ_GPAIN1		(1)
+#define IRQ_GPAIN2		(2)
+#define IRQ_GPAIN3		(3)
+#define IRQ_GPBIN0		(4)
+#define IRQ_GPBIN1		(5)
+#define IRQ_GPBIN2		(6)
+#define IRQ_GPBIN3		(7)
+#define IRQ_GPBIN4		(8)
+#define IRQ_GPBIN5		(9)
+#define IRQ_GPCIN0		(10)
+#define IRQ_GPCIN1		(11)
+#define IRQ_GPCIN2		(12)
+#define IRQ_GPCIN3		(13)
+#define IRQ_GPCIN4		(14)
+#define IRQ_GPCIN5		(15)
+#define IRQ_GPCIN6		(16)
+#define IRQ_GPCIN7		(17)
+#define IRQ_MSTXINT		(18)
+#define IRQ_MSRXINT		(19)
+#define IRQ_MSSTOPERRINT	(20)
+#define IRQ_TPTXINT		(21)
+#define IRQ_TPRXINT		(22)
+#define IRQ_TPSTOPERRINT	(23)
+#define SSPXMTINT		(24)
+#define SSPRCVINT		(25)
+#define SSPROR			(26)
+#define AUDXMTDMADONEA		(32)
+#define AUDRCVDMADONEA		(33)
+#define AUDXMTDMADONEB		(34)
+#define AUDRCVDMADONEB		(35)
+#define AUDTFSR			(36)
+#define AUDRFSR			(37)
+#define AUDTUR			(38)
+#define AUDROR			(39)
+#define AUDDTS			(40)
+#define AUDRDD			(41)
+#define AUDSTO			(42)
+#define IRQ_USBPWR		(43)
+#define IRQ_HCIM		(44)
+#define IRQ_HCIBUFFACC		(45)
+#define IRQ_HCIRMTWKP		(46)
+#define IRQ_NHCIMFCIR		(47)
+#define IRQ_USB_PORT_RESUME	(48)
+#define IRQ_S0_READY_NINT	(49)
+#define IRQ_S1_READY_NINT	(50)
+#define IRQ_S0_CD_VALID		(51)
+#define IRQ_S1_CD_VALID		(52)
+#define IRQ_S0_BVD1_STSCHG	(53)
+#define IRQ_S1_BVD1_STSCHG	(54)
+
 extern void __init sa1110_mb_enable(void);
 
 /*
@@ -49,6 +101,7 @@ struct sa1111 {
 	struct clk	*clk;
 	unsigned long	phys;
 	int		irq;
+	int		irq_base;	/* base for cascaded on-chip IRQs */
 	spinlock_t	lock;
 	void __iomem	*base;
 #ifdef CONFIG_PM
@@ -152,36 +205,37 @@ static void
 sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int stat0, stat1, i;
-	void __iomem *base = get_irq_data(irq);
+	struct sa1111 *sachip = get_irq_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 
-	stat0 = sa1111_readl(base + SA1111_INTSTATCLR0);
-	stat1 = sa1111_readl(base + SA1111_INTSTATCLR1);
+	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);
+	stat1 = sa1111_readl(mapbase + SA1111_INTSTATCLR1);
 
-	sa1111_writel(stat0, base + SA1111_INTSTATCLR0);
+	sa1111_writel(stat0, mapbase + SA1111_INTSTATCLR0);
 
 	desc->chip->ack(irq);
 
-	sa1111_writel(stat1, base + SA1111_INTSTATCLR1);
+	sa1111_writel(stat1, mapbase + SA1111_INTSTATCLR1);
 
 	if (stat0 == 0 && stat1 == 0) {
 		do_bad_IRQ(irq, desc);
 		return;
 	}
 
-	for (i = IRQ_SA1111_START; stat0; i++, stat0 >>= 1)
+	for (i = 0; stat0; i++, stat0 >>= 1)
 		if (stat0 & 1)
-			handle_edge_irq(i, irq_desc + i);
+			generic_handle_irq(i + sachip->irq_base);
 
-	for (i = IRQ_SA1111_START + 32; stat1; i++, stat1 >>= 1)
+	for (i = 32; stat1; i++, stat1 >>= 1)
 		if (stat1 & 1)
-			handle_edge_irq(i, irq_desc + i);
+			generic_handle_irq(i + sachip->irq_base);
 
 	/* For level-based interrupts */
 	desc->chip->unmask(irq);
 }
 
-#define SA1111_IRQMASK_LO(x)	(1 << (x - IRQ_SA1111_START))
-#define SA1111_IRQMASK_HI(x)	(1 << (x - IRQ_SA1111_START - 32))
+#define SA1111_IRQMASK_LO(x)	(1 << (x - sachip->irq_base))
+#define SA1111_IRQMASK_HI(x)	(1 << (x - sachip->irq_base - 32))
 
 static void sa1111_ack_irq(unsigned int irq)
 {
@@ -189,7 +243,8 @@ static void sa1111_ack_irq(unsigned int irq)
 
 static void sa1111_mask_lowirq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie0;
 
 	ie0 = sa1111_readl(mapbase + SA1111_INTEN0);
@@ -199,7 +254,8 @@ static void sa1111_mask_lowirq(unsigned int irq)
 
 static void sa1111_unmask_lowirq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie0;
 
 	ie0 = sa1111_readl(mapbase + SA1111_INTEN0);
@@ -216,8 +272,9 @@ static void sa1111_unmask_lowirq(unsigned int irq)
  */
 static int sa1111_retrigger_lowirq(unsigned int irq)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_LO(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long ip0;
 	int i;
 
@@ -237,8 +294,9 @@ static int sa1111_retrigger_lowirq(unsigned int irq)
 
 static int sa1111_type_lowirq(unsigned int irq, unsigned int flags)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_LO(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long ip0;
 
 	if (flags == IRQ_TYPE_PROBE)
@@ -260,8 +318,9 @@ static int sa1111_type_lowirq(unsigned int irq, unsigned int flags)
 
 static int sa1111_wake_lowirq(unsigned int irq, unsigned int on)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_LO(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long we0;
 
 	we0 = sa1111_readl(mapbase + SA1111_WAKEEN0);
@@ -286,7 +345,8 @@ static struct irq_chip sa1111_low_chip = {
 
 static void sa1111_mask_highirq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie1;
 
 	ie1 = sa1111_readl(mapbase + SA1111_INTEN1);
@@ -296,7 +356,8 @@ static void sa1111_mask_highirq(unsigned int irq)
 
 static void sa1111_unmask_highirq(unsigned int irq)
 {
-	void __iomem *mapbase = get_irq_chip_data(irq);
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie1;
 
 	ie1 = sa1111_readl(mapbase + SA1111_INTEN1);
@@ -313,8 +374,9 @@ static void sa1111_unmask_highirq(unsigned int irq)
  */
 static int sa1111_retrigger_highirq(unsigned int irq)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_HI(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long ip1;
 	int i;
 
@@ -334,8 +396,9 @@ static int sa1111_retrigger_highirq(unsigned int irq)
 
 static int sa1111_type_highirq(unsigned int irq, unsigned int flags)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_HI(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long ip1;
 
 	if (flags == IRQ_TYPE_PROBE)
@@ -357,8 +420,9 @@ static int sa1111_type_highirq(unsigned int irq, unsigned int flags)
 
 static int sa1111_wake_highirq(unsigned int irq, unsigned int on)
 {
+	struct sa1111 *sachip = get_irq_chip_data(irq);
+	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned int mask = SA1111_IRQMASK_HI(irq);
-	void __iomem *mapbase = get_irq_chip_data(irq);
 	unsigned long we1;
 
 	we1 = sa1111_readl(mapbase + SA1111_WAKEEN1);
@@ -412,14 +476,14 @@ static void sa1111_setup_irq(struct sa1111 *sachip)
 
 	for (irq = IRQ_GPAIN0; irq <= SSPROR; irq++) {
 		set_irq_chip(irq, &sa1111_low_chip);
-		set_irq_chip_data(irq, irqbase);
+		set_irq_chip_data(irq, sachip);
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
 	for (irq = AUDXMTDMADONEA; irq <= IRQ_S1_BVD1_STSCHG; irq++) {
 		set_irq_chip(irq, &sa1111_high_chip);
-		set_irq_chip_data(irq, irqbase);
+		set_irq_chip_data(irq, sachip);
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
@@ -428,7 +492,7 @@ static void sa1111_setup_irq(struct sa1111 *sachip)
 	 * Register SA1111 interrupt
 	 */
 	set_irq_type(sachip->irq, IRQ_TYPE_EDGE_RISING);
-	set_irq_data(sachip->irq, irqbase);
+	set_irq_data(sachip->irq, sachip);
 	set_irq_chained_handler(sachip->irq, sa1111_irq_handler);
 }
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 5da2595..92ed254 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -578,4 +578,8 @@ void sa1111_set_io_dir(struct sa1111_dev *sadev, unsigned int bits, unsigned int
 void sa1111_set_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v);
 void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v);
 
+struct sa1111_platform_data {
+	int	irq_base;	/* base for cascaded on-chip IRQs */
+};
+
 #endif  /* _ASM_ARCH_SA1111 */
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 83b14f1..b35b3ac 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -135,58 +135,6 @@
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
 #endif
 
-#define IRQ_SA1111_START	(IRQ_BOARD_END)
-#define IRQ_GPAIN0		(IRQ_BOARD_END + 0)
-#define IRQ_GPAIN1		(IRQ_BOARD_END + 1)
-#define IRQ_GPAIN2		(IRQ_BOARD_END + 2)
-#define IRQ_GPAIN3		(IRQ_BOARD_END + 3)
-#define IRQ_GPBIN0		(IRQ_BOARD_END + 4)
-#define IRQ_GPBIN1		(IRQ_BOARD_END + 5)
-#define IRQ_GPBIN2		(IRQ_BOARD_END + 6)
-#define IRQ_GPBIN3		(IRQ_BOARD_END + 7)
-#define IRQ_GPBIN4		(IRQ_BOARD_END + 8)
-#define IRQ_GPBIN5		(IRQ_BOARD_END + 9)
-#define IRQ_GPCIN0		(IRQ_BOARD_END + 10)
-#define IRQ_GPCIN1		(IRQ_BOARD_END + 11)
-#define IRQ_GPCIN2		(IRQ_BOARD_END + 12)
-#define IRQ_GPCIN3		(IRQ_BOARD_END + 13)
-#define IRQ_GPCIN4		(IRQ_BOARD_END + 14)
-#define IRQ_GPCIN5		(IRQ_BOARD_END + 15)
-#define IRQ_GPCIN6		(IRQ_BOARD_END + 16)
-#define IRQ_GPCIN7		(IRQ_BOARD_END + 17)
-#define IRQ_MSTXINT		(IRQ_BOARD_END + 18)
-#define IRQ_MSRXINT		(IRQ_BOARD_END + 19)
-#define IRQ_MSSTOPERRINT	(IRQ_BOARD_END + 20)
-#define IRQ_TPTXINT		(IRQ_BOARD_END + 21)
-#define IRQ_TPRXINT		(IRQ_BOARD_END + 22)
-#define IRQ_TPSTOPERRINT	(IRQ_BOARD_END + 23)
-#define SSPXMTINT		(IRQ_BOARD_END + 24)
-#define SSPRCVINT		(IRQ_BOARD_END + 25)
-#define SSPROR			(IRQ_BOARD_END + 26)
-#define AUDXMTDMADONEA		(IRQ_BOARD_END + 32)
-#define AUDRCVDMADONEA		(IRQ_BOARD_END + 33)
-#define AUDXMTDMADONEB		(IRQ_BOARD_END + 34)
-#define AUDRCVDMADONEB		(IRQ_BOARD_END + 35)
-#define AUDTFSR			(IRQ_BOARD_END + 36)
-#define AUDRFSR			(IRQ_BOARD_END + 37)
-#define AUDTUR			(IRQ_BOARD_END + 38)
-#define AUDROR			(IRQ_BOARD_END + 39)
-#define AUDDTS			(IRQ_BOARD_END + 40)
-#define AUDRDD			(IRQ_BOARD_END + 41)
-#define AUDSTO			(IRQ_BOARD_END + 42)
-#define IRQ_USBPWR		(IRQ_BOARD_END + 43)
-#define IRQ_HCIM		(IRQ_BOARD_END + 44)
-#define IRQ_HCIBUFFACC		(IRQ_BOARD_END + 45)
-#define IRQ_HCIRMTWKP		(IRQ_BOARD_END + 46)
-#define IRQ_NHCIMFCIR		(IRQ_BOARD_END + 47)
-#define IRQ_USB_PORT_RESUME	(IRQ_BOARD_END + 48)
-#define IRQ_S0_READY_NINT	(IRQ_BOARD_END + 49)
-#define IRQ_S1_READY_NINT	(IRQ_BOARD_END + 50)
-#define IRQ_S0_CD_VALID		(IRQ_BOARD_END + 51)
-#define IRQ_S1_CD_VALID		(IRQ_BOARD_END + 52)
-#define IRQ_S0_BVD1_STSCHG	(IRQ_BOARD_END + 53)
-#define IRQ_S1_BVD1_STSCHG	(IRQ_BOARD_END + 54)
-
 /*
  * Figure out the MAX IRQ number.
  *
@@ -195,7 +143,7 @@
  * Otherwise, we have the standard IRQs only.
  */
 #ifdef CONFIG_SA1111
-#define NR_IRQS			(IRQ_S1_BVD1_STSCHG + 1)
+#define NR_IRQS			(IRQ_BOARD_END + 55)
 #elif defined(CONFIG_PXA_HAVE_BOARD_IRQS)
 #define NR_IRQS			(IRQ_BOARD_END)
 #else
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 98ee7e5..c8b9bd8 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -240,11 +240,18 @@ static struct resource sa1111_resources[] = {
 	},
 };
 
+static struct sa1111_platform_data sa1111_info = {
+	.irq_base	= IRQ_BOARD_END,
+};
+
 static struct platform_device sa1111_device = {
 	.name		= "sa1111",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(sa1111_resources),
 	.resource	= sa1111_resources,
+	.dev		= {
+		.platform_data	= &sa1111_info,
+	},
 };
 
 /* ADS7846 is connected through SSP ... and if your board has J5 populated,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 051ec0f..259cb2c 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -51,6 +51,10 @@ static struct resource sa1111_resources[] = {
 	},
 };
 
+static struct sa1111_platform_data sa1111_info = {
+	.irq_base	= IRQ_BOARD_END,
+};
+
 static u64 sa1111_dmamask = 0xffffffffUL;
 
 static struct platform_device sa1111_device = {
@@ -59,6 +63,7 @@ static struct platform_device sa1111_device = {
 	.dev		= {
 		.dma_mask = &sa1111_dmamask,
 		.coherent_dma_mask = 0xffffffff,
+		.platform_data = &sa1111_info,
 	},
 	.num_resources	= ARRAY_SIZE(sa1111_resources),
 	.resource	= sa1111_resources,
diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index bc67722..daf74dc 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -68,58 +68,6 @@
 #define IRQ_BOARD_START		49
 #define IRQ_BOARD_END		65
 
-#define IRQ_SA1111_START	(IRQ_BOARD_END)
-#define IRQ_GPAIN0		(IRQ_BOARD_END + 0)
-#define IRQ_GPAIN1		(IRQ_BOARD_END + 1)
-#define IRQ_GPAIN2		(IRQ_BOARD_END + 2)
-#define IRQ_GPAIN3		(IRQ_BOARD_END + 3)
-#define IRQ_GPBIN0		(IRQ_BOARD_END + 4)
-#define IRQ_GPBIN1		(IRQ_BOARD_END + 5)
-#define IRQ_GPBIN2		(IRQ_BOARD_END + 6)
-#define IRQ_GPBIN3		(IRQ_BOARD_END + 7)
-#define IRQ_GPBIN4		(IRQ_BOARD_END + 8)
-#define IRQ_GPBIN5		(IRQ_BOARD_END + 9)
-#define IRQ_GPCIN0		(IRQ_BOARD_END + 10)
-#define IRQ_GPCIN1		(IRQ_BOARD_END + 11)
-#define IRQ_GPCIN2		(IRQ_BOARD_END + 12)
-#define IRQ_GPCIN3		(IRQ_BOARD_END + 13)
-#define IRQ_GPCIN4		(IRQ_BOARD_END + 14)
-#define IRQ_GPCIN5		(IRQ_BOARD_END + 15)
-#define IRQ_GPCIN6		(IRQ_BOARD_END + 16)
-#define IRQ_GPCIN7		(IRQ_BOARD_END + 17)
-#define IRQ_MSTXINT		(IRQ_BOARD_END + 18)
-#define IRQ_MSRXINT		(IRQ_BOARD_END + 19)
-#define IRQ_MSSTOPERRINT	(IRQ_BOARD_END + 20)
-#define IRQ_TPTXINT		(IRQ_BOARD_END + 21)
-#define IRQ_TPRXINT		(IRQ_BOARD_END + 22)
-#define IRQ_TPSTOPERRINT	(IRQ_BOARD_END + 23)
-#define SSPXMTINT		(IRQ_BOARD_END + 24)
-#define SSPRCVINT		(IRQ_BOARD_END + 25)
-#define SSPROR			(IRQ_BOARD_END + 26)
-#define AUDXMTDMADONEA		(IRQ_BOARD_END + 32)
-#define AUDRCVDMADONEA		(IRQ_BOARD_END + 33)
-#define AUDXMTDMADONEB		(IRQ_BOARD_END + 34)
-#define AUDRCVDMADONEB		(IRQ_BOARD_END + 35)
-#define AUDTFSR			(IRQ_BOARD_END + 36)
-#define AUDRFSR			(IRQ_BOARD_END + 37)
-#define AUDTUR			(IRQ_BOARD_END + 38)
-#define AUDROR			(IRQ_BOARD_END + 39)
-#define AUDDTS			(IRQ_BOARD_END + 40)
-#define AUDRDD			(IRQ_BOARD_END + 41)
-#define AUDSTO			(IRQ_BOARD_END + 42)
-#define IRQ_USBPWR		(IRQ_BOARD_END + 43)
-#define IRQ_HCIM		(IRQ_BOARD_END + 44)
-#define IRQ_HCIBUFFACC		(IRQ_BOARD_END + 45)
-#define IRQ_HCIRMTWKP		(IRQ_BOARD_END + 46)
-#define IRQ_NHCIMFCIR		(IRQ_BOARD_END + 47)
-#define IRQ_USB_PORT_RESUME	(IRQ_BOARD_END + 48)
-#define IRQ_S0_READY_NINT	(IRQ_BOARD_END + 49)
-#define IRQ_S1_READY_NINT	(IRQ_BOARD_END + 50)
-#define IRQ_S0_CD_VALID		(IRQ_BOARD_END + 51)
-#define IRQ_S1_CD_VALID		(IRQ_BOARD_END + 52)
-#define IRQ_S0_BVD1_STSCHG	(IRQ_BOARD_END + 53)
-#define IRQ_S1_BVD1_STSCHG	(IRQ_BOARD_END + 54)
-
 /*
  * Figure out the MAX IRQ number.
  *
@@ -128,7 +76,7 @@
  * Otherwise, we have the standard IRQs only.
  */
 #ifdef CONFIG_SA1111
-#define NR_IRQS			(IRQ_S1_BVD1_STSCHG + 1)
+#define NR_IRQS			(IRQ_BOARD_END + 55)
 #elif CONFIG_SHARPSL_LOCOMO
 #define NR_IRQS			(IRQ_BOARD_START + 4)
 #else
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 13ebd2d..d3ec620 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -208,6 +208,10 @@ static struct resource sa1111_resources[] = {
 	},
 };
 
+static struct sa1111_platform_data sa1111_info = {
+	.irq_base	= IRQ_BOARD_END,
+};
+
 static u64 sa1111_dmamask = 0xffffffffUL;
 
 static struct platform_device sa1111_device = {
@@ -216,6 +220,7 @@ static struct platform_device sa1111_device = {
 	.dev		= {
 		.dma_mask = &sa1111_dmamask,
 		.coherent_dma_mask = 0xffffffff,
+		.platform_data = &sa1111_info,
 	},
 	.num_resources	= ARRAY_SIZE(sa1111_resources),
 	.resource	= sa1111_resources,
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 6ccd175..0b505d9 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -241,6 +241,10 @@ static struct resource sa1111_resources[] = {
 	},
 };
 
+static struct sa1111_platform_data sa1111_info = {
+	.irq_base	= IRQ_BOARD_END,
+};
+
 static u64 sa1111_dmamask = 0xffffffffUL;
 
 static struct platform_device sa1111_device = {
@@ -249,6 +253,7 @@ static struct platform_device sa1111_device = {
 	.dev		= {
 		.dma_mask = &sa1111_dmamask,
 		.coherent_dma_mask = 0xffffffff,
+		.platform_data = &sa1111_info,
 	},
 	.num_resources	= ARRAY_SIZE(sa1111_resources),
 	.resource	= sa1111_resources,
-- 
1.6.3.3
