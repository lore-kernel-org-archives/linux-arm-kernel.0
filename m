From: jenskuske@gmail.com (Jens Kuske)
Date: Wed,  6 May 2015 11:31:31 +0200
Subject: [PATCH 4/6] dmaengine: sun6i: Add support for Allwinner H3 (sun8i)
 variant
In-Reply-To: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
Message-ID: <1430904693-1404-5-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 SoC has the same dma engine as the A31 (sun6i), with a
reduced amount of endpoints and physical channels. Add the proper
config data and compatible string to support it.

Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt |  5 ++++-
 drivers/dma/sun6i-dma.c                             | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 9cdcba24d..d13c136 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -4,7 +4,10 @@ This driver follows the generic DMA bindings defined in dma.txt.
 
 Required properties:
 
-- compatible:	Must be "allwinner,sun6i-a31-dma" or "allwinner,sun8i-a23-dma"
+- compatible:	Must be one of
+		  "allwinner,sun6i-a31-dma"
+		  "allwinner,sun8i-a23-dma"
+		  "allwinner,sun8i-h3-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 11e5365..842ff97 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -891,9 +891,21 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_vchans   = 37,
 };
 
+/*
+ * The H3 has 12 physical channels, a maximum DRQ port id of 27,
+ * and a total of 34 usable source and destination endpoints.
+ */
+
+static struct sun6i_dma_config sun8i_h3_dma_cfg = {
+	.nr_max_channels = 12,
+	.nr_max_requests = 27,
+	.nr_max_vchans   = 34,
+};
+
 static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
+	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ /* sentinel */ }
 };
 
-- 
2.3.7
