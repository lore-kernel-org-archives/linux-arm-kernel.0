From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:05 +0200
Subject: [PATCH 03/11] clocksource: sun5i: Use of_io_request_and_map
In-Reply-To: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427746633-9137-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

of_iomap doesn't do a request_mem_region on the memory area defined in the DT
it maps. Switch to of_io_request_and_map to make sure we're the only users.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 5320846..6b08694 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -143,7 +143,8 @@ static void __init sun5i_timer_init(struct device_node *node)
 	int ret, irq;
 	u32 val;
 
-	timer_base = of_iomap(node, 0);
+	timer_base = of_io_request_and_map(node, 0,
+					   of_node_full_name(node));
 	if (!timer_base)
 		panic("Can't map registers");
 
-- 
1.9.1
