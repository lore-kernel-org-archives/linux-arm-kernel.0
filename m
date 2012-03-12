From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:14 +0530
Subject: [PATCH V2 19/22] watchdog/sp805: replace readl/writel with lighter
 _relaxed variants
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <5a279730768f9532101283ccea2990cb691824ff.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

readl/writel versions for ARM contain memory barrier instruction for
synchronizing DMA buffers.  These are not required at least on this
module.  So use lighter _relaxed variants.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 7af1386..1291960 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -113,10 +113,10 @@ static u32 wdt_timeleft(void)
 	rate = clk_get_rate(wdt->clk);
 
 	spin_lock(&wdt->lock);
-	load = readl(wdt->base + WDTVALUE);
+	load = readl_relaxed(wdt->base + WDTVALUE);
 
 	/*If the interrupt is inactive then time left is WDTValue + WDTLoad. */
-	if (!(readl(wdt->base + WDTRIS) & INT_MASK))
+	if (!(readl_relaxed(wdt->base + WDTRIS) & INT_MASK))
 		load += wdt->load_val + 1;
 	spin_unlock(&wdt->lock);
 
@@ -128,14 +128,14 @@ static void wdt_enable(void)
 {
 	spin_lock(&wdt->lock);
 
-	writel(UNLOCK, wdt->base + WDTLOCK);
-	writel(wdt->load_val, wdt->base + WDTLOAD);
-	writel(INT_MASK, wdt->base + WDTINTCLR);
-	writel(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
-	writel(LOCK, wdt->base + WDTLOCK);
+	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
+	writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
+	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
+	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
+	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
 	/* Flush posted writes. */
-	readl(wdt->base + WDTLOCK);
+	readl_relaxed(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 }
 
@@ -144,12 +144,12 @@ static void wdt_disable(void)
 {
 	spin_lock(&wdt->lock);
 
-	writel(UNLOCK, wdt->base + WDTLOCK);
-	writel(0, wdt->base + WDTCONTROL);
-	writel(LOCK, wdt->base + WDTLOCK);
+	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
+	writel_relaxed(0, wdt->base + WDTCONTROL);
+	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
 	/* Flush posted writes. */
-	readl(wdt->base + WDTLOCK);
+	readl_relaxed(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 }
 
-- 
1.7.8.110.g4cb5d
