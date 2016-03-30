From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:45 +0200
Subject: [PATCH v5 22/46] pwm: rockchip: avoid glitches on already running PWMs
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-23-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current logic will disable the PWM clk even if the PWM was left
enabled by the bootloader (because it's controlling a critical device
like a regulator for example).
Keep the PWM clk enabled if the PWM is enabled to avoid any glitches.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 6a1087c..5c7e79c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -302,6 +302,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
+	struct pwm_state pstate;
 	struct resource *r;
 	int ret;
 
@@ -322,7 +323,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	ret = clk_prepare(pc->clk);
+	ret = clk_prepare_enable(pc->clk);
 	if (ret)
 		return ret;
 
@@ -345,12 +346,33 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 	}
 
+	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
+	pwm_get_state(pc->chip.pwms, &pstate);
+	if (!pstate.enabled)
+		clk_disable(pc->clk);
+
 	return ret;
 }
 
 static int rockchip_pwm_remove(struct platform_device *pdev)
 {
 	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_state pstate;
+
+	/*
+	 * Disable the PWM clk before unpreparing it if the PWM device is still
+	 * running. This should only happen when the last PWM user left it
+	 * enabled, or when nobody requested a PWM that was previously enabled
+	 * by the bootloader.
+	 *
+	 * FIXME: Maybe the core should disable all PWM devices in
+	 * pwmchip_remove(). In this case we'd only have to call
+	 * clk_unprepare() after pwmchip_remove().
+	 *
+	 */
+	pwm_get_state(pc->chip.pwms, &pstate);
+	if (pstate.enabled)
+		clk_disable(pc->clk);
 
 	clk_unprepare(pc->clk);
 
-- 
2.5.0
