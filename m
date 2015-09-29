From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 29 Sep 2015 11:10:56 +0200
Subject: [PATCH v7 18/20] power-supply: Probe power supplies on demand
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1443517859-30376-19-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a power supply through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/power/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 456987c88baa..80bc89f4ae89 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/power_supply.h>
 #include <linux/thermal.h>
+#include <linux/of_device.h>
 #include "power_supply.h"
 
 /* exported for the APM Power driver, APM emulation */
@@ -206,6 +207,8 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 {
 	int error;
 
+	of_device_probe(supply_node);
+
 	/*
 	 * class_for_each_device() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
-- 
2.4.3
