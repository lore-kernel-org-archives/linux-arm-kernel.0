From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 27 Feb 2014 20:06:18 +0800
Subject: [PATCH] ARM: i.MX6: clk: Remove usbphy clock hacks
In-Reply-To: <1393489138-24406-1-git-send-email-s.hauer@pengutronix.de>
References: <1393489138-24406-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140227120616.GA27749@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 09:18:58AM +0100, Sascha Hauer wrote:
> Recently the chipidea got broken on i.MX6 when the phy_mode property
> is given in the devicetree. Since this commit:
> 
> | commit cd0b42c2a6d2a74244f0053f8960f5dad5842278
> | Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> | Date:   Fri Jan 10 13:51:30 2014 +0800
> |
> |     usb: chipidea: put hw_phymode_configure before ci_usb_phy_init
> |
> |     hw_phymode_configure configures the PORTSC registers and allow the
> |     following phy_inits to operate on the right parameters. This fix a problem
> |     where the UPLI (ISP1504) could not be detected, because the Viewport was not
> |     available and read the viewport return 0's only.
> |
> |     Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> |     Signed-off-by: Peter Chen <peter.chen@freescale.com>
> |     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> the portsc register is configured before the phy clock is enabled. The CPU
> immediately hangs once the portsc register is written to with disabled phy
> clocks.
> 
> The following patch added a hack to the i.MX6 clock support. Its purpose
> was to keep the usbphy clock gates enabled:
> 
> | commit a5120e89e7e187a91852896f586876c7a2030804
> | Author: Peter Chen <peter.chen@freescale.com>
> | Date:   Fri Jan 18 10:38:05 2013 +0800
> |
> |     ARM i.MX6: change mxs usbphy clock usage
> |
> |     This mxs usbphy is only needs to be on after system boots
> |     up, and software never needs to control it anymore.
> |     Meanwhile, usbphy's parent needs to be notified if usb
> |     is suspend or not. So we design below mxs usbphy usage:
> |
> |     - usbphy1_gate and usbphy2_gate:
> |     Their parents are dummy clock, we only needs to enable
> |     it after system boots up.
> |     - usbphy1 and usbphy2
> |     Usage reserved bit for this clock, in that case, the refcount
> |     will be updated, but without hardware changing.
> |
> |     Signed-off-by: Peter Chen <peter.chen@freescale.com>
> |     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Now this patch indeed keeps the gates enabled, but it doesn't keep the parents
> enabled, so the whole patch becomes a no-op once the parents get disabled. This
> nowadays happens with more aggressive clock disabling for example in the UART
> driver (which uses the same PLL as usbphy1).
> 
> This patch reverts the reserved register bit hackery and instead enables
> the usbphy clocks when support for the mxsphy is enabled.

It will cause pll3 is still on when no user has used it.

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> The above are my current state of observations. I think I still haven't fully
> understood the purpose of the clock hacks introduced with a5120e89e7e187.

usbphy1/usbphy2 are used to mark usbphy as pll3/pll7's child, once the
usbphy is enabled, the pll should be enabled, if no other user for pll3,
the pll3 should still be on since the usbphy is using.

usbphy1_gate/usbphy2_gate are used to control usb gate for pll, due to
special requirement from IC guys, these two bits are needed to open
before any usb operations, and there two bits are never needed to change
on the fly.

The reason why we meet such issue?
For internal phy(like UTMI), the phy clock is from internal pll,
it is on/off on the fly, the access PORTSC.PTS will hang without
phy clock. So, usb_phy_init needs to be called before
hw_phymode_configure.

For external PHY (like ulpi), the phy clock is from board, access
PORTSC.PTS may not need clock or we need to enhance ulpi driver to
support open and close external phy on the fly. It needs to config
PORTSC.PTS prior to visit view-port which is needed at its phy_init.
So, hw_phymode_configure is needed to be called before usb_phy_init.

