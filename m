From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 24 Apr 2014 20:35:22 +0530
Subject: [PATCH] i2c: mux: Use subsys_initcall for the i2c-arb-gpio-challenge
Message-ID: <1398351922-1647-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

Since many drivers rely on FETs that live behind this arbitrator, they
can't successfully probe until after the arbitrator comes up.  They
ought to handle things properly with EPROBE_DEFER and still work, but
that has some downsides:

1. Those drivers don't come up till later in the boot process.  That
   really not so nice for the LCD--we want that to init early.
2. Some drivers have bugs and don't handle EPROBE_DEFER.  Those
   drivers should be fixed but not all of them have been fixed yet.
   HDMI is one example since DRM doesn't really have good support for
   deferring probes.

With this change We end up using the same init level as the main i2c bus.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-on: https://gerrit.chromium.org/gerrit/57007
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 69afffa..6cf52bb 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -241,7 +241,17 @@ static struct platform_driver i2c_arbitrator_driver = {
 	},
 };
 
-module_platform_driver(i2c_arbitrator_driver);
+static int __init i2c_arbitrator_init(void)
+{
+	return platform_driver_register(&i2c_arbitrator_driver);
+}
+subsys_initcall(i2c_arbitrator_init);
+
+static void __exit i2c_arbitrator_exit(void)
+{
+	platform_driver_unregister(&i2c_arbitrator_driver);
+}
+module_exit(i2c_arbitrator_exit);
 
 MODULE_DESCRIPTION("GPIO-based I2C Arbitration");
 MODULE_AUTHOR("Doug Anderson <dianders@chromium.org>");
-- 
1.7.9.5
