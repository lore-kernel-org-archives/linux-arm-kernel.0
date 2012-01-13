From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 20:00:30 +0000
Subject: [PATCH] Simpad: use DEFINE_SPINLOCK()
Message-ID: <20120113200030.GD1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SPINLOCK() rather than a run-time initializer, which avoids
the need to wait for the spinlock to be explicitly initialized before
its used.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Jochen,

I wonder why you didn't use this initializer first time around - it's
there so you can declare spinlocks in static data without needing to
write code to explicitly initialize them.

 arch/arm/mach-sa1100/simpad.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index cdb9d19..4ddfcc3 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -41,7 +41,7 @@
  */
 
 static long cs3_shadow;
-static spinlock_t cs3_lock;
+static DEFINE_SPINLOCK(cs3_lock);
 static struct gpio_chip cs3_gpio;
 
 long simpad_get_cs3_ro(void)
@@ -197,7 +197,7 @@ static void __init simpad_map_io(void)
 	/* Initialize CS3 */
 	cs3_shadow = (EN1 | EN0 | LED2_ON | DISPLAY_ON |
 		RS232_ON | ENABLE_5V | RESET_SIMCARD | DECT_POWER_ON);
-	__simpad_write_cs3(); /* Spinlocks not yet initialized */
+	__simpad_write_cs3();
 
         sa1100_register_uart_fns(&simpad_port_fns);
 	sa1100_register_uart(0, 3);  /* serial interface */
@@ -354,8 +354,6 @@ static int __init simpad_init(void)
 {
 	int ret;
 
-	spin_lock_init(&cs3_lock);
-
 	cs3_gpio.label = "simpad_cs3";
 	cs3_gpio.base = SIMPAD_CS3_GPIO_BASE;
 	cs3_gpio.ngpio = 24;
