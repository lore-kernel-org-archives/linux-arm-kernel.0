From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Tue, 28 Feb 2012 17:48:04 +0000
Subject: [PATCH 2/2] ehci-imx25.c: use new flags from mxc_ehci.h in usb_hwinit
Message-ID: <3F263ABB4EDE344D974E1983B56807739E4BC6BA@EX-DAG02.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: T. Mehnert <t.mehnert@eckelmann.de>
Date: Thu, 16 Feb 2012 14:39:20 +0100
Subject: [PATCH] ehci-imx25.c adding support of options in mxc_ehci.h

This Patch implements the new options in mxc_ehci.h for the
hardware initialisation.
---
 arch/arm/mach-imx/ehci-imx25.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/ehci-imx25.c b/arch/arm/mach-imx/ehci-imx25.c
index 865daf0..17f7267 100644
--- a/arch/arm/mach-imx/ehci-imx25.c
+++ b/arch/arm/mach-imx/ehci-imx25.c
@@ -24,9 +24,14 @@
 #define MX25_OTG_SIC_SHIFT	29
 #define MX25_OTG_SIC_MASK	(0x3 << MX25_OTG_SIC_SHIFT)
 #define MX25_OTG_PM_BIT		(1 << 24)
+#define MX25_OTG_PP_BIT		(1 << 11)
+#define MX25_OTG_XCSO_BIT	(1 << 10)
 
 #define MX25_H1_SIC_SHIFT	21
 #define MX25_H1_SIC_MASK	(0x3 << MX25_H1_SIC_SHIFT)
+#define MX25_H1_PP_BIT		(1 << 18)
+#define MX25_H1_HLKEN_BIT	(1 << 12)
+#define MX25_H1_XCSH_BIT	(1 << 9)
 #define MX25_H1_PM_BIT		(1 << 8)
 #define MX25_H1_IPPUE_UP_BIT	(1 << 7)
 #define MX25_H1_IPPUE_DOWN_BIT	(1 << 6)
@@ -47,6 +52,9 @@ int mx25_initialize_usb_hw(int port, unsigned int flags)
 		if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 			v |= MX25_OTG_PM_BIT;
 
+		if (flags & MXC_EHCI_XCVR_FORCED_INTERNAL)
+			v |= MX25_OTG_XCSO_BIT;
+
 		break;
 	case 1: /* H1 port */
 		v &= ~(MX25_H1_SIC_MASK | MX25_H1_PM_BIT | MX25_H1_TLL_BIT |
@@ -68,6 +76,15 @@ int mx25_initialize_usb_hw(int port, unsigned int flags)
 		if (flags & MXC_EHCI_IPPUE_UP)
 			v |= MX25_H1_IPPUE_UP_BIT;
 
+		if (flags & MXC_EHCI_AHB_LOCK_ENABLE)
+			v |= MX25_H1_HLKEN_BIT;
+
+		if (flags & MXC_EHCI_POWER_POLARITY_HIGH)
+			v |= MX25_H1_PP_BIT;
+
+		if (flags & MXC_EHCI_XCVR_FORCED_INTERNAL)
+			v |= MX25_H1_XCSH_BIT;
+
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.0.4

---
Torsten Mehnert
K?lte- und Geb?udeleittechnik (KGL)
?
ECKELMANN AG
Berliner Stra?e 161
D - 65205 Wiesbaden
?
Phone:	+49 (0) 611 / 7103 - 370
Fax:	+49 (0) 611 / 7103 - 133

e-Mail:	mailto:t.mehnert@eckelmann.de
Web:	http://www.eckelmann.de
