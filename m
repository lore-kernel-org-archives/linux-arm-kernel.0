From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 21 Oct 2016 09:55:32 +0100
Subject: [PATCH] [media] c8sectpfe: Remove clk_disable_unprepare hacks
Message-ID: <1477040132-31442-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that CLK_PROC_STFE is defined as a critical clock in
DT, we can remove the commented clk_disable_unprepare from
the c8sectpfe driver. This means we now have balanced
clk*enable/disable calls in the driver, but on STiH407
family the clock in reality will never actually be disabled.

This is due to a HW bug where once the IP has been configured
and the SLIM core is running, disabling the clock causes a
unrecoverable bus lockup.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 30c148b..79d793b 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -888,8 +888,7 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	/* TODO uncomment when upstream has taken a reference on this clk */
-	/*clk_disable_unprepare(fei->c8sectpfeclk);*/
+	clk_disable_unprepare(fei->c8sectpfeclk);
 	return ret;
 }
 
@@ -924,11 +923,8 @@ static int c8sectpfe_remove(struct platform_device *pdev)
 	if (readl(fei->io + SYS_OTHER_CLKEN))
 		writel(0, fei->io + SYS_OTHER_CLKEN);
 
-	/* TODO uncomment when upstream has taken a reference on this clk */
-	/*
 	if (fei->c8sectpfeclk)
 		clk_disable_unprepare(fei->c8sectpfeclk);
-	*/
 
 	return 0;
 }
-- 
1.9.1
