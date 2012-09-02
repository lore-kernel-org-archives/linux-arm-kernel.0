From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun,  2 Sep 2012 18:24:49 +0200
Subject: [PATCH] gpio: samsung: Update documentation
In-Reply-To: <503D267A.2090406@gmail.com>
References: <503D267A.2090406@gmail.com>
Message-ID: <1346603089-14122-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Samsung GPIO API documentation to reflect removal of
the s3c24xx specific gpio API. While at it, fix some typos.

The notes on conversion from s3c2410_* functions to the gpiolib
API are left here just in case there is any out of tree code that
still needs to be converted.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 Documentation/arm/Samsung-S3C24XX/GPIO.txt |   82 +++++++++-------------------
 Documentation/arm/Samsung/GPIO.txt         |    8 +--
 2 files changed, 28 insertions(+), 62 deletions(-)

diff --git a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
index 816d607..8b46c79 100644
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
@@ -1,4 +1,4 @@
-			S3C2410 GPIO Control
+			S3C24XX GPIO Control
 			====================

 Introduction
@@ -12,7 +12,7 @@ Introduction
   of the s3c2410 GPIO system, please read the Samsung provided
   data-sheet/users manual to find out the complete list.

-  See Documentation/arm/Samsung/GPIO.txt for the core implemetation.
+  See Documentation/arm/Samsung/GPIO.txt for the core implementation.


 GPIOLIB
@@ -41,8 +41,8 @@ GPIOLIB
 GPIOLIB conversion
 ------------------

-If you need to convert your board or driver to use gpiolib from the exiting
-s3c2410 api, then here are some notes on the process.
+If you need to convert your board or driver to use gpiolib from the phased
+out s3c2410 API, then here are some notes on the process.

 1) If your board is exclusively using an GPIO, say to control peripheral
    power, then it will require to claim the gpio with gpio_request() before
@@ -55,7 +55,7 @@ s3c2410 api, then here are some notes on the process.
    as they have the same arguments, and can either take the pin specific
    values, or the more generic special-function-number arguments.

-3) s3c2410_gpio_pullup() changs have the problem that whilst the
+3) s3c2410_gpio_pullup() changes have the problem that whilst the
    s3c2410_gpio_pullup(x, 1) can be easily translated to the
    s3c_gpio_setpull(x, S3C_GPIO_PULL_NONE), the s3c2410_gpio_pullup(x, 0)
    are not so easy.
@@ -74,7 +74,7 @@ s3c2410 api, then here are some notes on the process.
    when using gpio_get_value() on an output pin (s3c2410_gpio_getpin
    would return the value the pin is supposed to be outputting).

-6) s3c2410_gpio_getirq() should be directly replacable with the
+6) s3c2410_gpio_getirq() should be directly replaceable with the
    gpio_to_irq() call.

 The s3c2410_gpio and gpio_ calls have always operated on the same gpio
@@ -105,7 +105,7 @@ PIN Numbers
 -----------

   Each pin has an unique number associated with it in regs-gpio.h,
-  eg S3C2410_GPA(0) or S3C2410_GPF(1). These defines are used to tell
+  e.g. S3C2410_GPA(0) or S3C2410_GPF(1). These defines are used to tell
   the GPIO functions which pin is to be used.

   With the conversion to gpiolib, there is no longer a direct conversion
@@ -120,31 +120,27 @@ Configuring a pin
   The following function allows the configuration of a given pin to
   be changed.

-    void s3c2410_gpio_cfgpin(unsigned int pin, unsigned int function);
+    void s3c_gpio_cfgpin(unsigned int pin, unsigned int function);

-  Eg:
+  e.g.:

-     s3c2410_gpio_cfgpin(S3C2410_GPA(0), S3C2410_GPA0_ADDR0);
-     s3c2410_gpio_cfgpin(S3C2410_GPE(8), S3C2410_GPE8_SDDAT1);
+     s3c_gpio_cfgpin(S3C2410_GPA(0), S3C_GPIO_SFN(1));
+     s3c_gpio_cfgpin(S3C2410_GPE(8), S3C_GPIO_SFN(2));

    which would turn GPA(0) into the lowest Address line A0, and set
    GPE(8) to be connected to the SDIO/MMC controller's SDDAT1 line.

