From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 10:17:53 +0100
Subject: [RFC 1/2] clocksource: track usage
In-Reply-To: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421399874-29119-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Track whether the clocksource is enabled or disabled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/linux/clocksource.h |  4 ++++
 kernel/time/clocksource.c   | 26 ++++++++++++++++++++++++++
 kernel/time/timekeeping.c   |  8 +++-----
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index abcafaa20b86..7735902fc5f6 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -210,6 +210,8 @@ struct clocksource {
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
 
+#define CLOCK_SOURCE_USED			0x200
+
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
 
@@ -282,6 +284,8 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
 
 extern int clocksource_register(struct clocksource*);
 extern int clocksource_unregister(struct clocksource*);
+extern int clocksource_enable(struct clocksource *);
+extern void clocksource_disable(struct clocksource *);
 extern void clocksource_touch_watchdog(void);
 extern struct clocksource* clocksource_get_next(void);
 extern void clocksource_change_rating(struct clocksource *cs, int rating);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b79f39bda7e1..920a4da58eb0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -889,6 +889,32 @@ int clocksource_unregister(struct clocksource *cs)
 }
 EXPORT_SYMBOL(clocksource_unregister);
 
+/**
+ * clocksource_enable - enable a registered clocksource
+ * @cs:	clocksource to enable
+ */
+int clocksource_enable(struct clocksource *cs)
+{
+	cs->flags |= CLOCK_SOURCE_USED;
+	if (cs->enable)
+		return cs->enable(cs);
+
+	return 0;
+}
+EXPORT_SYMBOL(clocksource_enable);
+
+/**
+ * clocksource_disable - disable a registered clocksource
+ * @cs:	clocksource to disable
+ */
+void clocksource_disable(struct clocksource *cs)
+{
+	cs->flags &= ~CLOCK_SOURCE_USED;
+	if (cs->disable)
+		cs->disable(cs);
+}
+EXPORT_SYMBOL(clocksource_disable);
+
 #ifdef CONFIG_SYSFS
 /**
  * sysfs_show_current_clocksources - sysfs interface for current clocksource
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6a931852082f..1c6ffd3d068c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -915,11 +915,10 @@ static int change_clocksource(void *data)
 	 * for built-in code (owner == NULL) as well.
 	 */
 	if (try_module_get(new->owner)) {
-		if (!new->enable || new->enable(new) == 0) {
+		if (!new->enable || clocksource_enable(new) == 0) {
 			old = tk->tkr.clock;
 			tk_setup_internals(tk, new);
-			if (old->disable)
-				old->disable(old);
+			clocksource_disable(old);
 			module_put(old->owner);
 		} else {
 			module_put(new->owner);
@@ -1080,8 +1079,7 @@ void __init timekeeping_init(void)
 	ntp_init();
 
 	clock = clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
+	clocksource_enable(clock);
 	tk_setup_internals(tk, clock);
 
 	tk_set_xtime(tk, &now);
-- 
2.1.0
