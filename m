From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Oct 2013 23:49:18 +0100
Subject: [PATCH 01/12] clocksource: sh_cmt: Add clk_prepare/unprepare support
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383000569-8916-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the clock at probe time, as there is no other appropriate place
in the driver where we're allowed to sleep.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0965e98..940341a 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -634,12 +634,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 
 static void sh_cmt_clock_event_suspend(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweroff(&ced_to_sh_cmt(ced)->pdev->dev);
+	struct sh_cmt_priv *p = ced_to_sh_cmt(ced);
+
+	pm_genpd_syscore_poweroff(&p->pdev->dev);
+	clk_unprepare(p->clk);
 }
 
 static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweron(&ced_to_sh_cmt(ced)->pdev->dev);
+	struct sh_cmt_priv *p = ced_to_sh_cmt(ced);
+
+	clk_prepare(p->clk);
+	pm_genpd_syscore_poweron(&p->pdev->dev);
 }
 
 static void sh_cmt_register_clockevent(struct sh_cmt_priv *p,
@@ -737,6 +743,10 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err2;
 	}
 
+	ret = clk_prepare(p->clk);
+	if (ret < 0)
+		goto err3;
+
 	if (res2 && (resource_size(res2) == 4)) {
 		/* assume both CMSTR and CMCSR to be 32-bit */
 		p->read_control = sh_cmt_read32;
@@ -773,19 +783,21 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 			      cfg->clocksource_rating);
 	if (ret) {
 		dev_err(&p->pdev->dev, "registration failed\n");
-		goto err3;
+		goto err4;
 	}
 	p->cs_enabled = false;
 
 	ret = setup_irq(irq, &p->irqaction);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
-		goto err3;
+		goto err4;
 	}
 
 	platform_set_drvdata(pdev, p);
 
 	return 0;
+err4:
+	clk_unprepare(p->clk);
 err3:
 	clk_put(p->clk);
 err2:
-- 
1.8.1.5
