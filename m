From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 24 Nov 2009 00:42:13 +0100
Subject: [PATCH 1/1] WDT clock rate based on returned rate from clk_get_rate
Message-ID: <083DF309106F364B939360100EC290F804F55464A3@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH] WDT clock rate based on returned rate from clk_get_rate()
 instead of WDOG_COUNTER_RATE define

---
 drivers/watchdog/pnx4008_wdt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index cbfe3ca..259cdb8 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -110,7 +110,8 @@ static void wdt_enable(void)
      __raw_writel(MATCH_INT, WDTIM_INT(wdt_base));
      /* the longest pulse period 65541/(13*10^6) seconds ~ 5 ms. */
      __raw_writel(0xFFFF, WDTIM_PULSE(wdt_base));
-     __raw_writel(heartbeat * WDOG_COUNTER_RATE, WDTIM_MATCH0(wdt_base));
+     __raw_writel(heartbeat * clk_get_rate(wdt_clk),
+           WDTIM_MATCH0(wdt_base));
      /*enable counter, stop when debugger active */
      __raw_writel(COUNT_ENAB | DEBUG_EN, WDTIM_CTRL(wdt_base));

--
1.6.0.6

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091124/d9aede1e/attachment-0001.htm>
