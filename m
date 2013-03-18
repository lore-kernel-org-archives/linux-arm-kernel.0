From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:27 +0900
Subject: [PATCH 01/12] clocksource: sh_cmt: Take care of clk_put() when
 setup_irq() fails
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make sure clk_put() is called in case of failure in sh_cmt_setup().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 488c14c..4b8d296 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -708,17 +708,19 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 			      cfg->clocksource_rating);
 	if (ret) {
 		dev_err(&p->pdev->dev, "registration failed\n");
-		goto err1;
+		goto err2;
 	}
 	p->cs_enabled = false;
 
 	ret = setup_irq(irq, &p->irqaction);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
-		goto err1;
+		goto err2;
 	}
 
 	return 0;
+err2:
+	clk_put(p->clk);
 
 err1:
 	iounmap(p->mapbase);
-- 
1.7.10.4
