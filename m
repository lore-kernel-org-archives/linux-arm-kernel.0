From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 6 Dec 2013 16:17:33 +0100
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A64980411F14C@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
 <20131122154947.GE24508@pengutronix.de>
 <201311250058.32881.marex@denx.de>
 <20131125134248.GA28906@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A64980411F14C@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <20131206151733.GD2374@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Nov 26, 2013 at 12:08:03PM +0000, Peter Chen wrote:
> > The GPIO is working for this pin. But also the DIGCTL register bits
> > helped here.  Now the OC event triggers if the pin gets pulled to 3V3.
> > 
> > I am currently looking for a good place to enable the DIGCTL bits.
> > I suggest to enable them per default.  As we don't have USBMISC registers
> > in MX28, the bits should be toggled in ci_hdrc_imx.c if the of property
> > "disable-overcurrent" is not found.  I will use the syscon interface to
> > reach them with the regmap interface.
> > 
> usbmisc register doesn't stand for the register needs to be in usb controller.
> Any registers which are related to USB function can be considered as usbmisc
> registers. You will see FSL-style SoC, the over-current or other related setting
> are at controller base + 0x800 (0x600), but Sigmatel-style SoC (mx28/mx23), the usb
> register are not at controller register region.
> 
> My suggestion is: create usbmisc node for mx28, and put oc setting at there, it can
> keep ci_hdrc_imx.c clean.
> Besides, you may need two dts user setting for oc enable and oc polarity.

IMHO usbmisc is a driver with memery mapped region. So it would probably
make more sense to use syscon for that purpose, as we only need special
registers out of the digctl register.

What do you think of that code:

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 68f7f5e..ddac5cb 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -19,12 +19,18 @@
 #include <linux/dma-mapping.h>
 #include <linux/usb/chipidea.h>
 #include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
 
 #define CI_HDRC_IMX_IMX28_WRITE_FIX BIT(0)
 
+#define DIGCTL_CTRL_SET				0x4
+#define USB_OTG_OC_ENABLE_BIT			BIT(23)
+#define USB_H1_OC_ENABLE_BIT			BIT(24)
+
 struct ci_hdrc_imx_platform_flag {
 	unsigned int flags;
 };
@@ -105,6 +111,26 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 			of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
 	const struct ci_hdrc_imx_platform_flag *imx_platform_flag = of_id->data;
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *digctl;
+
+	/* Some SoCs don't have digctl registers */
+	if (of_get_property(np, "fsl,digctl", NULL)) {
+		struct of_phandle_args args;
+		int enable_bit = USB_OTG_OC_ENABLE_BIT;
+		ret = of_parse_phandle_with_args(np, "fsl,digctl", "#index-cells",
+					0, &args);
+		digctl = syscon_regmap_lookup_by_phandle
+			(np, "fsl,digctl");
+		if (IS_ERR(digctl)) {
+			dev_dbg(&pdev->dev,
+				"failed to find regmap for digctl\n");
+		} else {
+			if (args.args[0])
+				enable_bit = USB_H1_OC_ENABLE_BIT;
+			regmap_write(digctl, DIGCTL_CTRL_SET, enable_bit);
+		}
+	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {


diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 600f7cb..bb61c49 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -668,11 +668,12 @@
 				};
 			};
 
-			digctl at 8001c000 {
-				compatible = "fsl,imx28-digctl";
+			digctl: digctl at 8001c000 {
+				#index-cells = <1>;
+				compatible = "fsl,imx28-digctl", "syscon";
 				reg = <0x8001c000 0x2000>;
 				interrupts = <89>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			etm at 80022000 {
@@ -976,6 +977,7 @@
 			interrupts = <93>;
 			clocks = <&clks 60>;
 			fsl,usbphy = <&usbphy0>;
+			fsl,digctl = <&digctl 0>;
 			status = "disabled";
 		};
 
@@ -985,6 +987,7 @@
 			interrupts = <92>;
 			clocks = <&clks 61>;
 			fsl,usbphy = <&usbphy1>;
+			fsl,digctl = <&digctl 1>;
 			status = "disabled";
 		};
 
Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
