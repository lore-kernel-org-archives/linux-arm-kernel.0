From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Thu, 28 Jun 2012 16:59:23 +0200 (CEST)
Subject: [PATCH 1 of 2] ARM: imx: make ehci power/oc polarities configurable
Message-ID: <1835382005.254270.1340895563607.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make ehci power and overcurrent polarities configurable. If not set, these new
configurartions keep the default register values so that existing board files
do not have to be changed.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/ehci-imx25.c                 |   24 +++++++++++++++++---
 .../arch/arm/mach-imx/ehci-imx35.c                 |   24 +++++++++++++++++---
 .../arch/arm/mach-imx/ehci-imx5.c                  |   17 +++++++++++++-
 .../arch/arm/plat-mxc/include/mach/mxc_ehci.h      |   16 +++++++------
 4 files changed, 67 insertions(+), 14 deletions(-)

diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx25.c linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx25.c
index 865daf0..05bb41d 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx25.c
+++ linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx25.c
@@ -24,14 +24,18 @@
 #define MX25_OTG_SIC_SHIFT	29
 #define MX25_OTG_SIC_MASK	(0x3 << MX25_OTG_SIC_SHIFT)
 #define MX25_OTG_PM_BIT		(1 << 24)
+#define MX25_OTG_PP_BIT		(1 << 11)
+#define MX25_OTG_OCPOL_BIT	(1 << 3)
 
 #define MX25_H1_SIC_SHIFT	21
 #define MX25_H1_SIC_MASK	(0x3 << MX25_H1_SIC_SHIFT)
+#define MX25_H1_PP_BIT		(1 << 18)
 #define MX25_H1_PM_BIT		(1 << 8)
 #define MX25_H1_IPPUE_UP_BIT	(1 << 7)
 #define MX25_H1_IPPUE_DOWN_BIT	(1 << 6)
 #define MX25_H1_TLL_BIT		(1 << 5)
 #define MX25_H1_USBTE_BIT	(1 << 4)
