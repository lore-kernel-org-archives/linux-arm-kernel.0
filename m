From: nickbane1@gmail.com (Nick Bane)
Date: Fri, 08 Apr 2011 17:42:12 +0100
Subject: [PATCH] pxa270 rtc wakeup event fix
Message-ID: <4D9F3AE4.2040101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the failure to register the IRQ_RTCAlrm alarm as a wakeup event.
It is misinterpreted as a gpio irq not a PWER bitmask.

Nick Bane

Index: linux-2.6.38/arch/arm/mach-pxa/pxa27x.c
===================================================================
--- linux-2.6.38.orig/arch/arm/mach-pxa/pxa27x.c    2011-04-07 
21:07:54.000000000 +0100
+++ linux-2.6.38/arch/arm/mach-pxa/pxa27x.c    2011-04-07 
21:08:40.000000000 +0100
@@ -341,6 +341,11 @@
  static inline void pxa27x_init_pm(void) {}
  #endif

+static int is_gpio_irq(int irq)
+{
+    return (irq == IRQ_GPIO0) || (irq == IRQ_GPIO1) || (irq >= 
PXA_GPIO_IRQ_BASE);
+}
+
  /* PXA27x:  Various gpios can issue wakeup events.  This logic only
   * handles the simple cases, not the WEMUX2 and WEMUX3 options
   */
@@ -349,7 +354,7 @@
      int gpio = IRQ_TO_GPIO(d->irq);
      uint32_t mask;

-    if (gpio >= 0 && gpio < 128)
+    if (is_gpio_irq(d->irq) && gpio >= 0 && gpio < 128)
          return gpio_set_wake(gpio, on);

      if (d->irq == IRQ_KEYPAD)
