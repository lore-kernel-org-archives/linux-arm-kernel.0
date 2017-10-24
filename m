From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Oct 2017 10:57:29 +0200
Subject: [PATCH RFC] usb: chipidea: imx: make over-current polarity
 configurable for i.MX25
Message-ID: <20171024085729.3712-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 9dba516ed282 ("usb: chipidea: imx: set over current polarity
per dts setting") i.MX6 and i.MX7 learned the dt property
"over-current-active-high". The difference compared to i.MX25 is that on
the latter the default in hardware and the driver is already
active-high. For that reason the over-current-active-high property is
added to the imx25 template to keep the default behaviour.

The obvious downside is that device trees that were compiled before this
change don't have that property and so when run with a kernel including
this change suddenly use active low logic. This could only be
circumvented with another property "over-current-active-low" and
different default handling for imx6/7 vs imx25 if none (or both) of the
properties are present. For simplicity I stick to the easier and better
understandable alternative at the cost of dt incompatibility.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

is it ok to break compatibility here?

Best regards
Uwe

 arch/arm/boot/dts/imx25.dtsi       |  2 ++
 drivers/usb/chipidea/usbmisc_imx.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 09ce8b81fafa..bb0054603846 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -565,6 +565,7 @@
 				fsl,usbphy = <&usbphy0>;
 				phy_type = "utmi";
 				dr_mode = "otg";
+				over-current-active-high;
 				status = "disabled";
 			};
 
@@ -576,6 +577,7 @@
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
+				over-current-active-high;
 				status = "disabled";
 			};
 
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 9f4a0185dd60..6f3d0341357c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -125,16 +125,27 @@ static int usbmisc_imx25_init(struct imx_usbmisc_data *data)
 		val = readl(usbmisc->base);
 		val &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PP_BIT);
 		val |= (MX25_EHCI_INTERFACE_DIFF_UNI & MX25_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
-		val |= (MX25_OTG_PM_BIT | MX25_OTG_OCPOL_BIT);
+		val |= MX25_OTG_PM_BIT;
+
+		if (data->oc_polarity)
+			val |= MX25_OTG_OCPOL_BIT;
+		else
+			val &= ~MX25_OTG_OCPOL_BIT;
+
 		writel(val, usbmisc->base);
 		break;
 	case 1:
 		val = readl(usbmisc->base);
 		val &= ~(MX25_H1_SIC_MASK | MX25_H1_PP_BIT |  MX25_H1_IPPUE_UP_BIT);
 		val |= (MX25_EHCI_INTERFACE_SINGLE_UNI & MX25_EHCI_INTERFACE_MASK) << MX25_H1_SIC_SHIFT;
-		val |= (MX25_H1_PM_BIT | MX25_H1_OCPOL_BIT | MX25_H1_TLL_BIT |
+		val |= (MX25_H1_PM_BIT | MX25_H1_TLL_BIT |
 			MX25_H1_USBTE_BIT | MX25_H1_IPPUE_DOWN_BIT);
 
+		if (data->oc_polarity)
+			val |= MX25_H1_OCPOL_BIT;
+		else
+			val &= ~MX25_H1_OCPOL_BIT;
+
 		writel(val, usbmisc->base);
 
 		break;
-- 
2.11.0
