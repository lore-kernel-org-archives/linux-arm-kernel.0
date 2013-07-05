From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 6 Jul 2013 00:53:09 +0200
Subject: [PATCH 3/9] clocksource: dw_apb_timer: quirk for variants with 64bit
 counter
In-Reply-To: <201307060051.09716.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
Message-ID: <201307060053.10182.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a quirk for IP variants containing two load_count and value
registers that are used to provide 64bit accuracy on 32bit systems.

The added accuracy is currently not used, the driver is only adapted to
handle the different register layout and make it work on affected devices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clocksource/dw_apb_timer.c |   27 +++++++++++++++++++++++++++
 include/linux/dw_apb_timer.h       |    6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index f5e7be8..bd45351 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -56,6 +56,17 @@ static void apbt_init_regs(struct dw_apb_timer *timer, int quirks)
 	timer->reg_control = APBTMR_N_CONTROL;
 	timer->reg_eoi = APBTMR_N_EOI;
 	timer->reg_int_status = APBTMR_N_INT_STATUS;
+
+	/*
+	 * On variants with 64bit counters some registers are
+	 * moved further down.
+	 */
+	if (quirks & APBTMR_QUIRK_64BIT_COUNTER) {
+		timer->reg_current_value += 0x4;
+		timer->reg_control += 0x8;
+		timer->reg_eoi += 0x8;
+		timer->reg_int_status += 0x8;
+	}
 }
 
 static unsigned long apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
@@ -145,6 +156,10 @@ static void apbt_set_mode(enum clock_event_mode mode,
 		udelay(1);
 		pr_debug("Setting clock period %lu for HZ %d\n", period, HZ);
 		apbt_writel(timer, period, timer->reg_load_count);
+
+		if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
+			apbt_writel(timer, 0, timer->reg_load_count + 0x4);
+
 		ctrl |= APBTMR_CONTROL_ENABLE;
 		apbt_writel(timer, ctrl, timer->reg_control);
 		break;
@@ -168,6 +183,10 @@ static void apbt_set_mode(enum clock_event_mode mode,
 		 * running mode.
 		 */
 		apbt_writel(timer, ~0, timer->reg_load_count);
+
+		if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
+			apbt_writel(timer, 0, timer->reg_load_count + 0x4);
+
 		ctrl &= ~APBTMR_CONTROL_INT;
 		ctrl |= APBTMR_CONTROL_ENABLE;
 		apbt_writel(timer, ctrl, timer->reg_control);
@@ -199,6 +218,10 @@ static int apbt_next_event(unsigned long delta,
 	apbt_writel(timer, ctrl, timer->reg_control);
 	/* write new count */
 	apbt_writel(timer, delta, timer->reg_load_count);
+
+	if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
+		apbt_writel(timer, 0, timer->reg_load_count + 0x4);
+
 	ctrl |= APBTMR_CONTROL_ENABLE;
 	apbt_writel(timer, ctrl, timer->reg_control);
 
@@ -325,6 +348,10 @@ void dw_apb_clocksource_start(struct dw_apb_clocksource *dw_cs)
 	ctrl &= ~APBTMR_CONTROL_ENABLE;
 	apbt_writel(timer, ctrl, timer->reg_control);
 	apbt_writel(timer, ~0, timer->reg_load_count);
+
+	if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
+		apbt_writel(timer, 0, timer->reg_load_count + 0x4);
+
 	/* enable, mask interrupt */
 	ctrl &= ~APBTMR_CONTROL_MODE_PERIODIC;
 	ctrl |= (APBTMR_CONTROL_ENABLE | APBTMR_CONTROL_INT);
diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 7dc7166..80f6686 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -19,6 +19,12 @@
 
 #define APBTMRS_REG_SIZE       0x14
 
+/* The IP uses two registers for count and values, to provide 64bit accuracy
+ * on 32bit platforms. The additional registers move the following registers
+ * down by 0x8 byte, as both the count and value registers are duplicated.
+ */
+#define APBTMR_QUIRK_64BIT_COUNTER	BIT(0)
+
 struct dw_apb_timer {
 	void __iomem				*base;
 	unsigned long				freq;
-- 
1.7.10.4
