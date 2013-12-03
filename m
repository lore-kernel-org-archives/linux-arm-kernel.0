From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:31 +0100
Subject: [PATCH 6/6] amba: Add clk_prepare|unprepare in runtime PM callbacks
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To fully gate the clock and thus potentially also save more power in
runtime suspend state, extend clock handling with clk_prepare|unprepare
in the runtime PM callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0477131..4cee15a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -95,7 +95,7 @@ static int amba_pm_runtime_suspend(struct device *dev)
 	int ret = pm_generic_runtime_suspend(dev);
 
 	if (ret == 0 && dev->driver)
-		clk_disable(pcdev->pclk);
+		clk_disable_unprepare(pcdev->pclk);
 
 	return ret;
 }
@@ -106,7 +106,7 @@ static int amba_pm_runtime_resume(struct device *dev)
 	int ret;
 
 	if (dev->driver) {
-		ret = clk_enable(pcdev->pclk);
+		ret = clk_prepare_enable(pcdev->pclk);
 		/* Failure is probably fatal to the system, but... */
 		if (ret)
 			return ret;
-- 
1.7.9.5
