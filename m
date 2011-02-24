From: david@protonic.nl (David Jander)
Date: Thu, 24 Feb 2011 16:55:07 +0100
Subject: [PATCH] ARM: plat-mxc: ehci: Fix inverted logic of OC bit
Message-ID: <1298562907-8424-1-git-send-email-david@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If MXC_EHCI_POWER_PINS_ENABLED is set, MXC_OTG_PHYCTRL_OC_DIS_BIT
must be cleared, not set.

Signed-off-by: David Jander <david@protonic.nl>
---
 arch/arm/plat-mxc/ehci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 8772ce3..5f01d9c 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -288,11 +288,11 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 				v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC_OFFSET);
 
 				if (flags & MXC_EHCI_POWER_PINS_ENABLED) {
-					/* OC/USBPWR is not used */
-					v |= MXC_OTG_PHYCTRL_OC_DIS_BIT;
-				} else {
 					/* OC/USBPWR is used */
 					v &= ~MXC_OTG_PHYCTRL_OC_DIS_BIT;
+				} else {
+					/* OC/USBPWR is not used */
+					v |= MXC_OTG_PHYCTRL_OC_DIS_BIT;
 				}
 				__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC_OFFSET);
 
-- 
1.7.0.4
