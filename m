From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:45:59 +0200
Subject: [PATCH 04/13] cpuimx27 and mbimx27: allow fine control of UART4 and
	SDHC2 usage
In-Reply-To: <1274287568-30253-3-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/Kconfig                    |    9 ++++++++-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    8 ++++++++
 arch/arm/mach-mx2/mach-cpuimx27.c            |    6 ++++++
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index 742fd4e..9d3a909 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -67,9 +67,16 @@ config MACH_EUKREA_CPUIMX27_USESDHC2
 	bool "CPUIMX27 integrates SDHC2 module"
 	depends on MACH_CPUIMX27
 	help
-	  This adds support for the internal SDHC2 used on CPUIMX27 used
+	  This adds support for the internal SDHC2 used on CPUIMX27
 	  for wifi or eMMC.
 
+config MACH_EUKREA_CPUIMX27_USEUART4
+	bool "CPUIMX27 integrates UART4 module"
+	depends on MACH_CPUIMX27
+	help
+	  This adds support for the internal UART4 used on CPUIMX27
+	  for bluetooth.
+
 choice
 	prompt "Baseboard"
 	depends on MACH_CPUIMX27
diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 91ab7bb..fff6c8d 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -50,10 +50,12 @@ static int eukrea_mbimx27_pins[] = {
 	PE10_PF_UART3_CTS,
 	PE11_PF_UART3_RTS,
 	/* UART4 */
+#if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
 	PB26_AF_UART4_RTS,
 	PB28_AF_UART4_TXD,
 	PB29_AF_UART4_CTS,
 	PB31_AF_UART4_RXD,
+#endif
 	/* SDHC1*/
 	PE18_PF_SD1_D0,
 	PE19_PF_SD1_D1,
@@ -229,6 +231,9 @@ static struct imxuart_platform_data uart_pdata[] = {
 	{
 		.flags = IMXUART_HAVE_RTSCTS,
 	},
+	{
+		.flags = IMXUART_HAVE_RTSCTS,
+	},
 };
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846)
@@ -293,6 +298,9 @@ void __init eukrea_mbimx27_baseboard_init(void)
 
 	mxc_register_device(&mxc_uart_device1, &uart_pdata[0]);
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[1]);
+#if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
+	mxc_register_device(&mxc_uart_device3, &uart_pdata[2]);
+#endif
 
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, NULL);
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index 1f616dc..5c6a16b 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -49,10 +49,12 @@ static int eukrea_cpuimx27_pins[] = {
 	PE14_PF_UART1_CTS,
 	PE15_PF_UART1_RTS,
 	/* UART4 */
+#if defined(MACH_EUKREA_CPUIMX27_USEUART4)
 	PB26_AF_UART4_RTS,
 	PB28_AF_UART4_TXD,
 	PB29_AF_UART4_CTS,
 	PB31_AF_UART4_RXD,
+#endif
 	/* FEC */
 	PD0_AIN_FEC_TXD0,
 	PD1_AIN_FEC_TXD1,
@@ -76,12 +78,14 @@ static int eukrea_cpuimx27_pins[] = {
 	PD17_PF_I2C_DATA,
 	PD18_PF_I2C_CLK,
 	/* SDHC2 */
+#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
 	PB4_PF_SD2_D0,
 	PB5_PF_SD2_D1,
 	PB6_PF_SD2_D2,
 	PB7_PF_SD2_D3,
 	PB8_PF_SD2_CMD,
 	PB9_PF_SD2_CLK,
+#endif
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 	/* Quad UART's IRQ */
 	GPIO_PORTD | 22 | GPIO_GPIO | GPIO_IN,
@@ -202,6 +206,8 @@ static void __init eukrea_cpuimx27_init(void)
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
 	/* SDHC2 can be used for Wifi */
 	mxc_register_device(&mxc_sdhc_device1, NULL);
+#endif
+#if defined(MACH_EUKREA_CPUIMX27_USEUART4)
 	/* in which case UART4 is also used for Bluetooth */
 	mxc_register_device(&mxc_uart_device3, &uart_pdata[1]);
 #endif
-- 
1.6.3.3
