From: mporter@ti.com (Matt Porter)
Date: Thu, 18 Oct 2012 09:26:51 -0400
Subject: [RFC PATCH v3 12/16] mmc: omap_hsmmc: add generic DMA request support
 to the DT binding
In-Reply-To: <1350566815-409-1-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
Message-ID: <1350566815-409-13-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding definition is based on the generic DMA request binding.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index be76a23..d1b8932 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -19,8 +19,28 @@ ti,dual-volt: boolean, supports dual voltage cards
 "supply-name" examples are "vmmc", "vmmc_aux" etc
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
+dmas: DMA controller phandle and DMA request value ordered pair
+One tx and one rx pair is required.
+dma-names: DMA request names. These strings correspond 1:1 with
+the ordered pairs in dmas. The RX request must be "rx" and the
+TX request must be "tx".
+
+Examples:
+
+[hwmod populated DMA resources]
+
+	mmc1: mmc at 0x4809c000 {
+		compatible = "ti,omap4-hsmmc";
+		reg = <0x4809c000 0x400>;
+		ti,hwmods = "mmc1";
+		ti,dual-volt;
+		bus-width = <4>;
+		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		ti,non-removable;
+	};
+
+[generic DMA request binding]
 
-Example:
 	mmc1: mmc at 0x4809c000 {
 		compatible = "ti,omap4-hsmmc";
 		reg = <0x4809c000 0x400>;
@@ -29,4 +49,7 @@ Example:
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
 		ti,non-removable;
+		dmas = <&edma 24
+			&edma 25>;
+		dma-names = "tx", "rx";
 	};
-- 
1.7.9.5
