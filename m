From: ssanap@marvell.com (Sachin Sanap)
Date: Wed, 25 Aug 2010 15:11:13 +0530
Subject: [PATCH 3/3] pxa: Add support for Fast Ethernet driver.
Message-ID: <1282729273.6968.105.camel@pe-lt522.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds support for PXA168 Fast Ethernet on Aspenite.

Signed-off-by: Sachin Sanap <ssanap@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c               |   29 ++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/devices.h   |    1 +
 arch/arm/mach-mmp/include/mach/pxa168.h    |    6 +++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h |    1 +
 arch/arm/mach-mmp/pxa168.c                 |    3 ++
 5 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 89982e2..a0fbef5 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -24,10 +24,13 @@
 #include <mach/pxa168.h>
 #include <mach/gpio.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/pxa168_eth.h>
 
 #include "common.h"
 
 #define GPIO_EXT1(x)	(128 + 16 + (x))
+#define ENET_RESET_N	GPIO_EXT1(9)
+#define ENET_COMA_N	GPIO_EXT1(10)
 
 static unsigned long common_pin_config[] __initdata = {
 	/* Data Flash Interface */
@@ -174,6 +177,31 @@ static struct i2c_board_info aspenite_i2c_info[] __initdata = {
 	},
 };
 
+static int pxa168_eth_init(void)
+{
+	if (gpio_request(ENET_RESET_N, "ENET_RESET_N")) {
+		printk(KERN_ERR "Request GPIO failed,"
+				"gpio: %d\n", ENET_RESET_N);
+		return -EIO;
+	}
+	if (gpio_request(ENET_COMA_N, "ENET_COMA_N")) {
+		gpio_free(ENET_RESET_N);
+		printk(KERN_ERR "Request GPIO failed,"
+				"gpio: %d\n", ENET_COMA_N);
+		return -EIO;
+	}
+	gpio_direction_output(ENET_RESET_N, 1);
+	gpio_direction_output(ENET_COMA_N, 1);
+	gpio_free(ENET_RESET_N);
+	gpio_free(ENET_COMA_N);
+	return 0;
+}
+
+static struct pxa168_eth_platform_data pxa168_eth_data = {
+	.phy_addr = 0,		/* phy addr depends on boards */
+	.port_number = 0,
+	.init	= pxa168_eth_init,
+};
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
@@ -184,6 +212,7 @@ static void __init common_init(void)
 	pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
 	pxa168_add_ssp(1);
 	pxa168_add_nand(&aspenite_nand_info);
+	pxa168_add_mfu(&pxa168_eth_data);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/include/mach/devices.h b/arch/arm/mach-mmp/include/mach/devices.h
index d0ec7da..75a2da4 100644
--- a/arch/arm/mach-mmp/include/mach/devices.h
+++ b/arch/arm/mach-mmp/include/mach/devices.h
@@ -49,5 +49,6 @@ struct pxa_device_desc mmp2_device_##_name __initdata = {		\
 	.dma		= { _dma },					\
 }
 
+extern struct pxa_device_desc pxa168_device_mfu;
 extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
 #endif /* __MACH_DEVICE_H */
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 27e1bc7..99c0ee6 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -10,6 +10,7 @@ extern void __init pxa168_init_irq(void);
 #include <mach/devices.h>
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
+#include <linux/pxa168_eth.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -97,4 +98,9 @@ static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
 }
+
+static inline int pxa168_add_mfu(struct pxa168_eth_platform_data *data)
+{
+	return pxa_register_device(&pxa168_device_mfu, data, sizeof(*data));
+}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index 9190305..47b2ea6 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -27,6 +27,7 @@
 #define APMU_DMA	APMU_REG(0x064)
 #define APMU_GEU	APMU_REG(0x068)
 #define APMU_BUS	APMU_REG(0x06c)
+#define APMU_MFU	APMU_REG(0x0fc)
 
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 652ae66..6fcaf0c 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,6 +79,7 @@ static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
 
 static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(mfu, MFU, 0x9, 0);
 
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -96,6 +97,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
 	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_mfu, "pxa168-eth", "MFUCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -147,3 +149,4 @@ PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
 PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
 PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
 PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
+PXA168_DEVICE(mfu, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
-- 
1.5.3.3
