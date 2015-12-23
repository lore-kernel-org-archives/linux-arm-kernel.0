From: v1ron@mail.ru (Roman Volkov)
Date: Thu, 24 Dec 2015 00:35:11 +0300
Subject: [PATCH v2 3/3] clocksource/vt8500: Add register R/W functions
In-Reply-To: <1450906511-342-1-git-send-email-v1ron@mail.ru>
References: <1450906511-342-1-git-send-email-v1ron@mail.ru>
Message-ID: <1450906511-342-4-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

vt8500 timer requires special synchronization for accessing some of its
registers. Define special read and write functions to handle this process
transparently.

Use relaxed read/write, according to the following:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/117658:
"For accesses to the same device we don't
actually need any barriers on ARM as this is guaranteed by the
architecture."

To perform a read from the Timer Count register, user must write a one
to the Timer Control register and wait for completion flag by polling the
Timer Read Count Active bit.

To perform a write to the Count or Match registers, user must poll the
write completion flag for the corresponding register to ensure that the
previous write completed and then write the actual value.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/clocksource/vt8500_timer.c | 88 ++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index eb08d96..fd88a5b 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -38,32 +38,75 @@
 
 #define VT8500_TIMER_OFFSET	0x0100
 #define VT8500_TIMER_HZ		3000000
-#define TIMER_MATCH_VAL		0x0000
+#define TIMER_MATCH0_VAL	0x0000
+#define TIMER_MATCH1_VAL	0x0004
+#define TIMER_MATCH2_VAL	0x0008
+#define TIMER_MATCH3_VAL	0x000c
 #define TIMER_COUNT_VAL		0x0010
 #define TIMER_STATUS_VAL	0x0014
 #define TIMER_IER_VAL		0x001c		/* interrupt enable */
 #define TIMER_CTRL_VAL		0x0020
 #define TIMER_AS_VAL		0x0024		/* access status */
-#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
-#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
-#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
+/* R/W status flags */
+#define TIMER_COUNT_R_ACTIVE	(1 << 5)
+#define TIMER_COUNT_W_ACTIVE	(1 << 4)
+#define TIMER_MATCH3_W_ACTIVE	(1 << 3)
+#define TIMER_MATCH2_W_ACTIVE	(1 << 2)
+#define TIMER_MATCH1_W_ACTIVE	(1 << 1)
+#define TIMER_MATCH0_W_ACTIVE	(1 << 0)
 
 #define MIN_OSCR_DELTA		16
 
+#define vt8500_timer_sync(bit)	{ while (readl_relaxed \
+				    (regbase + TIMER_AS_VAL) & bit) \
+					cpu_relax(); }
+
 static void __iomem *regbase;
 
-static cycle_t vt8500_timer_read(struct clocksource *cs)
+static void vt8500_timer_write(u32 value, unsigned long reg)
 {
-	writel(3, regbase + TIMER_CTRL_VAL);
-	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
-		cpu_relax();
-	return readl(regbase + TIMER_COUNT_VAL);
+	switch (reg) {
+	case TIMER_COUNT_VAL:
+		vt8500_timer_sync(TIMER_COUNT_W_ACTIVE);
+		break;
+	case TIMER_MATCH0_VAL:
+		vt8500_timer_sync(TIMER_MATCH0_W_ACTIVE);
+		break;
+	case TIMER_MATCH1_VAL:
+		vt8500_timer_sync(TIMER_MATCH1_W_ACTIVE);
+		break;
+	case TIMER_MATCH2_VAL:
+		vt8500_timer_sync(TIMER_MATCH2_W_ACTIVE);
+		break;
+	case TIMER_MATCH3_VAL:
+		vt8500_timer_sync(TIMER_MATCH3_W_ACTIVE);
+		break;
+	}
+
+	writel_relaxed(value, regbase + reg);
+}
+
+static u32 vt8500_timer_read(unsigned long reg)
+{
+	if (reg == TIMER_COUNT_VAL) {
+		vt8500_timer_write(3, TIMER_CTRL_VAL);
+		vt8500_timer_sync(TIMER_COUNT_R_ACTIVE);
+
+		return readl_relaxed(regbase + TIMER_COUNT_VAL);
+	}
+
+	return readl_relaxed(regbase + reg);
+}
+
+static cycle_t vt8500_oscr0_read(struct clocksource *cs)
+{
+	return vt8500_timer_read(TIMER_COUNT_VAL);
 }
 
 static struct clocksource clocksource = {
 	.name           = "vt8500_timer",
 	.rating         = 200,
-	.read           = vt8500_timer_read,
+	.read           = vt8500_oscr0_read,
 	.mask           = CLOCKSOURCE_MASK(32),
 	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -71,23 +114,24 @@ static struct clocksource clocksource = {
 static int vt8500_timer_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
-	cycle_t alarm = clocksource.read(&clocksource) + cycles;
-	while (readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
+	unsigned long alarm = vt8500_timer_read(TIMER_COUNT_VAL) + cycles;
 
-	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
+	vt8500_timer_write(alarm, TIMER_MATCH0_VAL);
+	if ((signed)(alarm - vt8500_timer_read(
+				TIMER_COUNT_VAL)) <= MIN_OSCR_DELTA) {
 		return -ETIME;
+	}
 
-	writel(1, regbase + TIMER_IER_VAL);
+	vt8500_timer_write(1, TIMER_IER_VAL);
 
 	return 0;
 }
 
 static int vt8500_shutdown(struct clock_event_device *evt)
 {
-	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
-	writel(0, regbase + TIMER_IER_VAL);
+	vt8500_timer_write(vt8500_timer_read(TIMER_CTRL_VAL) | 1,
+					TIMER_CTRL_VAL);
+	vt8500_timer_write(0, TIMER_IER_VAL);
 	return 0;
 }
 
@@ -103,7 +147,7 @@ static struct clock_event_device clockevent = {
 static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
-	writel(0xf, regbase + TIMER_STATUS_VAL);
+	vt8500_timer_write(0xf, TIMER_STATUS_VAL);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -133,9 +177,9 @@ static void __init vt8500_timer_init(struct device_node *np)
 		return;
 	}
 
-	writel(1, regbase + TIMER_CTRL_VAL);
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	writel(~0, regbase + TIMER_MATCH_VAL);
+	vt8500_timer_write(1, TIMER_CTRL_VAL);
+	vt8500_timer_write(0xf, TIMER_STATUS_VAL);
+	vt8500_timer_write(~0, TIMER_MATCH0_VAL);
 
 	if (clocksource_register_hz(&clocksource, VT8500_TIMER_HZ))
 		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
-- 
2.6.2
