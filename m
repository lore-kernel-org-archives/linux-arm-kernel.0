From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:40 +0100
Subject: [PATCH 3/8] i.MX27: Add USB control register access support
In-Reply-To: <1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/plat-mxc/ehci.c |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 586b55d..816a9cc 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -41,7 +41,7 @@
 int mxc_set_usbcontrol(int port, unsigned int flags)
 {
 	unsigned int v;
-
+#ifdef CONFIG_ARCH_MX3
 	if (cpu_is_mx31()) {
 		v = readl(MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
@@ -85,7 +85,52 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
 				     USBCTRL_OTGBASE_OFFSET));
 		return 0;
 	}
+#endif /* CONFIG_ARCH_MX3 */
+#ifdef CONFIG_MACH_MX27
+	if (cpu_is_mx27()) {
+		/* On i.MX27 we can use the i.MX31 USBCTRL bits, they
+		 * are identical
+		 */
+		v = readl(MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR +
+				     USBCTRL_OTGBASE_OFFSET));
+		switch (port) {
+		case 0:	/* OTG port */
+			v &= ~(MX31_OTG_SIC_MASK | MX31_OTG_PM_BIT);
+			v |= (flags & MXC_EHCI_INTERFACE_MASK)
+					<< MX31_OTG_SIC_SHIFT;
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
+				v |= MX31_OTG_PM_BIT;
+			break;
+		case 1: /* H1 port */
+			v &= ~(MX31_H1_SIC_MASK | MX31_H1_PM_BIT | MX31_H1_DT_BIT);
+			v |= (flags & MXC_EHCI_INTERFACE_MASK)
+						<< MX31_H1_SIC_SHIFT;
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
+				v |= MX31_H1_PM_BIT;
+
+			if (!(flags & MXC_EHCI_TTL_ENABLED))
+				v |= MX31_H1_DT_BIT;
 
+			break;
+		case 2:	/* H2 port */
+			v &= ~(MX31_H2_SIC_MASK | MX31_H2_PM_BIT | MX31_H2_DT_BIT);
+			v |= (flags & MXC_EHCI_INTERFACE_MASK)
+						<< MX31_H2_SIC_SHIFT;
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
+				v |= MX31_H2_PM_BIT;
+
+			if (!(flags & MXC_EHCI_TTL_ENABLED))
+				v |= MX31_H2_DT_BIT;
+
+			break;
+		default:
+			return -EINVAL;
+		}
+		writel(v, MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR +
+				     USBCTRL_OTGBASE_OFFSET));
+		return 0;
+	}
+#endif /* CONFIG_MACH_MX27 */
 	printk(KERN_WARNING
 		"%s() unable to setup USBCONTROL for this CPU\n", __func__);
 	return -EINVAL;
-- 
1.6.6
