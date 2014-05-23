From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:42 +0200
Subject: [PATCH 62/71] clocksource: Fix type confusion for
 clocksource_mmio_readX_Y
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-62-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiubo Li <Li.Xiubo@freescale.com>

The types' definations are:
   o  cycle_t       -> u64
   o  readl_relaxed -> u32
   o  readw_relaxed -> u16

So let clocksource_mmio_readX_Ys return a cast to cycle_t, though
this maybe look reduntant sometimes, it make sense and they will be
more readable and less confusion...

This patch clarifies the functions type and fix it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mmio.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index c0e2512..19a6b3f 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -22,22 +22,22 @@ static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
 
 cycle_t clocksource_mmio_readl_up(struct clocksource *c)
 {
-	return readl_relaxed(to_mmio_clksrc(c)->reg);
+	return (cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg);
 }
 
 cycle_t clocksource_mmio_readl_down(struct clocksource *c)
 {
-	return ~readl_relaxed(to_mmio_clksrc(c)->reg);
+	return ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg);
 }
 
 cycle_t clocksource_mmio_readw_up(struct clocksource *c)
 {
-	return readw_relaxed(to_mmio_clksrc(c)->reg);
+	return (cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg);
 }
 
 cycle_t clocksource_mmio_readw_down(struct clocksource *c)
 {
-	return ~(unsigned)readw_relaxed(to_mmio_clksrc(c)->reg);
+	return ~(cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg);
 }
 
 /**
-- 
1.7.9.5
