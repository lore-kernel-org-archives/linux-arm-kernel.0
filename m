From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 25 Mar 2016 14:46:28 +0000
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start at a non
 zero value
Message-ID: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise generic-xhci and xhci-platform which have no data get wrongly
detected as XHCI_PLAT_TYPE_MARVELL_ARMADA by xhci_plat_type_is().

This fixes a regression in v4.5 for STiH407 family SoC's which use the
synopsis dwc3 IP, whereby the disable_clk error path gets taken due to
wrongly being detected as XHCI_PLAT_TYPE_MARVELL_ARMADA and the hcd never
gets added.

I suspect this will also fix other dwc3 DT platforms such as Exynos,
although I've only tested on STih410 SoC.

Fixes: 4efb2f694114 ("usb: host: xhci-plat: add struct xhci_plat_priv")
Cc: stable at vger.kernel.org
Cc: gregory.clement at free-electrons.com
Cc: yoshihiro.shimoda.uh at renesas.com
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/usb/host/xhci-plat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 5a2e2e3..529c3c4 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -14,7 +14,7 @@
 #include "xhci.h"	/* for hcd_to_xhci() */
 
 enum xhci_plat_type {
-	XHCI_PLAT_TYPE_MARVELL_ARMADA,
+	XHCI_PLAT_TYPE_MARVELL_ARMADA = 1,
 	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
 	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
 };
-- 
1.9.1
