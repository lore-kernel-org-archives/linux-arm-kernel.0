From: alex@digriz.org.uk (Alexander Clouter)
Date: Wed, 16 Feb 2011 22:45:22 +0000
Subject: [RFC] orion5x: TS-78XX support for FPGA generated doorbell IRQ's
Message-ID: <20110216224522.GK20988@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The TS-7800 board[1] FPGA can generate interrupts for devices connected 
to the PC/104 header.  This works by triggering the doorbell IRQ, which 
seems typically to not be used on other orion5x boards seen in the wild.

The following patch bumps NR_IRQS from 64 to 96 for the TS-7800 and 
calls upon the rather nifty set_irq_chained_handler() framework (the 
vendor of the board in their tree do hairy things in assembler).

The code has been tested with an Ethernet card driven off ax88796.c, but 
I am looking for feedback if this is the Right Way(tm) to do this, and 
if there is a better way.

Bear in mind that fpga_addr could vary if people wish to put their own 
bitstream on the FPGA and generate IRQ's in a similar fashion; which is 
why there is a switch statement present[2] as the VHDL coder might want 
to use different addresses.

Cheers

[1] http://www.embeddedarm.com/products/board-detail.php?product=TS-7800
[2] I am planning at some stage to rework all the FPGA related bits to 
	use either MFD or even the new ARM Device Tree framework

---
 arch/arm/mach-orion5x/addr-map.c             |    2 -
 arch/arm/mach-orion5x/include/mach/irqs.h    |   10 ++-
 arch/arm/mach-orion5x/include/mach/orion5x.h |   10 ++
 arch/arm/mach-orion5x/irq.c                  |    3 +-
 arch/arm/mach-orion5x/ts78xx-fpga.h          |    2 +
 arch/arm/mach-orion5x/ts78xx-setup.c         |  121 ++++++++++++++++++++++++++
 6 files changed, 143 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index 1a5d6a0..1fa730c 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -60,14 +60,12 @@
 /*
  * Helpers to get DDR bank info
  */
-#define ORION5X_DDR_REG(x)	(ORION5X_DDR_VIRT_BASE | (x))
 #define DDR_BASE_CS(n)		ORION5X_DDR_REG(0x1500 + ((n) << 3))
 #define DDR_SIZE_CS(n)		ORION5X_DDR_REG(0x1504 + ((n) << 3))
 
 /*
  * CPU Address Decode Windows registers
  */
-#define ORION5X_BRIDGE_REG(x)	(ORION5X_BRIDGE_VIRT_BASE | (x))
 #define CPU_WIN_CTRL(n)		ORION5X_BRIDGE_REG(0x000 | ((n) << 4))
 #define CPU_WIN_BASE(n)		ORION5X_BRIDGE_REG(0x004 | ((n) << 4))
 #define CPU_WIN_REMAP_LO(n)	ORION5X_BRIDGE_REG(0x008 | ((n) << 4))
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/include/mach/irqs.h
index a6fa9d8..677b594 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/include/mach/irqs.h
@@ -54,7 +54,13 @@
 #define IRQ_ORION5X_GPIO_START	32
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
-
+#ifdef CONFIG_MACH_TS78XX
+#	define NR_TS78XX_FPGA_IRQS	32
+#	define FPGA_IRQ(irq)		(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS + irq)
+#
+#	define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS + NR_TS78XX_FPGA_IRQS)
+#else
+#	define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
+#endif
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 2d87665..5a1711b 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -69,6 +69,7 @@
  ******************************************************************************/
 
 #define ORION5X_DDR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x00000)
+#define ORION5X_DDR_REG(x)		(ORION5X_DDR_VIRT_BASE | (x))
 
 #define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x10000)
 #define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x10000)
@@ -81,6 +82,7 @@
 #define  UART1_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE | 0x2100)
 
 #define ORION5X_BRIDGE_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x20000)
+#define ORION5X_BRIDGE_REG(x)		(ORION5X_BRIDGE_VIRT_BASE | (x))
 
 #define ORION5X_PCI_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x30000)
 
