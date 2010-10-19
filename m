From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:04 +0200
Subject: [PATCH 09/12] ARM: footbridge: Convert gpio and led locks to
	raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

nw_gpio_lock and led_lock need to be real spinlocks on
preempt-rt. Convert it them to raw_spinlock and fixup all users. No
change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-footbridge/include/mach/hardware.h |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c          |   14 +++++++-------
 arch/arm/mach-footbridge/netwinder-leds.c        |   10 +++++-----
 drivers/char/ds1620.c                            |    8 ++++----
 drivers/char/nwflash.c                           |    4 ++--
 drivers/mtd/maps/dc21285.c                       |    4 ++--
 sound/oss/waveartist.c                           |    4 ++--
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 51dd902..eee37b6 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -86,7 +86,7 @@
 #define CPLD_FLASH_WR_ENABLE	1
 
 #ifndef __ASSEMBLY__
-extern spinlock_t nw_gpio_lock;
+extern raw_spinlock_t nw_gpio_lock;
 extern void nw_gpio_modify_op(unsigned int mask, unsigned int set);
 extern void nw_gpio_modify_io(unsigned int mask, unsigned int in);
 extern unsigned int nw_gpio_read(void);
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index ac7ffa6..c903dad 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -68,7 +68,7 @@ static inline void wb977_ww(int reg, int val)
 /*
  * This is a lock for accessing ports GP1_IO_BASE and GP2_IO_BASE
  */
-DEFINE_SPINLOCK(nw_gpio_lock);
+DEFINE_RAW_SPINLOCK(nw_gpio_lock);
 EXPORT_SYMBOL(nw_gpio_lock);
 
 static unsigned int current_gpio_op;
@@ -327,9 +327,9 @@ static inline void wb977_init_gpio(void)
 	/*
 	 * Set Group1/Group2 outputs
 	 */
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_gpio_modify_op(-1, GPIO_RED_LED | GPIO_FAN);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 /*
@@ -390,9 +390,9 @@ static void __init cpld_init(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_cpld_modify(-1, CPLD_UNMUTE | CPLD_7111_DISABLE);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 static unsigned char rwa_unlock[] __initdata =
@@ -616,9 +616,9 @@ static int __init nw_hw_init(void)
 		cpld_init();
 		rwa010_init();
 
-		spin_lock_irqsave(&nw_gpio_lock, flags);
+		raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 		nw_gpio_modify_op(GPIO_RED_LED|GPIO_GREEN_LED, DEFAULT_LEDS);
-		spin_unlock_irqrestore(&nw_gpio_lock, flags);
+		raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 	}
 	return 0;
 }
diff --git a/arch/arm/mach-footbridge/netwinder-leds.c b/arch/arm/mach-footbridge/netwinder-leds.c
index 00269fe..e57102e 100644
--- a/arch/arm/mach-footbridge/netwinder-leds.c
+++ b/arch/arm/mach-footbridge/netwinder-leds.c
@@ -31,13 +31,13 @@
 static char led_state;
 static char hw_led_state;
 
-static DEFINE_SPINLOCK(leds_lock);
+static DEFINE_RAW_SPINLOCK(leds_lock);
 
 static void netwinder_leds_event(led_event_t evt)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&leds_lock, flags);
+	raw_spin_lock_irqsave(&leds_lock, flags);
 
 	switch (evt) {
 	case led_start:
@@ -117,12 +117,12 @@ static void netwinder_leds_event(led_event_t evt)
 		break;
 	}
 
-	spin_unlock_irqrestore(&leds_lock, flags);
+	raw_spin_unlock_irqrestore(&leds_lock, flags);
 
 	if  (led_state & LED_STATE_ENABLED) {
-		spin_lock_irqsave(&nw_gpio_lock, flags);
+		raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 		nw_gpio_modify_op(GPIO_RED_LED | GPIO_GREEN_LED, hw_led_state);
-		spin_unlock_irqrestore(&nw_gpio_lock, flags);
+		raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 	}
 }
 
diff --git a/drivers/char/ds1620.c b/drivers/char/ds1620.c
index dbee868..0ad33dc 100644
--- a/drivers/char/ds1620.c
+++ b/drivers/char/ds1620.c
@@ -73,21 +73,21 @@ static inline void netwinder_ds1620_reset(void)
 
 static inline void netwinder_lock(unsigned long *flags)
 {
-	spin_lock_irqsave(&nw_gpio_lock, *flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, *flags);
 }
 
 static inline void netwinder_unlock(unsigned long *flags)
 {
-	spin_unlock_irqrestore(&nw_gpio_lock, *flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, *flags);
 }
 
 static inline void netwinder_set_fan(int i)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_gpio_modify_op(GPIO_FAN, i ? GPIO_FAN : 0);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 static inline int netwinder_get_fan(void)
diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index 043a1c7..0392150 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -618,9 +618,9 @@ static void kick_open(void)
 	 * we want to write a bit pattern XXX1 to Xilinx to enable
 	 * the write gate, which will be open for about the next 2ms.
 	 */
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_cpld_modify(CPLD_FLASH_WR_ENABLE, CPLD_FLASH_WR_ENABLE);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 
 	/*
 	 * let the ISA bus to catch on...
diff --git a/drivers/mtd/maps/dc21285.c b/drivers/mtd/maps/dc21285.c
index b3cb3a1..d1703e8 100644
--- a/drivers/mtd/maps/dc21285.c
+++ b/drivers/mtd/maps/dc21285.c
@@ -38,9 +38,9 @@ static void nw_en_write(void)
 	 * we want to write a bit pattern XXX1 to Xilinx to enable
 	 * the write gate, which will be open for about the next 2ms.
 	 */
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_cpld_modify(CPLD_FLASH_WR_ENABLE, CPLD_FLASH_WR_ENABLE);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 
 	/*
 	 * let the ISA bus to catch on...
diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index 5246874..c524795 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1483,9 +1483,9 @@ vnc_mute_spkr(wavnc_info *devc)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_cpld_modify(CPLD_UNMUTE, devc->spkr_mute_state ? 0 : CPLD_UNMUTE);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 static void
-- 
1.7.2.3
