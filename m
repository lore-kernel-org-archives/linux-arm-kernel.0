From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Mar 2015 11:20:53 +0100
Subject: [PATCH v3 2/5] clocksource: sun5i: Use of_io_request_and_map
In-Reply-To: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425550856-12928-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_iomap doesn't do a request_mem_region on the memory area defined in the DT
it maps. Switch to of_io_request_and_map to make sure we're the only users.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/timer-sun5i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 836f92ac0ffd..2f70ed528174 100644
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
2.3.0
