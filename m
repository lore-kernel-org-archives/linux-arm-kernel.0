From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:30 +0900
Subject: [PATCH 04/12] clocksource: sh_cmt: Consolidate platform_set_drvdata()
 call
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Cleanup the use of platform_set_drvdata() to reduce code size

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 94fd3ab..a2f8023 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -688,8 +688,6 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err0;
 	}
 
-	platform_set_drvdata(pdev, p);
-
 	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
@@ -757,6 +755,8 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err2;
 	}
 
+	platform_set_drvdata(pdev, p);
+
 	return 0;
 err2:
 	clk_put(p->clk);
@@ -792,7 +792,6 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	ret = sh_cmt_setup(p, pdev);
 	if (ret) {
 		kfree(p);
-		platform_set_drvdata(pdev, NULL);
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-- 
1.7.10.4
