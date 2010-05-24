From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:06 +0100
Subject: [PATCH 5/8] ARM: S3C24XX: Documentation: add section on gpiolib
	changes
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add section to the S3C24XX GPIO documentation on the recent changes
to move towards gpiolib integration.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung-S3C24XX/GPIO.txt |   44 ++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
index 9fe5fea..228ecb6 100644
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
@@ -36,6 +36,50 @@ GPIOLIB
   s3c2410_gpio_pullup()		s3c_gpio_setpull()
 
 
+GPIOLIB conversion
+------------------
+
+If you need to convert your board or driver to use gpiolib from the exiting
+s3c2410 api, then here are some notes on the process.
+
+1) If your board is exclusively using an GPIO, say to control peripheral
+   power, then it will require to claim the gpio with gpio_request() before
+   it can use it.
+
+   It is recommended to check the return value, with at least WARN_ON()
+   during initialisation.
+
+2) The s3c2410_gpio_cfgpin() can be directly replaced with s3c_gpio_cfgpin()
+   as they have the same arguments, and can either take the pin specific
+   values, or the more generic special-function-number arguments.
+
+3) s3c2410_gpio_pullup() changs have the problem that whilst the 
+   s3c2410_gpio_pullup(x, 1) can be easily translated to the
+   s3c_gpio_setpull(x, S3C_GPIO_PULL_NONE), the s3c2410_gpio_pullup(x, 0)
+   are not so easy.
+
+   The s3c2410_gpio_pullup(x, 0) case enables the pull-up (or in the case
+   of some of the devices, a pull-down) and as such the new API distinguishes
+   between the UP and DOWN case. There is currently no 'just turn on' setting
+   which may be required if this becomes a problem.
+
+4) s3c2410_gpio_setpin() can be replaced by gpio_set_value(), the old call
+   does not implicitly configure the relevant gpio to output. The gpio
+   direction should be changed before using gpio_set_value().
+
+5) s3c2410_gpio_getpin() is replaceable by gpio_get_value() if the pin
+   has been set to input. It is currently unknown what the behaviour is
+   when using gpio_get_value() on an output pin (s3c2410_gpio_getpin
+   would return the value the pin is supposed to be outputting).
+
+6) s3c2410_gpio_getirq() should be directly replacable with the
+   gpio_to_irq() call.
+
+The s3c2410_gpio and gpio_ calls have always operated on the same gpio
+numberspace, so there is no problem with converting the gpio numbering
+between the calls.
+
+
 Headers
 -------
 
-- 
1.6.3.3
