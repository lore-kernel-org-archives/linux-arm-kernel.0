From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:23 -0700
Subject: [PATCH 19/46] davinci: Add RTC support for DA8xx/OMAP-L13x SoC's
In-Reply-To: <1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark A. Greer <mgreer@mvista.com>

Add RTC support for the da830/omap-l137 and da850/omap-l138
SoC's by leveraging existing the rtc-omap driver.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c    |    4 +++
 arch/arm/mach-davinci/board-da850-evm.c    |    4 +++
 arch/arm/mach-davinci/devices-da8xx.c      |   35 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 4 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index dfc4897..fb76721 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -217,6 +217,10 @@ static __init void da830_evm_init(void)
 	if (ret)
 		pr_warning("da830_evm_init: lcd setup failed: %d\n", ret);
 #endif
+
+	ret = da8xx_register_rtc();
+	if (ret)
+		pr_warning("da830_evm_init: rtc setup failed: %d\n", ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index da1a6fb..47619a9 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -381,6 +381,10 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: lcdc registration failed: %d\n",
 				ret);
+
+	ret = da8xx_register_rtc();
+	if (ret)
+		pr_warning("da850_evm_init: rtc setup failed: %d\n", ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 5595613..dd0ea08 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -29,6 +29,7 @@
 #define DA8XX_TPTC1_BASE		0x01c08400
 #define DA8XX_WDOG_BASE			0x01c21000 /* DA8XX_TIMER64P1_BASE */
 #define DA8XX_I2C0_BASE			0x01c22000
+#define DA8XX_RTC_BASE			0x01C23000
 #define DA8XX_EMAC_CPPI_PORT_BASE	0x01e20000
 #define DA8XX_EMAC_CPGMACSS_BASE	0x01e22000
 #define DA8XX_EMAC_CPGMAC_BASE		0x01e23000
@@ -453,3 +454,37 @@ int __init da8xx_register_mmcsd0(struct davinci_mmc_config *config)
 	da8xx_mmcsd0_device.dev.platform_data = config;
 	return platform_device_register(&da8xx_mmcsd0_device);
 }
+
+static struct resource da8xx_rtc_resources[] = {
+	{
+		.start		= DA8XX_RTC_BASE,
+		.end		= DA8XX_RTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{ /* timer irq */
+		.start		= IRQ_DA8XX_RTC,
+		.end		= IRQ_DA8XX_RTC,
+		.flags		= IORESOURCE_IRQ,
+	},
+	{ /* alarm irq */
+		.start		= IRQ_DA8XX_RTC,
+		.end		= IRQ_DA8XX_RTC,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device da8xx_rtc_device = {
+	.name           = "omap_rtc",
+	.id             = -1,
+	.num_resources	= ARRAY_SIZE(da8xx_rtc_resources),
+	.resource	= da8xx_rtc_resources,
+};
+
+int da8xx_register_rtc(void)
+{
+	/* Unlock the rtc's registers */
+	__raw_writel(0x83e70b13, IO_ADDRESS(DA8XX_RTC_BASE + 0x6c));
+	__raw_writel(0x95a4f1e0, IO_ADDRESS(DA8XX_RTC_BASE + 0x70));
+
+	return platform_device_register(&da8xx_rtc_device);
+}
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 375a3f7..a152261 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -81,6 +81,7 @@ int da8xx_register_emac(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
+int da8xx_register_rtc(void);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.6.4.3
