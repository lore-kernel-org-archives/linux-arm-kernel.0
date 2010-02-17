From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Wed, 17 Feb 2010 19:15:45 +0100
Subject: [PATCH 3/3] add mx3 cupid ac97 support
Message-ID: <D99582E5322435468A77E74BB0039E7B176E1F3BBC@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I added AC97 support to CUPID BSP.

Carsten

Signed-off-by: Carsten Behling <carsten.behling@garz-fricke.com>
---
 arch/arm/mach-mx3/mach-guf_cupid.c |  104 ++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-guf_cupid.c b/arch/arm/mach-mx3/mach-guf_cupid.c
index 05b2303..fad050e 100644
--- a/arch/arm/mach-mx3/mach-guf_cupid.c
+++ b/arch/arm/mach-mx3/mach-guf_cupid.c
@@ -138,6 +138,97 @@ static struct pad_desc cupid_pads[] = {
        MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
        MX35_PAD_LD18__GPIO3_24,                /* LCD enable */
        MX35_PAD_CSPI1_SS1__PWM_PWMO,           /* LCD backligtht PWM */
+       /* SSI */
+       MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS,
+       MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
+       MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
+       MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+       /* UCB1400 IRQ */
+       MX35_PAD_ATA_INTRQ__GPIO2_29,
+};
+
+#define AC97_GPIO_TXFS (1 * 32 + 31)
+#define AC97_GPIO_TXD  (1 * 32 + 28)
+#define AC97_GPIO_RESET        (1 * 32 + 27)
+#define AC97_GPIO_INT  (1 * 32 + 29)
+
+static void cupid_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+       struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+       struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+       int ret;
+
+       ret = gpio_request(AC97_GPIO_TXFS, "SSI");
+       if (ret) {
+               printk(KERN_WARN "failed to get GPIO_TXFS: %d\n", ret);
+               return;
+       }
+
+       mxc_iomux_v3_setup_pad(&txfs_gpio);
+
+       /* warm reset */
+       gpio_direction_output(AC97_GPIO_TXFS, 1);
+       udelay(2);
+       gpio_set_value(AC97_GPIO_TXFS, 0);
+
+       gpio_free(AC97_GPIO_TXFS);
+       mxc_iomux_v3_setup_pad(&txfs);
+}
+
+static void cupid_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+       struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+       struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+       struct pad_desc txd_gpio = MX35_PAD_STXD4__GPIO2_28;
+       struct pad_desc txd = MX35_PAD_STXD4__AUDMUX_AUD4_TXD;
+       struct pad_desc reset_gpio = MX35_PAD_ATA_DATA14__GPIO2_27;
+       int ret;
+
+       ret = gpio_request(AC97_GPIO_TXFS, "SSI");
+       if (ret)
+               goto err1;
+
+       ret = gpio_request(AC97_GPIO_TXD, "SSI");
+       if (ret)
+               goto err2;
+
+       ret = gpio_request(AC97_GPIO_RESET, "SSI");
+       if (ret)
+               goto err3;
+
+       mxc_iomux_v3_setup_pad(&txfs_gpio);
+       mxc_iomux_v3_setup_pad(&txd_gpio);
+       mxc_iomux_v3_setup_pad(&reset_gpio);
+
+       gpio_direction_output(AC97_GPIO_TXFS, 0);
+       gpio_direction_output(AC97_GPIO_TXD, 0);
+
+       /* cold reset */
+       gpio_direction_output(AC97_GPIO_RESET, 0);
+       udelay(10);
+       gpio_direction_output(AC97_GPIO_RESET, 1);
+
+       mxc_iomux_v3_setup_pad(&txd);
+       mxc_iomux_v3_setup_pad(&txfs);
+
+       gpio_free(AC97_GPIO_RESET);
+
+       gpio_request(AC97_GPIO_INT, "SSI");
+       gpio_direction_input(AC97_GPIO_INT);
+err3:
+       gpio_free(AC97_GPIO_TXD);
+err2:
+       gpio_free(AC97_GPIO_TXFS);
+err1:
+       if (ret)
+               printk(KERN_WARN "%s failed with %d\n", __func__, ret);
+       mdelay(1);
+}
+
+static struct imx_ssi_platform_data ssi_pdata = {
+       .ac97_reset = cupid_ac97_cold_reset,
+       .ac97_warm_reset = cupid_ac97_warm_reset,
+       .flags = IMX_SSI_USE_AC97,
 };

 static struct mxc_nand_platform_data nand_pdata = {
@@ -153,10 +244,23 @@ static void __init mxc_board_init(void)
 {
        mxc_iomux_v3_setup_multiple_pads(cupid_pads, ARRAY_SIZE(cupid_pads));

+       mxc_audmux_v2_configure_port(3,
+                       MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+                       MXC_AUDMUX_V2_PTCR_TFSEL(0) |
+                       MXC_AUDMUX_V2_PTCR_TFSDIR,
+                       MXC_AUDMUX_V2_PDCR_RXDSEL(0));
+
+       mxc_audmux_v2_configure_port(0,
+                       MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+                       MXC_AUDMUX_V2_PTCR_TCSEL(3) |
+                       MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+                       MXC_AUDMUX_V2_PDCR_RXDSEL(3));
+
        platform_add_devices(devices, ARRAY_SIZE(devices));

        mxc_register_device(&mxc_uart_device0, &uart_pdata);
        mxc_register_device(&mxc_nand_device, &nand_pdata);
+       mxc_register_device(&imx_ssi_device0, &ssi_pdata);

        mxc_register_device(&mx3_ipu, &mx3_ipu_data);
        mxc_register_device(&mx3_fb, &mx3fb_pdata);
--
1.6.0.2
