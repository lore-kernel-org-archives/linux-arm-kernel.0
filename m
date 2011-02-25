From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 14:38:26 +0100
Subject: [PATCH 1/6] eukrea_mbimxsd: add audio support
Message-ID: <1298641111-12957-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |   28 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 4e4d7af..ded1d2d 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -108,6 +108,7 @@ config MACH_EUKREA_MBIMXSD51_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index c372a43..712061c 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -67,6 +67,11 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX51_PAD_SD1_DATA1__SD1_DATA1,
 	MX51_PAD_SD1_DATA2__SD1_DATA2,
 	MX51_PAD_SD1_DATA3__SD1_DATA3,
+	/* SSI */
+	MX51_PAD_AUD3_BB_TXD__AUD3_TXD,
+	MX51_PAD_AUD3_BB_RXD__AUD3_RXD,
+	MX51_PAD_AUD3_BB_CK__AUD3_TXC,
+	MX51_PAD_AUD3_BB_FS__AUD3_TXFS,
 };
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 30)
@@ -133,6 +138,11 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
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
@@ -145,10 +155,28 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 			ARRAY_SIZE(eukrea_mbimxsd_pads)))
 		printk(KERN_ERR "error setting mbimxsd pads !\n");
 
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+	/* SSI unit master I2S codec connected to SSI_AUD3 */
+	mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TFSDIR |
+			MXC_AUDMUX_V2_PTCR_TFSEL(2) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR |
+			MXC_AUDMUX_V2_PTCR_TCSEL(2),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(2)
+	);
+	mxc_audmux_v2_configure_port(2,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TCSEL(0),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
+	);
+#endif
+
 	imx51_add_imx_uart(1, NULL);
 	imx51_add_imx_uart(2, &uart_pdata);
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
+	imx51_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
-- 
1.7.4
