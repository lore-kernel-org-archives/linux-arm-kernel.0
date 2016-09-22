From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 22 Sep 2016 15:56:21 +0800
Subject: [PATCH] clocksource/drivers/ti-32k: Prevent ftrace recursion
Message-ID: <20160922075621.3725-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ti-32k can be used as a scheduler clock. We properly marked
omap_32k_read_sched_clock() as notrace but we then call another
function ti_32k_read_cycles() that _wasn't_ notrace.

Having a traceable function in the sched_clock() path leads to a
recursion within ftrace and a kernel crash.

Fix this by adding notrace attribute to the ti_32k_read_cycles()
function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/timer-ti-32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 92b7e39..cf5b14e 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -65,7 +65,7 @@ static inline struct ti_32k *to_ti_32k(struct clocksource *cs)
 	return container_of(cs, struct ti_32k, cs);
 }
 
-static cycle_t ti_32k_read_cycles(struct clocksource *cs)
+static cycle_t notrace ti_32k_read_cycles(struct clocksource *cs)
 {
 	struct ti_32k *ti = to_ti_32k(cs);
 
-- 
2.9.3
