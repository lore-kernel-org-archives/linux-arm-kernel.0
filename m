From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 31 May 2016 14:08:09 +0800
Subject: [PATCH 2/3] sbsa_gwdt: Use max_hw_heartbeat_ms instead of max_timeout
In-Reply-To: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1464674890-10512-3-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <panand@redhat.com>

Using max_hw_heartbeat_ms instead of max_timeout gives the flexibility to
achieve higher user "timeout". Therefore, use this new infrastructure.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/sbsa_gwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index ad383f6..6af71e0 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -273,7 +273,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	wdd->info = &sbsa_gwdt_info;
 	wdd->ops = &sbsa_gwdt_ops;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = U32_MAX / gwdt->clk;
+	wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
 	wdd->timeout = DEFAULT_TIMEOUT;
 	watchdog_set_drvdata(wdd, gwdt);
 	watchdog_set_nowayout(wdd, nowayout);
@@ -310,7 +310,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 * the timeout is (WOR * 2), so the maximum timeout should be doubled.
 	 */
 	if (!action)
-		wdd->max_timeout *= 2;
+		wdd->max_hw_heartbeat_ms *= 2;
 
 	watchdog_init_timeout(wdd, timeout, dev);
 	/*
-- 
2.5.5
