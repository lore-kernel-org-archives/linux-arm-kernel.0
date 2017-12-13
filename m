From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Dec 2017 19:53:12 +0100
Subject: [PATCH 2/3] clocksource/drivers: timer-of: parse the chosen node
In-Reply-To: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171213185313.20017-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a way for drivers to know whether the timer they are currently handling
is a clocksource or a clockevent.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-of.c | 22 ++++++++++++++++++++++
 drivers/clocksource/timer-of.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index a31990408153..71680eacd390 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -195,3 +195,25 @@ void __init timer_of_cleanup(struct timer_of *to)
 	if (to->flags & TIMER_OF_BASE)
 		timer_base_exit(&to->of_base);
 }
+
+int __init timer_of_is_type(struct device_node *np, char *type)
+{
+	struct device_node *node, *timer;
+
+	if (!of_chosen)
+		return 0;
+
+	node = of_get_child_by_name(of_chosen, type);
+	if (!node)
+		return 0;
+
+	timer = of_parse_phandle(node, "timer", 0);
+	of_node_put(node);
+	if (!timer)
+		return 0;
+
+	if (timer == np)
+		return 1;
+
+	return 0;
+}
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index 3f708f1be43d..24923cfe748d 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -70,4 +70,7 @@ extern int __init timer_of_init(struct device_node *np,
 
 extern void __init timer_of_cleanup(struct timer_of *to);
 
+extern int __init timer_of_is_type(struct device_node *np, char *type);
+#define timer_of_is_clocksource(np) timer_of_is_type(np, "linux,clocksource")
+#define timer_of_is_clockevent(np) timer_of_is_type(np, "linux,clockevent")
 #endif
-- 
2.15.1
