From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:23 +0200
Subject: [PATCH v4 11/19] clocksource: sh_mtu2: Add DT support
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document DT bindings and parse them in the MTU2 driver.

Cc: devicetree at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
---
 .../devicetree/bindings/timer/renesas,mtu2.txt     | 39 ++++++++++++++++++++++
 drivers/clocksource/sh_mtu2.c                      |  8 +++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
new file mode 100644
index 0000000..917453f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
@@ -0,0 +1,39 @@
+* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
+
+The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
+clock inputs and programmable compare match.
+
+Channels share hardware resources but their counter and compare match value
+are independent. The MTU2 hardware supports five channels indexed from 0 to 4.
+
+Required Properties:
+
+  - compatible: must contain "renesas,mtu2"
+
+  - reg: base address and length of the registers block for the timer module.
+
+  - interrupts: interrupt specifiers for the timer, one for each entry in
+    interrupt-names.
+  - interrupt-names: must contain one entry named "tgi?a" for each enabled
+    channel, where "?" is the channel index expressed as one digit from "0" to
+    "4".
+
+  - clocks: a list of phandle + clock-specifier pairs, one for each entry
+    in clock-names.
+  - clock-names: must contain "fck" for the functional clock.
+
+
+Example: R7S72100 (RZ/A1H) MTU2 node
+
+	mtu2: timer at fcff0000 {
+		compatible = "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 150 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 154 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 159 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tgi0a", "tgi1a", "tgi2a", "tgi3a", "tgi4a";
+		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+		clock-names = "fck";
+	};
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index ebdf9d1..05ae3d9 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -23,6 +23,7 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -502,11 +503,18 @@ static const struct platform_device_id sh_mtu2_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, sh_mtu2_id_table);
 
+static const struct of_device_id sh_mtu2_of_table[] __maybe_unused = {
+	{ .compatible = "renesas,mtu2" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_mtu2_of_table);
+
 static struct platform_driver sh_mtu2_device_driver = {
 	.probe		= sh_mtu2_probe,
 	.remove		= sh_mtu2_remove,
 	.driver		= {
 		.name	= "sh_mtu2",
+		.of_match_table = of_match_ptr(sh_mtu2_of_table),
 	},
 	.id_table	= sh_mtu2_id_table,
 };
-- 
1.8.5.5
