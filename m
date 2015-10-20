From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:36 +0800
Subject: [PATCH 3/7] clocksource: pistachio: fix ftrace
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pistachio can be used as a scheduler clock, we properly marked
pistachio_read_sched_clock() as notrace. But we then call another function
pistachio_clocksource_read_cycles() that _wasn't_ notrace.

This patch fix this by adding notrace attribute to the
pistachio_clocksource_read_cycles() function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/time-pistachio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index 18d4266..bba6799 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -67,7 +67,8 @@ static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
 	writel(value, base + 0x20 * gpt_id + offset);
 }
 
-static cycle_t pistachio_clocksource_read_cycles(struct clocksource *cs)
+static cycle_t notrace
+pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
 	u32 counter, overflw;
-- 
2.6.1
