From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 09:50:42 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130716015038.GD28375@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, May 30, 2013 at 11:09:00AM +0200, Philipp Zabel wrote:
> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

I see this patch is very useful, as GPIOs are widely used to reset
components/devices on board.  But I do not find the patch in v3.11-rc1.
What's your plan about it?

Also, I'm wondering if we should register the driver a little bit
early.  Please see the following patch.  If it makes sense to you,
I can send the patch to you, or you can just quash it into yours.

Shawn

---8<--------

>From 2f8ce9e5d6525b98f3828b707458e83fabb39d50 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Sun, 14 Jul 2013 20:41:00 +0800
Subject: [PATCH] ENGR00269945: reset: register gpio-reset driver in
 arch_initcall

It's a little bit late to register gpio-reset driver at module_init
time, because gpio-reset provides reset control via gpio for other
devices which are mostly probed at module_init time too.  And it
becomes even worse, when the gpio comes from IO expander on I2C bus,
e.g. pca953x.  In that case, gpio-reset needs to be ready before I2C
bus driver which is generally ready at subsys_initcall time.  Let's
register gpio-reset driver in arch_initcall() to have it ready early
enough.

The defer probe mechanism is not used here, because a reset controller
driver should be reasonably registered early than other devices.  More
importantly, defer probe doe not help in some nasty cases, e.g. the
gpio-pca953x device itself needs a reset from gpio-reset driver to start
working.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/reset/gpio-reset.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c
index 4f372f9..a7f214f 100644
--- a/drivers/reset/gpio-reset.c
+++ b/drivers/reset/gpio-reset.c
@@ -168,7 +168,17 @@ static struct platform_driver gpio_reset_driver = {
 	},
 };
 
-module_platform_driver(gpio_reset_driver);
+static int __init gpio_reset_init(void)
+{
+	return platform_driver_register(&gpio_reset_driver);
+}
+arch_initcall(gpio_reset_init);
+
+static void __exit gpio_reset_exit(void)
+{
+	platform_driver_unregister(&gpio_reset_driver);
+}
+module_exit(gpio_reset_exit);
 
 MODULE_AUTHOR("Philipp Zabel <p.zabel@pengutronix.de>");
 MODULE_DESCRIPTION("gpio reset controller");
-- 
1.7.9.5
