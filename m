From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Thu, 28 Jun 2012 16:59:46 +0200 (CEST)
Subject: [PATCH 2 of 2] ARM: imx: fix mx51 ehci setup errors
Message-ID: <1438563136.254282.1340895586756.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch completes commit 08406f5 by fixing the following issues, according to
the reference manual:
* MXC_OTG_UCTRL_OPM_BIT disables (masks) the power/oc pins if set, like H1PM and
  H2PM, not the opposite.
* MXC_OTG_PHYCTRL_OC_DIS_BIT disables the oc pin if set, like H1_OC_DIS, not the
  opposite.
* Typos in comments.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/ehci-imx5.c                  |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx5.c linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx5.c
index 49e3b34..a6a4afb 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/ehci-imx5.c
+++ linux-next-HEAD-49289f3/arch/arm/mach-imx/ehci-imx5.c
@@ -88,11 +88,11 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 			else
 				v &= ~MXC_OTG_PHYCTRL_OC_POL_BIT;
 			if (flags & MXC_EHCI_POWER_PINS_ENABLED) {
-				/* OC/USBPWR is not used */
-				v |= MXC_OTG_PHYCTRL_OC_DIS_BIT;
-			} else {
 				/* OC/USBPWR is used */
 				v &= ~MXC_OTG_PHYCTRL_OC_DIS_BIT;
+			} else {
+				/* OC/USBPWR is not used */
+				v |= MXC_OTG_PHYCTRL_OC_DIS_BIT;
 			}
 			if (flags & MXC_EHCI_PWR_PIN_ACTIVE_HIGH)
 				v |= MXC_OTG_PHYCTRL_PWR_POL_BIT;
@@ -106,9 +106,9 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 			else
 				v &= ~MXC_OTG_UCTRL_OWIE_BIT;/* OTG wakeup disable */
 			if (flags & MXC_EHCI_POWER_PINS_ENABLED)
-				v |= MXC_OTG_UCTRL_OPM_BIT;
-			else
 				v &= ~MXC_OTG_UCTRL_OPM_BIT;
+			else
+				v |= MXC_OTG_UCTRL_OPM_BIT;
 			__raw_writel(v, usbother_base + MXC_USBCTRL_OFFSET);
 		}
 		break;
@@ -124,7 +124,7 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 		}
 
 		if (flags & MXC_EHCI_POWER_PINS_ENABLED)
-			v &= ~MXC_H1_UCTRL_H1PM_BIT; /* HOST1 power mask used*/
+			v &= ~MXC_H1_UCTRL_H1PM_BIT; /* HOST1 power mask unused*/
 		else
 			v |= MXC_H1_UCTRL_H1PM_BIT; /* HOST1 power mask used*/
 		__raw_writel(v, usbother_base + MXC_USBCTRL_OFFSET);
@@ -157,7 +157,7 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 		}
 
 		if (flags & MXC_EHCI_POWER_PINS_ENABLED)
-			v &= ~MXC_H2_UCTRL_H2PM_BIT; /* HOST2 power mask used*/
+			v &= ~MXC_H2_UCTRL_H2PM_BIT; /* HOST2 power mask unused*/
 		else
 			v |= MXC_H2_UCTRL_H2PM_BIT; /* HOST2 power mask used*/
 		__raw_writel(v, usbother_base + MXC_USBH2CTRL_OFFSET);
