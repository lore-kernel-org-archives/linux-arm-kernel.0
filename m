From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Nov 2015 12:34:49 +0100
Subject: [PATCH] net: dsa: include gpio consumer header file
Message-ID: <6383467.TZ5s6u4A6T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the introduction of the switch gpio reset API, I'm getting
build errors in configurations that disable CONFIG_GPIOLIB:

net/dsa/dsa.c:783:16: error: implicit declaration of function 'gpio_to_desc' [-Werror=implicit-function-declaration]

The reason is that linux/gpio/consumer.h is not automatically
included without gpiolib support. This adds an explicit #include
statement to make it compile in all configurations. The reset
functionality will not work without gpiolib, which is what you
get when disabling the feature.

As far as I can tell, gpiolib is supported on all architectures
on which you can have DSA at the moment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cc30c16344fc ("net: dsa: Add support for a switch reset gpio")

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 0b5565f923cc..b7448c8490ac 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -24,6 +24,7 @@
 #include <linux/of_gpio.h>
 #include <linux/sysfs.h>
 #include <linux/phy_fixed.h>
+#include <linux/gpio/consumer.h>
 #include "dsa_priv.h"
 
 char dsa_driver_version[] = "0.1";
