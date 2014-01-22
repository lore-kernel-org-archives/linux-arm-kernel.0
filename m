From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 20:05:04 -0300
Subject: [PATCH v4 07/18] watchdog: orion: Handle IRQ
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-enabled where an irqchip driver for the brigde interrupt controller is
available can handle the watchdog IRQ properly. Therefore, we request
the interruption and add a dummy handler that merely calls panic().

This is done in order to have an initial 'ack' of the interruption,
which clears the watchdog state.

Furthermore, since some platforms don't have such IRQ, this commit
makes the interruption specification optional.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
 drivers/watchdog/orion_wdt.c                       | 24 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 5dc8d30..0731fbd 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 Optional properties:
 
+- interrupts	: Contains the IRQ for watchdog expiration
 - timeout-sec	: Contains the watchdog timeout in seconds
 
 Example:
@@ -14,6 +15,7 @@ Example:
 	wdt at 20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		interrupts = <3>;
 		timeout-sec = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 2dbeee9..f5e7b17 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -109,10 +110,16 @@ static struct watchdog_device orion_wdt = {
 	.min_timeout = 1,
 };
 
+static irqreturn_t orion_wdt_irq(int irq, void *devid)
+{
+	panic("Watchdog Timeout");
+	return IRQ_HANDLED;
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
+	int ret, irq;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -145,6 +152,21 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	/* Let's make sure the watchdog is fully stopped */
 	orion_wdt_stop(&orion_wdt);
 
+	/* It's important to request the IRQ once the watchdog is disabled */
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		/*
+		 * Not all supported platforms specify an interruption for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_irq, 0,
+				       pdev->name, &orion_wdt);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+			goto disable_clk;
+		}
+	}
+
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
 	if (ret)
-- 
1.8.1.5
