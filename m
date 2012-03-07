From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 7 Mar 2012 15:57:52 +0530
Subject: [PATCH 11/15] watchdog/mpcore_wdt: disable wdt in suspend only if it
 is busy
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
Message-ID: <f58a3c64f2768de81f910b75a5f1dfbb213aaac6.1331115752.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to call mpcore_wdt_stop() in suspend, if wdt is not BUSY. So, call
mpcore_wdt_stop() conditionally in suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index a099418..27a5069 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -389,7 +389,8 @@ static int mpcore_wdt_suspend(struct device *dev)
 {
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
-	mpcore_wdt_stop(wdt);		/* Turn the WDT off */
+	if (test_bit(0, &wdt->timer_alive))
+		mpcore_wdt_stop(wdt);		/* Turn the WDT off */
 	return 0;
 }
 
-- 
1.7.8.110.g4cb5d
