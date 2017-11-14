From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 11:54:28 +0100
Subject: [PATCH v3 1/4] net: nb8800: Drop generic support
In-Reply-To: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
Message-ID: <3c0385f3-bae9-8b40-aec4-3818456b2767@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to our HW dev, there is no provision for software to safely
disable RX DMA in the AU-NB8800 hardware block (ethernet DMA). Thus,
it is the responsibility of the SoC designer to provide such a feature.

The nb8800_dma_stop() implementation is a clever hack that works most
of the times, but it breaks the DMA state machine in rare cases.

Therefore, let's drop generic support.

FWIW, tango chips provide a reset register. When the ethernet block
comes out of reset, DMA is disabled.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/net/ethernet/aurora/nb8800.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index e94159507847..26f719e2d6ca 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -1335,9 +1335,6 @@ static const struct nb8800_ops nb8800_tango4_ops = {
 };
 
 static const struct of_device_id nb8800_dt_ids[] = {
-	{
-		.compatible = "aurora,nb8800",
-	},
 	{
 		.compatible = "sigma,smp8642-ethernet",
 		.data = &nb8800_tangox_ops,
-- 
2.15.0