+#define MX25_H1_OCPOL_BIT	(1 << 2)
 
 int mx25_initialize_usb_hw(int port, unsigned int flags)
 {
@@ -41,21 +45,35 @@ int mx25_initialize_usb_hw(int port, unsigned int flags)
 
 	switch (port) {
 	case 0:	/* OTG port */
-		v &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PM_BIT);
+		v &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PM_BIT | MX25_OTG_PP_BIT |
+			MX25_OTG_OCPOL_BIT);
 		v |= (flags & MXC_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
 
 		if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 			v |= MX25_OTG_PM_BIT;
 
+		if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
+			v |= MX25_OTG_PP_BIT;
+
+		if (!(flags & MXC_EHCI_OC_PIN_ACTIVE_LOW))
+			v |= MX25_OTG_OCPOL_BIT;
+
 		break;
 	case 1: /* H1 port */
-		v &= ~(MX25_H1_SIC_MASK | MX25_H1_PM_BIT | MX25_H1_TLL_BIT |
-			MX25_H1_USBTE_BIT | MX25_H1_IPPUE_DOWN_BIT | MX25_H1_IPPUE_UP_BIT);
+		v &= ~(MX25_H1_SIC_MASK | MX25_H1_PM_BIT | MX25_H1_PP_BIT |
+			MX25_H1_OCPOL_BIT | MX25_H1_TLL_BIT | MX25_H1_USBTE_BIT |
+			MX25_H1_IPPUE_DOWN_BIT | MX25_H1_IPPUE_UP_BIT);
 		v |= (flags & MXC_EHCI_INTERFACE_MASK) << MX25_H1_SIC_SHIFT;
 
 		if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 			v |= MX25_H1_PM_BIT;
 
+		if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
+			v |= MX25_H1_PP_BIT;
+
+		if (!(flags & MXC_EHCI_OC_PIN_ACTIVE_LOW))
+			v |= MX25_H1_OCPOL_BIT;
+
 		if (!(flags & MXC_EHCI_TTL_ENABLED))
 			v |= MX25_H1_TLL_BIT;
 
diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx35.c linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx35.c
index 001ec39..73574c3 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx35.c
+++ linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx35.c
@@ -24,14 +24,18 @@
 #define MX35_OTG_SIC_SHIFT	29
 #define MX35_OTG_SIC_MASK	(0x3 << MX35_OTG_SIC_SHIFT)
 #define MX35_OTG_PM_BIT		(1 << 24)
+#define MX35_OTG_PP_BIT		(1 << 11)
+#define MX35_OTG_OCPOL_BIT	(1 << 3)
 
 #define MX35_H1_SIC_SHIFT	21
 #define MX35_H1_SIC_MASK	(0x3 << MX35_H1_SIC_SHIFT)
+#define MX35_H1_PP_BIT		(1 << 18)
 #define MX35_H1_PM_BIT		(1 << 8)
 #define MX35_H1_IPPUE_UP_BIT	(1 << 7)
 #define MX35_H1_IPPUE_DOWN_BIT	(1 << 6)
 #define MX35_H1_TLL_BIT		(1 << 5)
 #define MX35_H1_USBTE_BIT	(1 << 4)
+#define MX35_H1_OCPOL_BIT	(1 << 2)
 
 int mx35_initialize_usb_hw(int port, unsigned int flags)
 {
@@ -41,21 +45,35 @@ int mx35_initialize_usb_hw(int port, unsigned int flags)
 
 	switch (port) {
 	case 0:	/* OTG port */
-		v &= ~(MX35_OTG_SIC_MASK | MX35_OTG_PM_BIT);
+		v &= ~(MX35_OTG_SIC_MASK | MX35_OTG_PM_BIT | MX35_OTG_PP_BIT |
+			MX35_OTG_OCPOL_BIT);
 		v |= (flags & MXC_EHCI_INTERFACE_MASK) << MX35_OTG_SIC_SHIFT;
 
 		if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 			v |= MX35_OTG_PM_BIT;
 
+		if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
+			v |= MX35_OTG_PP_BIT;
+
+		if (!(flags & MXC_EHCI_OC_PIN_ACTIVE_LOW))
+			v |= MX35_OTG_OCPOL_BIT;
+
 		break;
 	case 1: /* H1 port */
-		v &= ~(MX35_H1_SIC_MASK | MX35_H1_PM_BIT | MX35_H1_TLL_BIT |
-			MX35_H1_USBTE_BIT | MX35_H1_IPPUE_DOWN_BIT | MX35_H1_IPPUE_UP_BIT);
+		v &= ~(MX35_H1_SIC_MASK | MX35_H1_PM_BIT | MX35_H1_PP_BIT |
+			MX35_H1_OCPOL_BIT | MX35_H1_TLL_BIT | MX35_H1_USBTE_BIT |
+			MX35_H1_IPPUE_DOWN_BIT | MX35_H1_IPPUE_UP_BIT);
 		v |= (flags & MXC_EHCI_INTERFACE_MASK) << MX35_H1_SIC_SHIFT;
 
 		if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 			v |= MX35_H1_PM_BIT;
 
+		if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
+			v |= MX35_H1_PP_BIT;
+
+		if (!(flags & MXC_EHCI_OC_PIN_ACTIVE_LOW))
+			v |= MX35_H1_OCPOL_BIT;
+
 		if (!(flags & MXC_EHCI_TTL_ENABLED))
 			v |= MX35_H1_TLL_BIT;
 
diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx5.c linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx5.c
index c17fa13..49e3b34 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx5.c
+++ linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx5.c
@@ -28,11 +28,14 @@
 #define MXC_OTG_UCTRL_OPM_BIT		(1 << 24)	/* OTG power mask */
 #define MXC_H1_UCTRL_H1UIE_BIT		(1 << 12)	/* Host1 ULPI interrupt enable */
 #define MXC_H1_UCTRL_H1WIE_BIT		(1 << 11)	/* HOST1 wakeup intr enable */
-#define MXC_H1_UCTRL_H1PM_BIT		(1 <<  8)		/* HOST1 power mask */
+#define MXC_H1_UCTRL_H1PM_BIT		(1 <<  8)	/* HOST1 power mask */
 
 /* USB_PHY_CTRL_FUNC */
+#define MXC_OTG_PHYCTRL_OC_POL_BIT	(1 << 9)	/* OTG Polarity of Overcurrent */
 #define MXC_OTG_PHYCTRL_OC_DIS_BIT	(1 << 8)	/* OTG Disable Overcurrent Event */
+#define MXC_H1_OC_POL_BIT		(1 << 6)	/* UH1 Polarity of Overcurrent */
 #define MXC_H1_OC_DIS_BIT		(1 << 5)	/* UH1 Disable Overcurrent Event */
+#define MXC_OTG_PHYCTRL_PWR_POL_BIT	(1 << 3)	/* OTG Power Pin Polarity */
 
 /* USBH2CTRL */
 #define MXC_H2_UCTRL_H2UIE_BIT		(1 << 8)
@@ -80,6 +83,10 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 		if (flags & MXC_EHCI_INTERNAL_PHY) {
 			v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC_OFFSET);
 
+			if (flags & MXC_EHCI_OC_PIN_ACTIVE_LOW)
+				v |= MXC_OTG_PHYCTRL_OC_POL_BIT;
+			else
+				v &= ~MXC_OTG_PHYCTRL_OC_POL_BIT;
 			if (flags & MXC_EHCI_POWER_PINS_ENABLED) {
 				/* OC/USBPWR is not used */
 				v |= MXC_OTG_PHYCTRL_OC_DIS_BIT;
@@ -87,6 +94,10 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 				/* OC/USBPWR is used */
 				v &= ~MXC_OTG_PHYCTRL_OC_DIS_BIT;
 			}
+			if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
+				v |= MXC_OTG_PHYCTRL_PWR_POL_BIT;
+			else
+				v &= ~MXC_OTG_PHYCTRL_PWR_POL_BIT;
 			__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC_OFFSET);
 
 			v = __raw_readl(usbother_base + MXC_USBCTRL_OFFSET);
@@ -119,6 +130,10 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 		__raw_writel(v, usbother_base + MXC_USBCTRL_OFFSET);
 
 		v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC_OFFSET);
+		if (flags & MXC_EHCI_OC_PIN_ACTIVE_LOW)
+			v |= MXC_H1_OC_POL_BIT;
+		else
+			v &= ~MXC_H1_OC_POL_BIT;
 		if (flags & MXC_EHCI_POWER_PINS_ENABLED)
 			v &= ~MXC_H1_OC_DIS_BIT; /* OC is used */
 		else
diff --git linux-next-HEAD-49289f3.orig/arch/arm/plat-mxc/include/mach/mxc_ehci.h linux-next-HEAD-49289f3/arch/arm/plat-mxc/include/mach/mxc_ehci.h
index 9ffd1bb..7eb9d13 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/plat-mxc/include/mach/mxc_ehci.h
+++ linux-next-HEAD-49289f3/arch/arm/plat-mxc/include/mach/mxc_ehci.h
@@ -20,13 +20,15 @@
 #define MXC_EHCI_INTERFACE_MASK		(0xf)
 
 #define MXC_EHCI_POWER_PINS_ENABLED	(1 << 5)
-#define MXC_EHCI_TTL_ENABLED		(1 << 6)
-
-#define MXC_EHCI_INTERNAL_PHY		(1 << 7)
-#define MXC_EHCI_IPPUE_DOWN		(1 << 8)
-#define MXC_EHCI_IPPUE_UP		(1 << 9)
-#define MXC_EHCI_WAKEUP_ENABLED	(1 << 10)
-#define MXC_EHCI_ITC_NO_THRESHOLD	(1 << 11)
+#define MXC_EHCI_PWR_PIN_ACTIVE_HIGH	(1 << 6)
+#define MXC_EHCI_OC_PIN_ACTIVE_LOW	(1 << 7)
+#define MXC_EHCI_TTL_ENABLED		(1 << 8)
+
+#define MXC_EHCI_INTERNAL_PHY		(1 << 9)
+#define MXC_EHCI_IPPUE_DOWN		(1 << 10)
+#define MXC_EHCI_IPPUE_UP		(1 << 11)
+#define MXC_EHCI_WAKEUP_ENABLED		(1 << 12)
+#define MXC_EHCI_ITC_NO_THRESHOLD	(1 << 13)
 
 #define MXC_USBCTRL_OFFSET		0
 #define MXC_USB_PHY_CTR_FUNC_OFFSET	0x8
