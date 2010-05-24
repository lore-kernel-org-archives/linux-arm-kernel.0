From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:05 +0100
Subject: [PATCH 4/8] ARM: S3C24XX: Documentation: update GPIO documentation
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upate the S3C24XX GPIO documentation after the changes for gpiolib
and show which calls are being replaced by gpiolib or the new s3c
generic calls.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung-S3C24XX/GPIO.txt |   35 ++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
index 2af2cf3..9fe5fea 100644
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
@@ -24,8 +24,16 @@ GPIOLIB
   listed below will be removed (they may be marked as __deprecated
   in the near future).
 
-  - s3c2410_gpio_getpin
-  - s3c2410_gpio_setpin
+  The following functions now either have a s3c_ specific variant
+  or are merged into gpiolib. See the definitions in
+  arch/arm/plat-samsung/include/plat/gpio-cfg.h:
+
+  s3c2410_gpio_setpin()		gpio_set_value() or gpio_direction_output()
+  s3c2410_gpio_getpin()		gpio_get_value() or gpio_direction_input()
+  s3c2410_gpio_getirq()		gpio_to_irq()
+  s3c2410_gpio_cfgpin()		s3c_gpio_cfgpin()
+  s3c2410_gpio_getcfg()		s3c_gpio_getcfg()
+  s3c2410_gpio_pullup()		s3c_gpio_setpull()
 
 
 Headers
@@ -54,6 +62,11 @@ PIN Numbers
   eg S3C2410_GPA(0) or S3C2410_GPF(1). These defines are used to tell
   the GPIO functions which pin is to be used.
 
+  With the conversion to gpiolib, there is no longer a direct conversion
+  from gpio pin number to register base address as in earlier kernels. This
+  is due to the number space required for newer SoCs where the later
+  GPIOs are not contiguous.
+
 
 Configuring a pin
 -----------------
@@ -71,6 +84,8 @@ Configuring a pin
    which would turn GPA(0) into the lowest Address line A0, and set
    GPE(8) to be connected to the SDIO/MMC controller's SDDAT1 line.
 
+   The s3c_gpio_cfgpin() call is a functional replacement for this call.
+
 
 Reading the current configuration
 ---------------------------------
@@ -82,6 +97,9 @@ Reading the current configuration
   The return value will be from the same set of values which can be
   passed to s3c2410_gpio_cfgpin().
 
+  The s3c_gpio_getcfg() call should be a functional replacement for
+  this call.
+
 
 Configuring a pull-up resistor
 ------------------------------
@@ -95,6 +113,10 @@ Configuring a pull-up resistor
   Where the to value is zero to set the pull-up off, and 1 to enable
   the specified pull-up. Any other values are currently undefined.
 
+  The s3c_gpio_setpull() offers similar functionality, but with the
+  ability to encode whether the pull is up or down. Currently there
+  is no 'just on' state, so up or down must be selected.
+
 
 Getting the state of a PIN
 --------------------------
@@ -106,6 +128,9 @@ Getting the state of a PIN
   This will return either zero or non-zero. Do not count on this
   function returning 1 if the pin is set.
 
+  This call is now implemented by the relevant gpiolib calls, convert
+  your board or driver to use gpiolib.
+
 
 Setting the state of a PIN
 --------------------------
@@ -117,6 +142,9 @@ Setting the state of a PIN
   Which sets the given pin to the value. Use 0 to write 0, and 1 to
   set the output to 1.
 
+  This call is now implemented by the relevant gpiolib calls, convert
+  your board or driver to use gpiolib.
+
 
 Getting the IRQ number associated with a PIN
 --------------------------------------------
@@ -128,6 +156,9 @@ Getting the IRQ number associated with a PIN
 
   Note, not all pins have an IRQ.
 
+  This call is now implemented by the relevant gpiolib calls, convert
+  your board or driver to use gpiolib.
+
 
 Authour
 -------
-- 
1.6.3.3
