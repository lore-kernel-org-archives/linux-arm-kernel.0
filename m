From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:50:27 -0700
Subject: [PATCH 07/12] ARM: IXP4x: Remove LATCH and CLOCK_TICK_RATE dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135027.GE1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
ixp4xx code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0777257..fe8b98a 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -448,6 +448,11 @@ static int ixp4xx_set_next_event(unsigned long evt,
 	return 0;
 }
 
+
+#define IXP4XX_TIMER_FREQ 	66666000
+#define IXP4XX_TICK_RATE	(((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
+#define IXP4XX_TIMER_LATCH  	((CLOCK_TICK_RATE + HZ/2) / HZ)
+
 static void ixp4xx_set_mode(enum clock_event_mode mode,
 			    struct clock_event_device *evt)
 {
@@ -456,7 +461,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		osrt = LATCH & ~IXP4XX_OST_RELOAD_MASK;
+		osrt = IXP4XX_TIMER_LATCH & ~IXP4XX_OST_RELOAD_MASK;
  		opts = IXP4XX_OST_ENABLE;
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
-- 
1.7.4.1
