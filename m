From: keescook@chromium.org (Kees Cook)
Date: Mon, 16 Oct 2017 16:48:52 -0700
Subject: [PATCH] arm: pxa: Convert timers to use timer_setup()
Message-ID: <20171016234852.GA102339@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds a static variable to hold the
interrupt private data pointer.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mach-pxa/lubbock.c    | 15 ++++++---------
 arch/arm/mach-pxa/sharpsl_pm.c |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index d6159f8ef0c2..df45682e99a5 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -381,14 +381,11 @@ static struct pxafb_mach_info sharp_lm8v31 = {
 
 #define	MMC_POLL_RATE		msecs_to_jiffies(1000)
 
-static void lubbock_mmc_poll(unsigned long);
 static irq_handler_t mmc_detect_int;
+static void *mmc_detect_int_data;
+static struct timer_list mmc_timer;
 
-static struct timer_list mmc_timer = {
-	.function	= lubbock_mmc_poll,
-};
-
-static void lubbock_mmc_poll(unsigned long data)
+static void lubbock_mmc_poll(struct timer_list *unused)
 {
 	unsigned long flags;
 
@@ -401,7 +398,7 @@ static void lubbock_mmc_poll(unsigned long data)
 	if (LUB_IRQ_SET_CLR & (1 << 0))
 		mod_timer(&mmc_timer, jiffies + MMC_POLL_RATE);
 	else {
-		(void) mmc_detect_int(LUBBOCK_SD_IRQ, (void *)data);
+		(void) mmc_detect_int(LUBBOCK_SD_IRQ, mmc_detect_int_data);
 		enable_irq(LUBBOCK_SD_IRQ);
 	}
 }
@@ -421,8 +418,8 @@ static int lubbock_mci_init(struct device *dev,
 {
 	/* detect card insert/eject */
 	mmc_detect_int = detect_int;
-	init_timer(&mmc_timer);
-	mmc_timer.data = (unsigned long) data;
+	mmc_detect_int_data = data;
+	timer_setup(&mmc_timer, lubbock_mmc_poll, 0);
 	return request_irq(LUBBOCK_SD_IRQ, lubbock_detect_int,
 			   0, "lubbock-sd-detect", data);
 }
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 249b7bd5fbc4..398ba9ba2632 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -341,7 +341,7 @@ static void sharpsl_charge_toggle(struct work_struct *private_)
 	sharpsl_pm.charge_start_time = jiffies;
 }
 
-static void sharpsl_ac_timer(unsigned long data)
+static void sharpsl_ac_timer(struct timer_list *unused)
 {
 	int acin = sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN);
 
@@ -366,7 +366,7 @@ static irqreturn_t sharpsl_ac_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void sharpsl_chrg_full_timer(unsigned long data)
+static void sharpsl_chrg_full_timer(struct timer_list *unused)
 {
 	dev_dbg(sharpsl_pm.dev, "Charge Full at time: %lx\n", jiffies);
 
@@ -841,9 +841,9 @@ static int sharpsl_pm_probe(struct platform_device *pdev)
 	sharpsl_pm.charge_mode = CHRG_OFF;
 	sharpsl_pm.flags = 0;
 
-	setup_timer(&sharpsl_pm.ac_timer, sharpsl_ac_timer, 0UL);
+	timer_setup(&sharpsl_pm.ac_timer, sharpsl_ac_timer, 0);
 
-	setup_timer(&sharpsl_pm.chrg_full_timer, sharpsl_chrg_full_timer, 0UL);
+	timer_setup(&sharpsl_pm.chrg_full_timer, sharpsl_chrg_full_timer, 0);
 
 	led_trigger_register_simple("sharpsl-charge", &sharpsl_charge_led_trigger);
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
