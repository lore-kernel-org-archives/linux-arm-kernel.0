From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 6 Apr 2011 21:17:21 +0400
Subject: [PATCH] DA830: fix SPI1 base address
Message-ID: <201104062117.22238.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 54ce6883d29630ff334bee4256a25e3f8719a181 (davinci: da8xx: add spi
resources and registration routine) wrongly assumed that SPI1 is mapped at
the same address on DA830/OMAP-L137 and DA850/OMAP-L138; actually, the base
address was valid only for the latter SoC. Teach the code to pass the correct
SPI1 memory resource for both SoCs...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree.  It's needed in 2.6.39.

 arch/arm/mach-davinci/devices-da8xx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/devices-da8xx.c
+++ linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
@@ -39,7 +39,8 @@
 #define DA8XX_GPIO_BASE			0x01e26000
 #define DA8XX_I2C1_BASE			0x01e28000
 #define DA8XX_SPI0_BASE			0x01c41000
-#define DA8XX_SPI1_BASE			0x01f0e000
+#define DA830_SPI1_BASE			0x01e12000
+#define DA850_SPI1_BASE			0x01f0e000
 
 #define DA8XX_EMAC_CTRL_REG_OFFSET	0x3000
 #define DA8XX_EMAC_MOD_REG_OFFSET	0x2000
@@ -762,8 +763,8 @@ static struct resource da8xx_spi0_resour
 
 static struct resource da8xx_spi1_resources[] = {
 	[0] = {
-		.start	= DA8XX_SPI1_BASE,
-		.end	= DA8XX_SPI1_BASE + SZ_4K - 1,
+		.start	= DA830_SPI1_BASE,
+		.end	= DA830_SPI1_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -832,5 +833,10 @@ int __init da8xx_register_spi(int instan
 
 	da8xx_spi_pdata[instance].num_chipselect = len;
 
+	if (instance == 1 && cpu_is_davinci_da850()) {
+		da8xx_spi1_resources[0].start = DA850_SPI1_BASE;
+		da8xx_spi1_resources[0].end = DA850_SPI1_BASE + SZ_4K - 1;
+	}
+
 	return platform_device_register(&da8xx_spi_device[instance]);
 }
