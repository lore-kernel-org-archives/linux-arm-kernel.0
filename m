From: mporter@ti.com (Matt Porter)
Date: Wed, 30 Jan 2013 02:00:28 -0500
Subject: [PATCH v6 09/10] spi: omap2-mcspi: add generic DMA request support to
 the DT binding
In-Reply-To: <1359529229-22207-1-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
Message-ID: <1359529229-22207-10-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding definition is based on the generic DMA request binding

Signed-off-by: Matt Porter <mporter@ti.com>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 938809c..68cb28e 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -10,7 +10,18 @@ Required properties:
 			  input. The default is D0 as input and
 			  D1 as output.
 
-Example:
+Optional properties:
+- dmas: List of DMA controller phandle and DMA request ordered
+	pairs. One tx and one rx pair is required for each chip
+	select.
+- dma-names: List of DMA request names. These strings correspond
+	1:1 with the ordered pairs in dmas. The string naming is
+	to be "rxN" and "txN" for RX and TX requests,
+	respectively, where N equals the chip select number.
+
+Examples:
+
+[hwmod populated DMA resources]
 
 mcspi1: mcspi at 1 {
     #address-cells = <1>;
@@ -20,3 +31,17 @@ mcspi1: mcspi at 1 {
     ti,spi-num-cs = <4>;
 };
 
+[generic DMA request binding]
+
+mcspi1: mcspi at 1 {
+    #address-cells = <1>;
+    #size-cells = <0>;
+    compatible = "ti,omap4-mcspi";
+    ti,hwmods = "mcspi1";
+    ti,spi-num-cs = <2>;
+    dmas = <&edma 42
+	    &edma 43
+	    &edma 44
+	    &edma 45>;
+    dma-names = "tx0", "rx0", "tx1", "rx1";
+};
-- 
1.7.9.5
