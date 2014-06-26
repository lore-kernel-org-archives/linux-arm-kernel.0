From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 20:15:36 +0200
Subject: [PATCH v5 04/14] clk: max77686: Improve Maxim 77686 PMIC clocks
 binding
In-Reply-To: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403806546-31122-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like most clock drivers, the Maxim 77686 PMIC clock binding
follows the convention that the "#clock-cells" property is
used to specify the number of cells in a clock provider.

But the binding document is not clear enough that it shall
be set to 1 since the PMIC support multiple clocks outputs.

Also, explain that the clocks identifiers are defined in a
header file that can be included by Device Tree source with
client nodes to avoid using magic numbers.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---

Changes since v4: None

Changes since v3:
 - Don't change clock-names property to make clear that it's
   the consumer clock name and should not match the producer clock.
   Suggested by Doug Anderson.

 Documentation/devicetree/bindings/clock/maxim,max77686.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
index 96ce71b..48e00bb 100644
--- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
+++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
@@ -9,13 +9,18 @@ The MAX77686 contains three 32.768khz clock outputs that can be controlled
 Following properties should be presend in main device node of the MFD chip.
 
 Required properties:
-- #clock-cells: simple one-cell clock specifier format is used, where the
-  only cell is used as an index of the clock inside the provider. Following
-  indices are allowed:
+
+- #clock-cells: from common clock binding; shall be set to 1.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. Following indices are allowed:
     - 0: 32khz_ap clock,
     - 1: 32khz_cp clock,
     - 2: 32khz_pmic clock.
 
+Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77686.h
+header and can be used in device tree sources.
+
 Example: Node of the MFD chip
 
 	max77686: max77686 at 09 {
@@ -34,5 +39,5 @@ Example: Clock consumer node
 		compatible = "bar,foo";
 		/* ... */
 		clock-names = "my-clock";
-		clocks = <&max77686 2>;
+		clocks = <&max77686 MAX77686_CLK_PMIC>;
 	};
-- 
2.0.0.rc2
