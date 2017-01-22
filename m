From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:19:50 +0100
Subject: [PATCH 08/22] rtc: Add device tree probing to the Gemini driver
Message-ID: <20170122121950.10449-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds bindings and simple probing for the Cortina Systems Gemini
SoC RTC.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
RTC maintainers: please just apply this to the RTC tree when you
are pleased with it. It is functionally orthogonal to the rest of
the series and just in a series for context.
---
 Documentation/devicetree/bindings/rtc/cortina,gemini.txt | 14 ++++++++++++++
 drivers/rtc/rtc-gemini.c                                 |  7 +++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt

diff --git a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
new file mode 100644
index 000000000000..4ce4e794ddbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
@@ -0,0 +1,14 @@
+* Cortina Systems Gemini RTC
+
+Gemini SoC real-time clock.
+
+Required properties:
+- compatible : Should be "cortina,gemini-rtc"
+
+Examples:
+
+rtc at 45000000 {
+	compatible = "cortina,gemini-rtc";
+	reg = <0x45000000 0x100>;
+	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 688debc14348..ccf0dbadb62d 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -159,9 +159,16 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id gemini_rtc_dt_match[] = {
+	{ .compatible = "cortina,gemini-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gemini_rtc_dt_match);
+
 static struct platform_driver gemini_rtc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = gemini_rtc_dt_match,
 	},
 	.probe		= gemini_rtc_probe,
 	.remove		= gemini_rtc_remove,
-- 
2.9.3
