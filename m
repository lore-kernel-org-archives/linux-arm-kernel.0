From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:17 +0530
Subject: [PATCH V2 22/22] watchdog/sp805: Add clk_{un}prepare support
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <aadd8e1398e5a85fff68b3b501e32e1fe5c4c580.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_{un}prepare() routines are required for required on some platforms to run
part of clk enable/disable() routines from contexts that can schedule.

This patch adds support for these routines in sp805 driver.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 5c34eda..938b8ab 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -130,9 +130,16 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 	int ret;
 
 	if (!ping) {
+		ret = clk_prepare(wdt->clk);
+		if (ret) {
+			dev_err(&wdt->adev->dev, "clock prepare fail");
+			return ret;
+		}
+
 		ret = clk_enable(wdt->clk);
 		if (ret) {
 			dev_err(&wdt->adev->dev, "clock enable fail");
+			clk_unprepare(wdt->clk);
 			return ret;
 		}
 	}
@@ -184,6 +191,7 @@ static int wdt_disable(struct watchdog_device *wdd)
 	spin_unlock(&wdt->lock);
 
 	clk_disable(wdt->clk);
+	clk_unprepare(wdt->clk);
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d
