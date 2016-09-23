From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Sep 2016 09:45:08 +0800
Subject: [PATCH] clk: zx296718: register driver earlier with core_initcall
Message-ID: <1474595108-15790-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock driver should be registered with an earlier initcall than
module_init which is used by most of client device drivers.  Otherwise,
probing of these client drivers will likely be deferred due to that
calls into clk API will return -EPROBE_DEFER.

Deferred probing is not a problem for most subsystems, but could bring
some side effect for particular subsystem, like display.  On ZX296718
platform, we get Linux logo and boot log lost from display device, just
because the DRM/KMS driver gets -EPROBE_DEFER from devm_clk_get() call.

Let's use core_initcall (qcom and a few other clk drivers use that) for
driver registration to avoid those unnecessary -EPROBE_DEFER and get rid
of the side effect with ZX296718 display system.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index c7716c17f302..707d62956e9b 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -917,4 +917,8 @@ static int zx_clkc_probe(struct platform_device *pdev)
 	},
 };
 
-builtin_platform_driver(zx_clk_driver);
+static int __init zx_clk_init(void)
+{
+	return platform_driver_register(&zx_clk_driver);
+}
+core_initcall(zx_clk_init);
-- 
1.9.1
