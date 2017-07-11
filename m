From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 12 Jul 2017 00:14:38 +0200
Subject: [PATCH v2] watchdog: meson-wdt: add support for the watchdog on
 Meson8 and Meson8m2
Message-ID: <20170711221438.8958-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog IP block on Meson8 and Meson8m2 is already supported by the
existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
while the newer Meson8m2 SoC uses the same register bits as Meson8b.

Currently watchdog support on Meson8 SoC already works because
meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
separate compatible for Meson8 makes this more explicit though.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1 at [0]:
- updated the documentation to indicate that Meson8 should also specify
  the Meson6 compatible and that Meson8m2 should also specify the
  Meson8b compatible

[0] https://patchwork.kernel.org/patch/9780093/


 Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 6 +++++-
 drivers/watchdog/meson_wdt.c                             | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
index ae70185d96e6..8a6d84cb36c9 100644
--- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
@@ -2,7 +2,11 @@ Meson SoCs Watchdog timer
 
 Required properties:
 
-- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
+- compatible : depending on the SoC this should be one of:
+	"amlogic,meson6-wdt" on Meson6 SoCs
+	"amlogic,meson8-wdt" and "amlogic,meson6-wdt" on Meson8 SoCs
+	"amlogic,meson8b-wdt" on Meson8b SoCs
+	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
 - reg : Specifies base physical address and size of the registers.
 
 Example:
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 491b9bf13d84..304274c67735 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -155,7 +155,9 @@ static const struct watchdog_ops meson_wdt_ops = {
 
 static const struct of_device_id meson_wdt_dt_ids[] = {
 	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
+	{ .compatible = "amlogic,meson8-wdt", .data = &meson6_wdt_data },
 	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
+	{ .compatible = "amlogic,meson8m2-wdt", .data = &meson8b_wdt_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
-- 
2.13.2
