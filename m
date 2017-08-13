From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Sun, 13 Aug 2017 18:00:43 +0900
Subject: [PATCH v2 3/3] reset: uniphier: add analog amplifiers reset control
In-Reply-To: <20170813090043.3828-1-suzuki.katsuhiro@socionext.com>
References: <20170813090043.3828-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20170813090043.3828-3-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a reset line for analog signal amplifier core (ADAMV) on
UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes for v2:
  - ID changes to 0 because ADAMV reset controller independents
    from other reset controllers.
  - Add DT-binding documents.
---
 .../devicetree/bindings/reset/uniphier-reset.txt   | 25 ++++++++++++++++++++++
 drivers/reset/reset-uniphier.c                     | 15 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index b80ccc03ab9f..68a6f487c409 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -90,3 +90,28 @@ Example:
 
 		other nodes ...
 	};
+
+
+Analog signal amplifier reset
+-----------------------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-ld11-adamv-reset" - for LD11 SoC
+    "socionext,uniphier-ld20-adamv-reset" - for LD20 SoC
+- #reset-cells: should be 1.
+
+Example:
+
+	adamv at 57920000 {
+		compatible = "socionext,uniphier-ld11-adamv",
+			     "simple-mfd", "syscon";
+		reg = <0x57920000 0x1000>;
+
+		adamv_rst: reset {
+			compatible = "socionext,uniphier-ld11-adamv-reset";
+			#reset-cells = <1>;
+		};
+
+		other nodes ...
+	};
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index f60c137c17cb..bda2dd196ae5 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -196,6 +196,12 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
+/* Analog signal amplifiers reset data */
+static const struct uniphier_reset_data uniphier_ld11_adamv_reset_data[] = {
+	UNIPHIER_RESETX(0, 0x10, 6), /* EVEA */
+	UNIPHIER_RESET_END,
+};
+
 /* core implementaton */
 struct uniphier_reset_priv {
 	struct reset_controller_dev rcdev;
@@ -415,6 +421,15 @@ static const struct of_device_id uniphier_reset_match[] = {
 		.compatible = "socionext,uniphier-ld20-peri-reset",
 		.data = uniphier_pro4_peri_reset_data,
 	},
+	/* Analog signal amplifiers reset */
+	{
+		.compatible = "socionext,uniphier-ld11-adamv-reset",
+		.data = uniphier_ld11_adamv_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-adamv-reset",
+		.data = uniphier_ld11_adamv_reset_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_reset_match);
-- 
2.13.2
