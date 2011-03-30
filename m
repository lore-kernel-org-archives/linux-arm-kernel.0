From: Frank.Li@freescale.com (Frank Li)
Date: Wed, 30 Mar 2011 16:07:51 +0800
Subject: [PATCH 1/1] ARM: imx: Add sched_clock support to i.mx platform
Message-ID: <1301472471-5826-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xinyu Chen <xinyu.chen@freescale.com>

Add sched_clock() implement for i.mx platform to support nanosecond
resolution time for sched clock used by scheduler.

Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/plat-mxc/time.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 9f0c261..de8a04f 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -123,6 +123,15 @@ static struct clocksource clocksource_mxc = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+unsigned long long sched_clock(void)
+{
+	if (!timer_base)
+		return 0;
+
+	return clocksource_cyc2ns(clocksource_mxc.read(&clocksource_mxc),
+			clocksource_mxc.mult, clocksource_mxc.shift);
+}
+
 static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
-- 
1.7.1
