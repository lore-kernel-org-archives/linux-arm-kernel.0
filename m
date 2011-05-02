From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon,  2 May 2011 11:29:59 +0530
Subject: [PATCH 2/3] ARM: pxa168: Add support for Ethernet
In-Reply-To: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <1304316000-869-3-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wrapper that creates resources for PXA168 Ethernet driver

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   19 +++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h     |    6 ++++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h  |    1 +
 arch/arm/mach-mmp/pxa168.c                  |    3 +++
 4 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index 713be15..8c78232 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -305,4 +305,23 @@
 #define GPIO112_KP_MKOUT6       MFP_CFG(GPIO112, AF7)
 #define GPIO121_KP_MKIN4        MFP_CFG(GPIO121, AF7)
 
+/* Fast Ethernet */
+#define GPIO86_TX_CLK		MFP_CFG(GPIO86, AF5)
+#define GPIO87_TX_EN		MFP_CFG(GPIO87, AF5)
+#define GPIO88_TX_DQ3		MFP_CFG(GPIO88, AF5)
+#define GPIO89_TX_DQ2		MFP_CFG(GPIO89, AF5)
+#define GPIO90_TX_DQ1		MFP_CFG(GPIO90, AF5)
+#define GPIO91_TX_DQ0		MFP_CFG(GPIO91, AF5)
+#define GPIO92_MII_CRS		MFP_CFG(GPIO92, AF5)
+#define GPIO93_MII_COL		MFP_CFG(GPIO93, AF5)
+#define GPIO94_RX_CLK		MFP_CFG(GPIO94, AF5)
+#define GPIO95_RX_ER		MFP_CFG(GPIO95, AF5)
+#define GPIO96_RX_DQ3		MFP_CFG(GPIO96, AF5)
+#define GPIO97_RX_DQ2		MFP_CFG(GPIO97, AF5)
+#define GPIO98_RX_DQ1		MFP_CFG(GPIO98, AF5)
+#define GPIO99_RX_DQ0		MFP_CFG(GPIO99, AF5)
+#define GPIO100_MII_MDC		MFP_CFG(GPIO100, AF5)
+#define GPIO101_MII_MDIO	MFP_CFG(GPIO101, AF5)
+#define GPIO103_RX_DV		MFP_CFG(GPIO103, AF5)
+
 #endif /* __ASM_MACH_MFP_PXA168_H */
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 705e963..7f00584 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -14,6 +14,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <video/pxa168fb.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/cputype.h>
+#include <linux/pxa168_eth.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -32,6 +33,7 @@ extern struct pxa_device_desc pxa168_device_ssp5;
 extern struct pxa_device_desc pxa168_device_nand;
 extern struct pxa_device_desc pxa168_device_fb;
 extern struct pxa_device_desc pxa168_device_keypad;
+extern struct pxa_device_desc pxa168_device_eth;
 
 static inline int pxa168_add_uart(int id)
 {
@@ -119,4 +121,8 @@ static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
 	return pxa_register_device(&pxa168_device_keypad, data, sizeof(*data));
 }
 
+static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
+{
+	return pxa_register_device(&pxa168_device_eth, data, sizeof(*data));
+}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index f7011ef..8447ac6 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -29,6 +29,7 @@
 #define APMU_BUS	APMU_REG(0x06c)
 #define APMU_SDH2	APMU_REG(0x0e8)
 #define APMU_SDH3	APMU_REG(0x0ec)
+#define APMU_ETH	APMU_REG(0x0fc)
 
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index dcb203b..96d451d 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -82,6 +82,7 @@ static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
 
 static APMU_CLK(nand, NAND, 0x01db, 208000000);
 static APMU_CLK(lcd, LCD, 0x7f, 312000000);
+static APMU_CLK(eth, ETH, 0x09, 0);
 
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -102,6 +103,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
+	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -166,3 +168,4 @@ PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
 PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
 PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
+PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
-- 
1.7.0.4
