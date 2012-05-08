From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:22 +0200
Subject: [PATCH 07/12] ARM: imx: eukrea_mbimxsd: add audio support
In-Reply-To: <1336461627-30315-1-git-send-email-eric@eukrea.com>
References: <1336461627-30315-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461627-30315-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                    |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 96b1c77..18399d1 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -707,6 +707,7 @@ choice
 config MACH_EUKREA_MBIMXSD51_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select LEDS_GPIO_REGISTER
 	help
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
index aaa592f..bc89bb6 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
@@ -66,6 +66,11 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	NEW_PAD_CTRL(MX51_PAD_GPIO1_0__SD1_CD, PAD_CTL_PUS_22K_UP |
 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
+	/* SSI */
+	MX51_PAD_AUD3_BB_TXD__AUD3_TXD,
+	MX51_PAD_AUD3_BB_RXD__AUD3_RXD,
+	MX51_PAD_AUD3_BB_CK__AUD3_TXC,
+	MX51_PAD_AUD3_BB_FS__AUD3_TXFS,
 };
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 30)
@@ -112,6 +117,11 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
 	},
 };
 
+static const
+struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
+	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx51sd init.
  *
@@ -129,6 +139,8 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
 
+	imx51_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
+
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
 	gpio_free(GPIO_LED1);
-- 
1.7.7.6
