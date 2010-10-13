From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed, 13 Oct 2010 21:15:44 +0900
Subject: [PATCH 2/2] ARM: S5PV310: Support ethernet for SMDKV310 and SMDKC210
In-Reply-To: <1286972144-763-1-git-send-email-sbkim73@samsung.com>
References: <1286972144-763-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1286972144-763-3-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daein Moon <moon9124@samsung.com>

This patch adds to support ethernet for SMDKV310 and SMDKC210 board.
  - define smc911x resources
  - define configurations of smc911x platform data
  - define platform device "smsc911x"
  - initialize srom controller for lan9215 chip

Signed-off-by: Daein Moon <moon9124@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkc210.c |   61 +++++++++++++++++++++++++++++++++
 arch/arm/mach-s5pv310/mach-smdkv310.c |   61 +++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index d2cf694..14aca19 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -12,6 +12,8 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <linux/io.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -24,6 +26,7 @@
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/regs-srom.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -106,6 +109,37 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static struct resource smdkc210_smsc911x_resources[] = {
+	[0] = {
+		.start	= S5PV310_PA_SROM_BANK(1),
+		.end	= S5PV310_PA_SROM_BANK(1) + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_EINT(5),
+		.end	= IRQ_EINT(5),
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct smsc911x_platform_config smsc9215_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.mac		= {0x00, 0x80, 0x00, 0x23, 0x45, 0x67},
+};
+
+static struct platform_device smdkc210_smsc911x = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smdkc210_smsc911x_resources),
+	.resource	= smdkc210_smsc911x_resources,
+	.dev		= {
+		.platform_data  = &smsc9215_config,
+	},
+};
+
 static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -113,8 +147,33 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_hsmmc3,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
+	&smdkc210_smsc911x,
 };
 
+static void __init smdkc210_smsc911x_init(void)
+{
+	u32 cs1;
+
+	/* configure nCS1 width to 16 bits */
+	cs1 = __raw_readl(S5PV310_SROM_BW) &
+		    ~(S5PV310_SROM_BW__CS_MASK <<
+				    S5PV310_SROM_BW__NCS1__SHIFT);
+	cs1 |= ((1 << S5PV310_SROM_BW__DATAWIDTH__SHIFT) |
+		(1 << S5PV310_SROM_BW__WAITENABLE__SHIFT) |
+		(1 << S5PV310_SROM_BW__BYTEENABLE__SHIFT)) <<
+		S5PV310_SROM_BW__NCS1__SHIFT;
+	__raw_writel(cs1, S5PV310_SROM_BW);
+
+	/* set timing for nCS1 suitable for ethernet chip */
+	__raw_writel((0x1 << S5PV310_SROM_BCX__PMC__SHIFT) |
+		     (0x9 << S5PV310_SROM_BCX__TACP__SHIFT) |
+		     (0xc << S5PV310_SROM_BCX__TCAH__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TCOH__SHIFT) |
+		     (0x6 << S5PV310_SROM_BCX__TACC__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TCOS__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TACS__SHIFT), S5PV310_SROM_BC1);
+}
+
 static void __init smdkc210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -124,6 +183,8 @@ static void __init smdkc210_map_io(void)
 
 static void __init smdkc210_machine_init(void)
 {
+	smdkc210_smsc911x_init();
+
 	s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
 	s3c_sdhci1_set_platdata(&smdkc210_hsmmc1_pdata);
 	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 10f8056..cd648d5 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -12,6 +12,8 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <linux/io.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -24,6 +26,7 @@
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/regs-srom.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -106,6 +109,37 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static struct resource smdkv310_smsc911x_resources[] = {
+	[0] = {
+		.start	= S5PV310_PA_SROM_BANK(1),
+		.end	= S5PV310_PA_SROM_BANK(1) + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_EINT(5),
+		.end	= IRQ_EINT(5),
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct smsc911x_platform_config smsc9215_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.mac		= {0x00, 0x80, 0x00, 0x23, 0x45, 0x67},
+};
+
+static struct platform_device smdkv310_smsc911x = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smdkv310_smsc911x_resources),
+	.resource	= smdkv310_smsc911x_resources,
+	.dev		= {
+		.platform_data  = &smsc9215_config,
+	},
+};
+
 static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -113,8 +147,33 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_hsmmc3,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
+	&smdkv310_smsc911x,
 };
 
+static void __init smdkv310_smsc911x_init(void)
+{
+	u32 cs1;
+
+	/* configure nCS1 width to 16 bits */
+	cs1 = __raw_readl(S5PV310_SROM_BW) &
+		    ~(S5PV310_SROM_BW__CS_MASK <<
+				    S5PV310_SROM_BW__NCS1__SHIFT);
+	cs1 |= ((1 << S5PV310_SROM_BW__DATAWIDTH__SHIFT) |
+		(1 << S5PV310_SROM_BW__WAITENABLE__SHIFT) |
+		(1 << S5PV310_SROM_BW__BYTEENABLE__SHIFT)) <<
+		S5PV310_SROM_BW__NCS1__SHIFT;
+	__raw_writel(cs1, S5PV310_SROM_BW);
+
+	/* set timing for nCS1 suitable for ethernet chip */
+	__raw_writel((0x1 << S5PV310_SROM_BCX__PMC__SHIFT) |
+		     (0x9 << S5PV310_SROM_BCX__TACP__SHIFT) |
+		     (0xc << S5PV310_SROM_BCX__TCAH__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TCOH__SHIFT) |
+		     (0x6 << S5PV310_SROM_BCX__TACC__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TCOS__SHIFT) |
+		     (0x1 << S5PV310_SROM_BCX__TACS__SHIFT), S5PV310_SROM_BC1);
+}
+
 static void __init smdkv310_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -124,6 +183,8 @@ static void __init smdkv310_map_io(void)
 
 static void __init smdkv310_machine_init(void)
 {
+	smdkv310_smsc911x_init();
+
 	s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
 	s3c_sdhci1_set_platdata(&smdkv310_hsmmc1_pdata);
 	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
-- 
1.6.2.5
