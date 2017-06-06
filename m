From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:27 +0800
Subject: [PATCH 05/10] dt-bindings: interrupt-controller: sunxi-nmi: Add
 compatible for A31 R_INTC
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 and later have an R_INTC block which handles the NMI interrupt
pin on the SoC. This interrupt pin is used by the external PMIC to
signal interrupts to the SoC.

While this hardware block is undocumented, the interrupt offsets
combined with the register regions for the existing "sun6i-a31-sc-nmi"
compatible line up with the old interrupt controller found on the A10.
Experiments show that only the first 32 interrupt lines can be enabled,
and only the first (NMI) interrupt is actually connected.

This patch adds a new, properly named compatible for the A31 R_INTC
block, which requires the register region to be properly aligned to
the block boundary. For comparison, the old "sun6i-a31-sc-nmi"
compatible had its register region aligned with the first used
register. This didn't match up with the memory map in the SoC's
datasheet/user manual.

Since the new compatible supercedes the old one, deprecate the old one.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/interrupt-controller/allwinner,sunxi-nmi.txt          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
index 81cd3692405e..4ae553eb333d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
@@ -3,8 +3,11 @@ Allwinner Sunxi NMI Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun7i-a20-sc-nmi" or
-  "allwinner,sun6i-a31-sc-nmi" or "allwinner,sun9i-a80-nmi"
+- compatible : should be one of the following:
+  - "allwinner,sun7i-a20-sc-nmi"
+  - "allwinner,sun6i-a31-sc-nmi" (deprecated)
+  - "allwinner,sun6i-a31-r-intc"
+  - "allwinner,sun9i-a80-nmi"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.11.0
