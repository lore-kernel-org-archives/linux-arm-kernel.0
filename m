From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:02:56 +0200
Subject: [PATCH 2/8] plat-mxc/ehci.c: add i.MX25 support
In-Reply-To: <1275987782-16094-1-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX25's OTG has the same USBCTRL registers than i.MX35 so reuse
most of the i.MX35's defines.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/ehci.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 2a86461..6184792 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -73,7 +73,51 @@
 int mxc_initialize_usb_hw(int port, unsigned int flags)
 {
 	unsigned int v;
-#ifdef CONFIG_ARCH_MX3
+#if defined(CONFIG_ARCH_MX25)
+	if (cpu_is_mx25()) {
+		v = readl(MX25_IO_ADDRESS(MX25_OTG_BASE_ADDR +
+				     USBCTRL_OTGBASE_OFFSET));
+
+		switch (port) {
+		case 0:	/* OTG port */
+			v &= ~(MX35_OTG_SIC_MASK | MX35_OTG_PM_BIT);
+			v |= (flags & MXC_EHCI_INTERFACE_MASK)
+					<< MX35_OTG_SIC_SHIFT;
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
+				v |= MX35_OTG_PM_BIT;
+
+			break;
+		case 1: /* H1 port */
+			v &= ~(MX35_H1_SIC_MASK | MX35_H1_PM_BIT | MX35_H1_TLL_BIT |
+				MX35_H1_USBTE_BIT | MX35_H1_IPPUE_DOWN_BIT | MX35_H1_IPPUE_UP_BIT);
+			v |= (flags & MXC_EHCI_INTERFACE_MASK)
+						<< MX35_H1_SIC_SHIFT;
+			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
+				v |= MX35_H1_PM_BIT;
+
+			if (!(flags & MXC_EHCI_TTL_ENABLED))
+				v |= MX35_H1_TLL_BIT;
+
+			if (flags & MXC_EHCI_INTERNAL_PHY)
+				v |= MX35_H1_USBTE_BIT;
+
+			if (flags & MXC_EHCI_IPPUE_DOWN)
+				v |= MX35_H1_IPPUE_DOWN_BIT;
+
+			if (flags & MXC_EHCI_IPPUE_UP)
+				v |= MX35_H1_IPPUE_UP_BIT;
+
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		writel(v, MX25_IO_ADDRESS(MX25_OTG_BASE_ADDR +
+				     USBCTRL_OTGBASE_OFFSET));
+		return 0;
+	}
+#endif /* CONFIG_ARCH_MX25 */
+#if defined(CONFIG_ARCH_MX3)
 	if (cpu_is_mx31()) {
 		v = readl(MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
-- 
1.6.3.3