> 
>  arch/arm/mach-imx/clk-imx6q.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 4d677f4..a26cdcc 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -104,8 +104,8 @@ enum mx6q_clks {
>  	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
>  	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
>  	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
> -	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
> -	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
> +	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate_unused,
> +	usbphy2_gate_unused, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
>  	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, pll4_audio_div,
>  	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, clk_max
>  };
> @@ -173,21 +173,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[pll6_enet]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll6_enet",	"osc", base + 0xe0, 0x3);
>  	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
>  
> -	/*
> -	 * Bit 20 is the reserved and read-only bit, we do this only for:
> -	 * - Do nothing for usbphy clk_enable/disable
> -	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
> -	 * the clk framework may need to enable/disable usbphy's parent
> -	 */
> -	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 20);
> -	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
> -
> -	/*
> -	 * usbphy*_gate needs to be on after system boots up, and software
> -	 * never needs to control it anymore.
> -	 */
> -	clk[usbphy1_gate] = imx_clk_gate("usbphy1_gate", "dummy", base + 0x10, 6);
> -	clk[usbphy2_gate] = imx_clk_gate("usbphy2_gate", "dummy", base + 0x20, 6);
> +	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
> +	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
>  
>  	clk[sata_ref] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
>  	clk[pcie_ref] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
> @@ -461,8 +448,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		clk_prepare_enable(clk[clks_init_on[i]]);
>  
>  	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
> -		clk_prepare_enable(clk[usbphy1_gate]);
> -		clk_prepare_enable(clk[usbphy2_gate]);
> +		clk_prepare_enable(clk[usbphy1]);
> +		clk_prepare_enable(clk[usbphy2]);
>  	}
>  
>  	/*
> -- 
> 1.8.5.3
> 
> 
> 
Below patch may help to fix this issue:

>From 8a453a6863ece8d5e36359c92ceba334198c58fb Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@freescale.com>
Date: Thu, 27 Feb 2014 19:57:01 +0800
Subject: [PATCH 1/1] usb: chipidea: core: coordinate configurate phymode and
 usb_phy_init

For internal PHY (like UTMI), the phy clock may from internal pll,
it is on/off on the fly, the access PORTSC.PTS will hang without
phy clock. So, usb_phy_init needs to be called before hw_phymode_configure.

For external PHY (like ulpi), it needs to configure portsc.pts before
visit viewport, so ph_phymode_configure needs to be called before
usb_phy_init which will visit viewport.

This commit coordinates configure portsc.pts for different phys.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index ca6831c..ae2e027 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -235,34 +235,50 @@ static int hw_device_init(struct ci_hdrc *ci, void __iomem *base)
 	return 0;
 }
 
-static void hw_phymode_configure(struct ci_hdrc *ci)
+static int ci_usb_phy_init(struct ci_hdrc *ci)
 {
 	u32 portsc, lpm, sts = 0;
+	int ret = -ENODEV;
 
 	switch (ci->platdata->phy_mode) {
 	case USBPHY_INTERFACE_MODE_UTMI:
+		ret = usb_phy_init(ci->transceiver);
+		if (ret)
+			return ret;
 		portsc = PORTSC_PTS(PTS_UTMI);
 		lpm = DEVLC_PTS(PTS_UTMI);
 		break;
 	case USBPHY_INTERFACE_MODE_UTMIW:
+		ret = usb_phy_init(ci->transceiver);
+		if (ret)
+			return ret;
 		portsc = PORTSC_PTS(PTS_UTMI) | PORTSC_PTW;
 		lpm = DEVLC_PTS(PTS_UTMI) | DEVLC_PTW;
 		break;
 	case USBPHY_INTERFACE_MODE_ULPI:
 		portsc = PORTSC_PTS(PTS_ULPI);
 		lpm = DEVLC_PTS(PTS_ULPI);
+		ret = usb_phy_init(ci->transceiver);
+		if (ret)
+			return ret;
 		break;
 	case USBPHY_INTERFACE_MODE_SERIAL:
 		portsc = PORTSC_PTS(PTS_SERIAL);
 		lpm = DEVLC_PTS(PTS_SERIAL);
 		sts = 1;
+		ret = usb_phy_init(ci->transceiver);
+		if (ret)
+			return ret;
 		break;
 	case USBPHY_INTERFACE_MODE_HSIC:
+		ret = usb_phy_init(ci->transceiver);
+		if (ret)
+			return ret;
 		portsc = PORTSC_PTS(PTS_HSIC);
 		lpm = DEVLC_PTS(PTS_HSIC);
 		break;
 	default:
-		return;
+		return ret;
 	}
 
 	if (ci->hw_bank.lpm) {
@@ -274,6 +290,8 @@ static void hw_phymode_configure(struct ci_hdrc *ci)
 		if (sts)
 			hw_write(ci, OP_PORTSC, PORTSC_STS, PORTSC_STS);
 	}
+
+	return ret;
 }
 
 /**
@@ -543,8 +561,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	hw_phymode_configure(ci);
-
 	if (ci->platdata->phy)
 		ci->transceiver = ci->platdata->phy;
 	else
@@ -564,7 +580,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	ret = usb_phy_init(ci->transceiver);
+	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
 		return ret;
-- 
1.7.8

-- 

Best Regards,
Peter Chen