@@ -120,6 +122,14 @@
 #define DEV_BUS_INT_MASK	ORION5X_DEV_BUS_REG(0x4d4)
 
 /*******************************************************************************
+ * CPU Doorbell Registers
+ ******************************************************************************/
+#define H2C_DOORBELL_REG	ORION5X_BRIDGE_REG(0x400)
+#define H2C_DOORBELL_MASK_REG	ORION5X_BRIDGE_REG(0x404)
+#define C2H_DOORBELL_REG	ORION5X_BRIDGE_REG(0x408)
+#define C2H_DOORBELL_MASK_REG	ORION5X_BRIDGE_REG(0x40c)
+
+/*******************************************************************************
  * Supported Devices & Revisions
  ******************************************************************************/
 /* Orion-1 (88F5181) and Orion-VoIP (88F5181L) */
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index d7512b9..d5ba5b4 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -43,7 +43,8 @@ void __init orion5x_init_irq(void)
 	 * Register chained level handlers for GPIO IRQs by default.
 	 * User can use set_type() if he wants to use edge types handlers.
 	 */
-	for (i = IRQ_ORION5X_GPIO_START; i < NR_IRQS; i++) {
+	for (i = IRQ_ORION5X_GPIO_START;
+			i < IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS; i++) {
 		set_irq_chip(i, &orion_gpio_irq_chip);
 		set_irq_handler(i, handle_level_irq);
 		irq_desc[i].status |= IRQ_LEVEL;
diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/ts78xx-fpga.h
index 791f754..8bb0331 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -26,6 +26,8 @@ struct fpga_device {
 };
 
 struct fpga_devices {
+	struct fpga_device	doorbell_irq;
+
 	/* Technologic Systems */
 	struct fpga_device 	ts_rtc;
 	struct fpga_device 	ts_nand;
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index d3e29f8..592773a 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -22,6 +22,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/orion5x.h>
+#include <linux/irq.h>
+#include <mach/bridge-regs.h>
 #include "common.h"
 #include "mpp.h"
 #include "ts78xx-fpga.h"
@@ -62,6 +64,112 @@ void __init ts78xx_map_io(void)
 }
 
 /*****************************************************************************
+ * IRQ
+ ****************************************************************************/
+static void ts78xx_irq_ack(u32 irq)
+{
+	u32 addr;
+
+	addr = readl(H2C_DOORBELL_REG);
+	addr &= ~(1 << (irq - FPGA_IRQ(0)));
+	writel(addr, H2C_DOORBELL_REG);
+}
+
+static void ts78xx_irq_mask(u32 irq)
+{
+	void __iomem *fpgaaddr = get_irq_chip_data(irq);
+	unsigned long reg;
+
+	reg = readl(H2C_DOORBELL_MASK_REG);
+	reg &= ~(1 << (irq - FPGA_IRQ(0)));
+	writel(reg, H2C_DOORBELL_MASK_REG);
+
+	reg = readl(fpgaaddr);
+	reg &= ~(1 << (irq - FPGA_IRQ(0)));
+	writel(reg, fpgaaddr);
+}
+
+static void ts78xx_irq_unmask(u32 irq)
+{
+	void __iomem *fpgaaddr = get_irq_chip_data(irq);
+	unsigned long reg;
+
+	reg = readl(H2C_DOORBELL_MASK_REG);
+	reg |= 1 << (irq - FPGA_IRQ(0));
+	writel(reg, H2C_DOORBELL_MASK_REG);
+
+	reg = readl(H2C_DOORBELL_REG);
+	reg &= ~(1 << (irq - FPGA_IRQ(0)));
+	writel(reg, H2C_DOORBELL_REG);
+
+	reg = readl(fpgaaddr);
+	reg |= 1 << (irq - FPGA_IRQ(0));
+	writel(reg, fpgaaddr);
+}
+
+static struct irq_chip ts78xx_irq_chip = {
+	.name		= "ts78xx_irq",
+	.ack		= ts78xx_irq_ack,
+	.mask		= ts78xx_irq_mask,
+	.unmask		= ts78xx_irq_unmask,
+};
+
+static void ts78xx_irq(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned long reg = readl(H2C_DOORBELL_REG);
+
+	for_each_set_bit(irq, &reg, 32)
+		generic_handle_irq(FPGA_IRQ(irq));
+}
+
+static int ts78xx_doorbell_irq_load(void)
+{
+	void __iomem *fpgaaddr;
+	unsigned int irq;
+
+	switch (ts78xx_fpga.id) {
+	case TS7800_REV_1:
+	case TS7800_REV_2:
+	case TS7800_REV_3:
+	case TS7800_REV_4:
+	case TS7800_REV_5:
+	case TS7800_REV_6:
+	case TS7800_REV_7:
+	case TS7800_REV_8:
+	case TS7800_REV_9:
+		fpgaaddr = (void __iomem *)(TS78XX_FPGA_REGS_VIRT_BASE | 0x204);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	for (irq = FPGA_IRQ(0); irq < FPGA_IRQ(NR_TS78XX_FPGA_IRQS); irq++) {
+		set_irq_chip(irq, &ts78xx_irq_chip);
+		set_irq_chip_data(irq, fpgaaddr);
+		set_irq_handler(irq, handle_level_irq);
+		irq_desc[irq].status |= IRQ_LEVEL;
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(IRQ_ORION5X_DOORBELL_H2C, ts78xx_irq);
+
+	return 0;
+}
+
+static void ts78xx_doorbell_irq_unload(void)
+{
+	unsigned int irq;
+
+	set_irq_chained_handler(IRQ_ORION5X_DOORBELL_H2C, NULL);
+
+	for (irq = FPGA_IRQ(0); irq < FPGA_IRQ(NR_TS78XX_FPGA_IRQS); irq++) {
+		set_irq_flags(irq, 0);
+		set_irq_chip(irq, NULL);
+		set_irq_chip_data(irq, NULL);
+	}
+}
+
+/*****************************************************************************
  * Ethernet
  ****************************************************************************/
 static struct mv643xx_eth_platform_data ts78xx_eth_data = {
@@ -376,6 +484,7 @@ static void ts78xx_ts_rng_unload(void)
  ****************************************************************************/
 static void ts78xx_fpga_devices_zero_init(void)
 {
+	ts78xx_fpga.supports.doorbell_irq.init = 0;
 	ts78xx_fpga.supports.ts_rtc.init = 0;
 	ts78xx_fpga.supports.ts_nand.init = 0;
 	ts78xx_fpga.supports.ts_rng.init = 0;
@@ -394,11 +503,13 @@ static void ts78xx_fpga_supports(void)
 	case TS7800_REV_7:
 	case TS7800_REV_8:
 	case TS7800_REV_9:
+		ts78xx_fpga.supports.doorbell_irq.present = 1;
 		ts78xx_fpga.supports.ts_rtc.present = 1;
 		ts78xx_fpga.supports.ts_nand.present = 1;
 		ts78xx_fpga.supports.ts_rng.present = 1;
 		break;
 	default:
+		ts78xx_fpga.supports.doorbell_irq.present = 0;
 		ts78xx_fpga.supports.ts_rtc.present = 0;
 		ts78xx_fpga.supports.ts_nand.present = 0;
 		ts78xx_fpga.supports.ts_rng.present = 0;
@@ -409,6 +520,14 @@ static int ts78xx_fpga_load_devices(void)
 {
 	int tmp, ret = 0;
 
+	if (ts78xx_fpga.supports.doorbell_irq.present == 1) {
+		tmp = ts78xx_doorbell_irq_load();
+		if (tmp) {
+			printk(KERN_INFO "TS-78xx: Doorbell IRQs not registered\n");
+			ts78xx_fpga.supports.doorbell_irq.present = 0;
+		}
+		ret |= tmp;
+	}
 	if (ts78xx_fpga.supports.ts_rtc.present == 1) {
 		tmp = ts78xx_ts_rtc_load();
 		if (tmp) {
@@ -441,6 +560,8 @@ static int ts78xx_fpga_unload_devices(void)
 {
 	int ret = 0;
 
+	if (ts78xx_fpga.supports.doorbell_irq.present == 1)
+		ts78xx_doorbell_irq_unload();
 	if (ts78xx_fpga.supports.ts_rtc.present == 1)
 		ts78xx_ts_rtc_unload();
 	if (ts78xx_fpga.supports.ts_nand.present == 1)
-- 
1.7.2.3
