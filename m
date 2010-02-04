From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:39 +0100
Subject: [PATCH 2/8] i.MX ehci platform support: Some fixes
In-Reply-To: <1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- The SIC mask is only 2bits wide, not 4
- MX31_OTG_PM_BIT and MX31_H1_PM_BIT use negative logic
- clear MX31_H1_DT_BIT and MX31_H2_DT_BIT so that they can be cleared,
  not only set.
- return -EINVAL if called with an invalid controller number

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/plat-mxc/ehci.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 8df03f3..586b55d 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -25,16 +25,16 @@
 #define USBCTRL_OTGBASE_OFFSET	0x600
 
 #define MX31_OTG_SIC_SHIFT	29
-#define MX31_OTG_SIC_MASK	(0xf << MX31_OTG_SIC_SHIFT)
+#define MX31_OTG_SIC_MASK	(0x3 << MX31_OTG_SIC_SHIFT)
 #define MX31_OTG_PM_BIT		(1 << 24)
 
 #define MX31_H2_SIC_SHIFT	21
-#define MX31_H2_SIC_MASK	(0xf << MX31_H2_SIC_SHIFT)
+#define MX31_H2_SIC_MASK	(0x3 << MX31_H2_SIC_SHIFT)
 #define MX31_H2_PM_BIT		(1 << 16)
 #define MX31_H2_DT_BIT		(1 << 5)
 
 #define MX31_H1_SIC_SHIFT	13
-#define MX31_H1_SIC_MASK	(0xf << MX31_H1_SIC_SHIFT)
+#define MX31_H1_SIC_MASK	(0x3 << MX31_H1_SIC_SHIFT)
 #define MX31_H1_PM_BIT		(1 << 8)
 #define MX31_H1_DT_BIT		(1 << 4)
 
@@ -51,15 +51,15 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
 			v &= ~(MX31_OTG_SIC_MASK | MX31_OTG_PM_BIT);
 			v |= (flags & MXC_EHCI_INTERFACE_MASK)
 					<< MX31_OTG_SIC_SHIFT;
-			if (flags & MXC_EHCI_POWER_PINS_ENABLED)
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 				v |= MX31_OTG_PM_BIT;
 
 			break;
 		case 1: /* H1 port */
-			v &= ~(MX31_H1_SIC_MASK | MX31_H1_PM_BIT);
+			v &= ~(MX31_H1_SIC_MASK | MX31_H1_PM_BIT | MX31_H1_DT_BIT);
 			v |= (flags & MXC_EHCI_INTERFACE_MASK)
 						<< MX31_H1_SIC_SHIFT;
-			if (flags & MXC_EHCI_POWER_PINS_ENABLED)
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
 				v |= MX31_H1_PM_BIT;
 
 			if (!(flags & MXC_EHCI_TTL_ENABLED))
@@ -67,7 +67,7 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
 
 			break;
 		case 2:	/* H2 port */
-			v &= ~(MX31_H2_SIC_MASK | MX31_H2_PM_BIT);
+			v &= ~(MX31_H2_SIC_MASK | MX31_H2_PM_BIT | MX31_H2_DT_BIT);
 			v |= (flags & MXC_EHCI_INTERFACE_MASK)
 						<< MX31_H2_SIC_SHIFT;
 			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
@@ -77,6 +77,8 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
 				v |= MX31_H2_DT_BIT;
 
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		writel(v, MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
-- 
1.6.6
