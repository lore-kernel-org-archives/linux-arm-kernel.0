From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2012 18:28:29 +0000
Subject: [PATCH v2 02/15] ARM: local timers: introduce a new registration
 interface
In-Reply-To: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326479322-6033-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to switch to a runtime selectable local timer,
add a registration interface that timer drivers can use to
register to the core.

local_timer_setup() and local_timer_stop() are made weak symbols
in order not to break existing setups.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |   15 +++++++++++++++
 arch/arm/kernel/smp.c             |   27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 7e1b2c5..f088d63 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -15,6 +15,11 @@
 
 struct clock_event_device;
 
+struct local_timer_ops {
+	int  (*setup)(struct clock_event_device *);
+	void (*stop)(struct clock_event_device *);
+};
+
 /*
  * Setup a per-cpu timer, whether it be a local timer or dummy broadcast
  */
@@ -38,6 +43,11 @@ void local_timer_stop(struct clock_event_device *);
  */
 int local_timer_setup(struct clock_event_device *);
 
+/*
+ * Register a local timer driver
+ */
+int local_timer_register(struct local_timer_ops *);
+
 #else
 
 static inline int local_timer_setup(struct clock_event_device *evt)
@@ -48,6 +58,11 @@ static inline int local_timer_setup(struct clock_event_device *evt)
 static inline void local_timer_stop(struct clock_event_device *evt)
 {
 }
+
+static inline int local_timer_register(struct local_timer_ops *ops)
+{
+	return -ENXIO;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57db122..52c66f5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -475,6 +475,33 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
 	clockevents_register_device(evt);
 }
 
+static struct local_timer_ops *lt_ops;
+
+#ifdef CONFIG_LOCAL_TIMERS
+int local_timer_register(struct local_timer_ops *ops)
+{
+	if (lt_ops)
+		return -EBUSY;
+
+	lt_ops = ops;
+	return 0;
+}
+#endif
+
+int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *clk)
+{
+	if (lt_ops)
+		return lt_ops->setup(clk);
+
+	return -ENXIO;
+}
+
+void __attribute__ ((weak)) local_timer_stop(struct clock_event_device *clk)
+{
+	if (lt_ops)
+		lt_ops->stop(clk);
+}
+
 void __cpuinit percpu_timer_setup(void)
 {
 	unsigned int cpu = smp_processor_id();
-- 
1.7.7.1
