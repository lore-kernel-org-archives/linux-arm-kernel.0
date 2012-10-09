From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue,  9 Oct 2012 14:04:06 +0200
Subject: [PATCH v4 3/8] watchdog: orion_wdt: add timeout-sec property binding
In-Reply-To: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349784251-28261-4-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
 drivers/watchdog/orion_wdt.c                          | 8 +++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 0b2503a..5dc8d30 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -5,10 +5,15 @@ Required Properties:
 - Compatibility : "marvell,orion-wdt"
 - reg		: Address of the timer registers
 
+Optional properties:
+
+- timeout-sec	: Contains the watchdog timeout in seconds
+
 Example:
 
 	wdt at 20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		timeout-sec = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c20f96b..446a3e9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -162,12 +162,10 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
-		heartbeat = wdt_max_duration;
-
-	orion_wdt.timeout = heartbeat;
 	orion_wdt.min_timeout = 1;
+	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
+	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
@@ -177,7 +175,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		heartbeat, nowayout ? ", nowayout" : "");
+		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
-- 
1.7.11.3
