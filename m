From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:08 +0530
Subject: [PATCH V2 13/22] watchdog/mpcore_wdt: disable wdt in suspend only if
 it is busy
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <6e7bfa62de432452eb6b814e92a9045ea9e6d0c9.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to call mpcore_wdt_stop() in suspend, if wdt is not BUSY. So, call
mpcore_wdt_stop() conditionally in suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 3f47b7e..7ded2a0 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -260,7 +260,9 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 static int mpcore_wdt_suspend(struct device *dev)
 {
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
-	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+
+	if (is_wdd_active(&wdt->wdd))
+		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d
