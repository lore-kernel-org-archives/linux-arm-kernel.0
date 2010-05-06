From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 6 May 2010 13:28:03 -0500
Subject: [PATCH] mach-ep93xx: checkpatch.pl cleanup
Message-ID: <0D753D10438DA54287A00B0270842697636ECB4F3D@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cleans up most the checkpatch.pl issues in mach-ep93xx.

  ERROR: space required after that ',' (ctx:VxV)
  WARNING: line over 80 characters
  WARNING: please, no space before tabs

The file core.c still produces this warning:

  WARNING: externs should be avoided in .c files

Due to two externs declared for functions in located in gpio.c.
Since these are __init functions, and not meant to be exposed,
these warnings were not fixed.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 5f80092..31108d8 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -170,7 +170,7 @@ static struct clk clk_m2m1 = {
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
 };
 
-#define INIT_CK(dev,con,ck)					\
+#define INIT_CK(dev, con, ck)					\
 	{ .dev_id = dev, .con_id = con, .clk = ck }
 
 static struct clk_lookup clocks[] = {
@@ -215,7 +215,8 @@ static void __clk_enable(struct clk *clk)
 			v = __raw_readl(clk->enable_reg);
 			v |= clk->enable_mask;
 			if (clk->sw_locked)
-				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
+				ep93xx_syscon_swlocked_write(v,
+						clk->enable_reg);
 			else
 				__raw_writel(v, clk->enable_reg);
 		}
@@ -246,7 +247,8 @@ static void __clk_disable(struct clk *clk)
 			v = __raw_readl(clk->enable_reg);
 			v &= ~clk->enable_mask;
 			if (clk->sw_locked)
-				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
+				ep93xx_syscon_swlocked_write(v,
+						clk->enable_reg);
 			else
 				__raw_writel(v, clk->enable_reg);
 		}
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d3f77e..295e513 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -337,8 +337,8 @@ static struct platform_device ep93xx_ohci_device = {
 	.name		= "ep93xx-ohci",
 	.id		= -1,
 	.dev		= {
-		.dma_mask		= &ep93xx_ohci_device.dev.coherent_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.dma_mask = &ep93xx_ohci_device.dev.coherent_dma_mask,
 	},
 	.num_resources	= ARRAY_SIZE(ep93xx_ohci_resources),
 	.resource	= ep93xx_ohci_resources,
@@ -562,7 +562,7 @@ static struct platform_device ep93xx_fb_device = {
 	.dev			= {
 		.platform_data		= &ep93xxfb_data,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.dma_mask		= &ep93xx_fb_device.dev.coherent_dma_mask,
+		.dma_mask = &ep93xx_fb_device.dev.coherent_dma_mask,
 	},
 	.num_resources		= ARRAY_SIZE(ep93xx_fb_resource),
 	.resource		= ep93xx_fb_resource,
diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index cf547ad..68d72cd 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -118,7 +118,8 @@ static void ep93xx_gpio_irq_ack(unsigned int irq)
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
-	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) ==
+					IRQ_TYPE_EDGE_BOTH) {
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
 		ep93xx_gpio_update_int_params(port);
 	}
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 38deaee..ed352ac 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -42,7 +42,7 @@
 #define SNAPPERCL15_NAND_CEN	(1 << 11) /* Chip enable (active low) */
 #define SNAPPERCL15_NAND_RDY	(1 << 14) /* Device ready */
 
-#define NAND_CTRL_ADDR(chip) 	(chip->IO_ADDR_W + 0x40)
+#define NAND_CTRL_ADDR(chip)	(chip->IO_ADDR_W + 0x40)
 
 static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				      unsigned int ctrl)
@@ -167,6 +167,6 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.timer 		= &ep93xx_timer,
+	.timer		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 9553031..b981a71 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -182,7 +182,7 @@ static struct resource ts72xx_wdt_resources[] = {
 static struct platform_device ts72xx_wdt_device = {
 	.name		= "ts72xx-wdt",
 	.id		= -1,
-	.num_resources 	= ARRAY_SIZE(ts72xx_wdt_resources),
+	.num_resources	= ARRAY_SIZE(ts72xx_wdt_resources),
 	.resource	= ts72xx_wdt_resources,
 };
 
