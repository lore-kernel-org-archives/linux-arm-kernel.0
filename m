From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 23 Dec 2015 10:31:10 +0800
Subject: [PATCH v5 3/7] ARM: dts: imx: Add Advantech BA-16 Qseven module
In-Reply-To: <5679D1B9.20304@timesys.com>
References: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
 <1449177036-13317-4-git-send-email-akshay.bhat@timesys.com>
 <20151222113742.GA26290@tiger> <5679D1B9.20304@timesys.com>
Message-ID: <20151223023035.GH26290@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 05:42:01PM -0500, Akshay Bhat wrote:
> >>+&iomuxc {
> >
> >Suggest to put the iomuxc node at the bottom of the dts to make the read
> >of this file a bit easier.
> >
> Will fix it
> 
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&pinctrl_hog>;
> >>+
> >>+	imx6q-ba16 {
> >
> >With commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
> >nodes) in place, we can get rid of this container node to save one level
> >of indentation.
> >
> 
> If i remove the imx6q-ba16 container node, then I get multiple
> errors during boot.
> 
> [    2.043594] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node ecspi1grp
> .....
> [    2.467403] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usbotggrp
> [    2.482394] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usbhubgrp
> .....
> [    2.640509] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc2grp
> [    2.640889] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc2grp
> [    2.640986] sdhci-esdhc-imx: probe of 2194000.usdhc failed with error -22
> [    2.641048] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc3grp
> [    2.641301] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc3grp
> [    2.641385] sdhci-esdhc-imx: probe of 2198000.usdhc failed with error -22
> [    2.641446] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc4grp
> [    2.641688] imx6q-pinctrl 20e0000.iomuxc: unable to find group
> for node usdhc4grp
> [    2.641770] sdhci-esdhc-imx: probe of 219c000.usdhc failed with error -22

Sorry.  I just found that to get this work on imx6q board we need to
clean up the ipu2/ipu2grp-1 group from imx6q.dtsi.  I just send a patch
doing that with you on copy.  Let me know if it works for you with that
change.

Shawn

> 
> 
> The change I did was:
> 
> &iomuxc {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_hog>;
> 
> 	pinctrl_audmux: audmux {
> 		fsl,pins = <
> 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
> 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x130b0
> 			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
> 			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
> 		>;
> 	};
> 
> 	pinctrl_display: dispgrp {
> 		fsl,pins = <
> 			/* BLEN_OUT */
> 			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x1b0b0
> 			/* LVDS_PPEN_OUT */
> 			MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x1b0b0
> 		>;
> 	};
> 
> 	pinctrl_ecspi1: ecspi1grp {
> 		fsl,pins = <
> 			MX6QDL_PAD_EIM_D17__ECSPI1_MISO	0x100b1
> 			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI	0x100b1
> 			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK	0x100b1
> 			/* SPI1 CS */
> 			MX6QDL_PAD_EIM_EB2__GPIO2_IO30	0x1b0b0
> 		>;
> 	};
> 
> 	............
> 
> 	pinctrl_wdog: wdoggrp {
> 		fsl,pins = <
> 			MX6QDL_PAD_GPIO_9__WDOG1_B	0x1b0b0
> 		>;
> 	};
> };
