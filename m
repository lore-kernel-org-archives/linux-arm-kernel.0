From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Oct 2012 19:12:07 +0000
Subject: [PATCH] ARM: footbridge: nw_gpio_lock is raw_spin_lock
Message-ID: <201210031912.07343.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bd31b85960a "locking, ARM: Annotate low level hw locks as raw"
made nw_gpio_lock a raw spinlock, but did not change all the
users in device drivers. This fixes the remaining ones.

sound/oss/waveartist.c: In function 'vnc_mute_spkr':
sound/oss/waveartist.c:1485:2: warning: passing argument 1 of 'spinlock_check' from incompatible pointer type [enabled by default]
include/linux/spinlock.h:272:102: note: expected 'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'
drivers/char/ds1620.c: In function 'netwinder_lock':
drivers/char/ds1620.c:77:2: warning: passing argument 1 of 'spinlock_check' from incompatible pointer type [enabled by default]
include/linux/spinlock.h:272:102: note: expected 'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'
drivers/char/nwflash.c: In function 'kick_open':
drivers/char/nwflash.c:620:2: warning: passing argument 1 of 'spinlock_check' from incompatible pointer type [enabled by default]
include/linux/spinlock.h:272:102: note: expected 'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---

queued in the late/fixes branch, will submit later in the merge window
unless I hear objections.

diff --git a/drivers/char/ds1620.c b/drivers/char/ds1620.c
index aab9605..24ffd8c 100644
--- a/drivers/char/ds1620.c
+++ b/drivers/char/ds1620.c
@@ -74,21 +74,21 @@ static inline void netwinder_ds1620_reset(void)
 
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
index d45c334..04e2a94 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -617,9 +617,9 @@ static void kick_open(void)
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
index 24c430f..672af8b 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1482,9 +1482,9 @@ vnc_mute_spkr(wavnc_info *devc)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	nw_cpld_modify(CPLD_UNMUTE, devc->spkr_mute_state ? 0 : CPLD_UNMUTE);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 static void
