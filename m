From: shailendra.v@samsung.com (Shailendra Verma)
Date: Mon, 30 Jan 2017 10:28:31 +0530
Subject: [PATCH] Arch: arm: plat-pxa - Fix possible NULL derefrence.
References: <CGME20170130045842epcas2p274b2125a1f158e4d656096bdf3a3a1d9@epcas2p2.samsung.com>
Message-ID: <1485752311-29754-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 arch/arm/plat-pxa/ssp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ba13f79..7d1cd51 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -204,6 +204,10 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		const struct of_device_id *id =
 			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
+		if (!id) {
+			dev_err(dev, "Error: No device match found\n");
+			return -ENODEV;
+		}
 		ssp->type = (int) id->data;
 	} else {
 		const struct platform_device_id *id =
-- 
1.7.9.5