-   The s3c_gpio_cfgpin() call is a functional replacement for this call.
-

 Reading the current configuration
 ---------------------------------

-  The current configuration of a pin can be read by using:
+  The current configuration of a pin can be read by using standard
+  gpiolib function:

-  s3c2410_gpio_getcfg(unsigned int pin);
+  s3c_gpio_getcfg(unsigned int pin);

   The return value will be from the same set of values which can be
-  passed to s3c2410_gpio_cfgpin().
-
-  The s3c_gpio_getcfg() call should be a functional replacement for
-  this call.
+  passed to s3c_gpio_cfgpin().


 Configuring a pull-up resistor
@@ -154,61 +150,33 @@ Configuring a pull-up resistor
   pull-up resistors enabled. This can be configured by the following
   function:

-    void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
-
-  Where the to value is zero to set the pull-up off, and 1 to enable
-  the specified pull-up. Any other values are currently undefined.
-
-  The s3c_gpio_setpull() offers similar functionality, but with the
-  ability to encode whether the pull is up or down. Currently there
-  is no 'just on' state, so up or down must be selected.
-
-
-Getting the state of a PIN
---------------------------
-
-  The state of a pin can be read by using the function:
-
-    unsigned int s3c2410_gpio_getpin(unsigned int pin);
+    void s3c_gpio_setpull(unsigned int pin, unsigned int to);

-  This will return either zero or non-zero. Do not count on this
-  function returning 1 if the pin is set.
+  Where the to value is S3C_GPIO_PULL_NONE to set the pull-up off,
+  and S3C_GPIO_PULL_UP to enable the specified pull-up. Any other
+  values are currently undefined.

-  This call is now implemented by the relevant gpiolib calls, convert
-  your board or driver to use gpiolib.
-
-
-Setting the state of a PIN
---------------------------
-
-  The value an pin is outputing can be modified by using the following:

-    void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
+Getting and setting the state of a PIN
+--------------------------------------

-  Which sets the given pin to the value. Use 0 to write 0, and 1 to
-  set the output to 1.
-
-  This call is now implemented by the relevant gpiolib calls, convert
+  These calls are now implemented by the relevant gpiolib calls, convert
   your board or driver to use gpiolib.


 Getting the IRQ number associated with a PIN
 --------------------------------------------

-  The following function can map the given pin number to an IRQ
+  A standard gpiolib function can map the given pin number to an IRQ
   number to pass to the IRQ system.

-   int s3c2410_gpio_getirq(unsigned int pin);
+   int gpio_to_irq(unsigned int pin);

   Note, not all pins have an IRQ.

-  This call is now implemented by the relevant gpiolib calls, convert
-  your board or driver to use gpiolib.
-

-Authour
+Author
 -------

-
 Ben Dooks, 03 October 2004
 Copyright 2004 Ben Dooks, Simtec Electronics
diff --git a/Documentation/arm/Samsung/GPIO.txt b/Documentation/arm/Samsung/GPIO.txt
index 513f256..795adfd 100644
--- a/Documentation/arm/Samsung/GPIO.txt
+++ b/Documentation/arm/Samsung/GPIO.txt
@@ -5,14 +5,14 @@ Introduction
 ------------

 This outlines the Samsung GPIO implementation and the architecture
-specific calls provided alongisde the drivers/gpio core.
+specific calls provided alongside the drivers/gpio core.


 S3C24XX (Legacy)
 ----------------

 See Documentation/arm/Samsung-S3C24XX/GPIO.txt for more information
-about these devices. Their implementation is being brought into line
+about these devices. Their implementation has been brought into line
 with the core samsung implementation described in this document.


@@ -29,7 +29,7 @@ GPIO numbering is synchronised between the Samsung and gpiolib system.
 PIN configuration
 -----------------

-Pin configuration is specific to the Samsung architecutre, with each SoC
+Pin configuration is specific to the Samsung architecture, with each SoC
 registering the necessary information for the core gpio configuration
 implementation to configure pins as necessary.

@@ -38,5 +38,3 @@ driver or machine to change gpio configuration.

 See arch/arm/plat-samsung/include/plat/gpio-cfg.h for more information
 on these functions.
-
-
--
1.7.4.1
