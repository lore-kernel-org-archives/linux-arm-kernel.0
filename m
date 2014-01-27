From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 27 Jan 2014 10:42:52 +0100
Subject: imx6: usbhc2/3 and HSIC
In-Reply-To: <CAH9NwWckD5Rmr9oW2Gr071V2p0FjRJcttYpB4qQNEWTxDEJ6qw@mail.gmail.com>
References: <CAH9NwWckD5Rmr9oW2Gr071V2p0FjRJcttYpB4qQNEWTxDEJ6qw@mail.gmail.com>
Message-ID: <1390815772.4847.9.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

Am Montag, den 27.01.2014, 10:22 +0100 schrieb Christian Gmeiner:
> Hi all...
> 
> does anyone used the usbhc2 or usbhc3 in HSIC mode? I am trying my
> luck but I do not
> get it to work. Is there anything special I need to take care of?
> 
I remember we had this working on a board back in the 3.10 days. The
only thing I remember which is specific to HSIC is in the attached
patch. This isn't really clean and should be done in a better way for
mainline, but maybe it provides some pointers for you.

Regards,
Lucas
------------------------------>8------------------------------------
>From 5af9a0597a329a2c4af012fd0fb54f525b45f625 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 28 Jan 2013 13:08:08 +0100
Subject: [PATCH] ARM/USB i.MX6: Add HSIC support

On i.MX6 HOST2 and HOST3 are HSIC only ports. These have the special
requirement that they need the to set a pullup on the strobe line
after initialization.
Fortunately only one routing option for the HSIC ports exist, so we
can put the pinmux setup completely into the i.MX6 dtsi file.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi       | 32 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi     |  8 ++++++++
 drivers/usb/chipidea/ci13xxx_imx.c | 10 ++++++++++
 drivers/usb/chipidea/usbmisc_imx.c |  5 +++++
 4 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 21e675848bd1..18ffb5f91439 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -253,6 +253,38 @@
 					};
 				};
 
+				usbh2 {
+					pinctrl_usbh2: usbh2grp {
+						fsl,pins = <
+							MX6Q_PAD_RGMII_TXC__USB_H2_DATA       0x13030
+							MX6Q_PAD_RGMII_TX_CTL__USB_H2_STROBE  0x13030
+						>;
+					};
+
+					pinctrl_usbh2_enabled: usbh2grp-enabled {
+						fsl,pins = <
+							MX6Q_PAD_RGMII_TXC__USB_H2_DATA       0x13030
+							MX6Q_PAD_RGMII_TX_CTL__USB_H2_STROBE  0x17030
+						>;
+					};
+				};
+
+				usbh3 {
+					pinctrl_usbh3: usbh3grp-1 {
+						fsl,pins = <
+							MX6Q_PAD_RGMII_RX_CTL__USB_H3_DATA    0x13030
+							MX6Q_PAD_RGMII_RXC__USB_H3_STROBE     0x13030
+						>;
+					};
+
+					pinctrl_usbh3_enabled: usbh3grp-enabled {
+						fsl,pins = <
+							MX6Q_PAD_RGMII_RX_CTL__USB_H3_DATA    0x13030
+							MX6Q_PAD_RGMII_RXC__USB_H3_STROBE     0x17030
+						>;
+					};
+				};
+
 				usdhc2 {
 					pinctrl_usdhc2_1: usdhc2grp-1 {
 						fsl,pins = <
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9e8296e4c343..884c512eff04 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -626,7 +626,11 @@
 				interrupts = <0 41 0x04>;
 				clocks = <&clks 162>;
 				fsl,usbmisc = <&usbmisc 2>;
+				phy_type = "hsic";
 				status = "disabled";
+				pinctrl-names = "default", "enabled";
+				pinctrl-0 = <&pinctrl_usbh2>;
+				pinctrl-1 = <&pinctrl_usbh2_enabled>;
 			};
 
 			usbh3: usb at 02184600 {
@@ -635,7 +639,11 @@
 				interrupts = <0 42 0x04>;
 				clocks = <&clks 162>;
 				fsl,usbmisc = <&usbmisc 3>;
+				phy_type = "hsic";
 				status = "disabled";
+				pinctrl-names = "default", "enabled";
+				pinctrl-0 = <&pinctrl_usbh3>;
+				pinctrl-1 = <&pinctrl_usbh3_enabled>;
 			};
 
 			usbmisc: usbmisc: usbmisc at 02184800 {
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 2ec9052c7bb7..f770328d4901 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -99,6 +99,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 	struct usb_phy *phy;
+	struct pinctrl *pinctrl;
 
 	if (of_find_property(pdev->dev.of_node, "fsl,usbmisc", NULL)
 		&& !usbmisc_ops)
@@ -197,6 +198,15 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(pinctrl)) {
+		struct pinctrl_state *state;
+
+		state = pinctrl_lookup_state(pinctrl, "enabled");
+		if (!IS_ERR(state))
+			pinctrl_select_state(pinctrl, state);
+	}
+
 	return 0;
 
 disable_device:
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 588bae8eef5e..e29c5aa51b07 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -145,6 +145,11 @@ static int usbmisc_imx6q_init(struct device *dev)
 		spin_unlock_irqrestore(&usbmisc->lock, flags);
 	}
 
+	if (usbdev->index == 2 || usbdev->index == 3) {
+		writel(0x00003000, usbmisc->base + usbdev->index * 4);
+		writel(0x80001842, usbmisc->base + 0x8 + usbdev->index * 4);
+	}
+
 	return 0;
 }
 
-- 
1.8.5.2



-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
