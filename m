From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 31 Jan 2012 12:35:09 +0000 (GMT)
Subject: mfp/gpio regression: pxa_last_gpio used before initialized
Message-ID: <1328013309.53711.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa27x_mfp_init() uses pxa_last_gpio when initializing gpio_desc[].
pxa_gpio_probe() initializes pxa_last_gpio to pxa_gpio_nums().

Unfortunately on my hx4700 running 3.3.0-rc1, pxa27x_mfp_init() is called before pxa_gpio_probe(), resulting in the following:

__mfp_validate: GPIO20 is invalid pin
__mfp_validate: GPIO21 is invalid pin
__mfp_validate: GPIO15 is invalid pin
__mfp_validate: GPIO78 is invalid pin
__mfp_validate: GPIO79 is invalid pin
__mfp_validate: GPIO80 is invalid pin
__mfp_validate: GPIO33 is invalid pin
__mfp_validate: GPIO48 is invalid pin
__mfp_validate: GPIO49 is invalid pin
__mfp_validate: GPIO50 is invalid pin
__mfp_validate: GPIO51 is invalid pin
__mfp_validate: GPIO54 is invalid pin
__mfp_validate: GPIO55 is invalid pin
__mfp_validate: GPIO56 is invalid pin
__mfp_validate: GPIO57 is invalid pin
__mfp_validate: GPIO85 is invalid pin
__mfp_validate: GPIO104 is invalid pin
__mfp_validate: GPIO117 is invalid pin
__mfp_validate: GPIO118 is invalid pin
__mfp_validate: GPIO34 is invalid pin
__mfp_validate: GPIO35 is invalid pin
__mfp_validate: GPIO36 is invalid pin
__mfp_validate: GPIO37 is invalid pin
__mfp_validate: GPIO38 is invalid pin
__mfp_validate: GPIO39 is invalid pin
__mfp_validate: GPIO40 is invalid pin
__mfp_validate: GPIO41 is invalid pin
__mfp_validate: GPIO42 is invalid pin
__mfp_validate: GPIO43 is invalid pin
__mfp_validate: GPIO44 is invalid pin
__mfp_validate: GPIO45 is invalid pin
__mfp_validate: GPIO17 is invalid pin
__mfp_validate: GPIO28 is invalid pin
__mfp_validate: GPIO29 is invalid pin
__mfp_validate: GPIO30 is invalid pin
__mfp_validate: GPIO31 is invalid pin
__mfp_validate: GPIO113 is invalid pin
__mfp_validate: GPIO23 is invalid pin
__mfp_validate: GPIO24 is invalid pin
__mfp_validate: GPIO25 is invalid pin
__mfp_validate: GPIO26 is invalid pin
__mfp_validate: GPIO19 is invalid pin
__mfp_validate: GPIO86 is invalid pin
__mfp_validate: GPIO87 is invalid pin
__mfp_validate: GPIO88 is invalid pin
__mfp_validate: GPIO72 is invalid pin
__mfp_validate: GPIO96 is invalid pin
__mfp_validate: GPIO12 is invalid pin
__mfp_validate: GPIO13 is invalid pin
__mfp_validate: GPIO14 is invalid pin
__mfp_validate: GPIO10 is invalid pin
__mfp_validate: GPIO13 is invalid pin
__mfp_validate: GPIO107 is invalid pin
__mfp_validate: GPIO108 is invalid pin
__mfp_validate: GPIO58 is invalid pin
__mfp_validate: GPIO66 is invalid pin
__mfp_validate: GPIO61 is invalid pin
__mfp_validate: GPIO71 is invalid pin
__mfp_validate: GPIO81 is invalid pin
__mfp_validate: GPIO116 is invalid pin

A temporary workaround is to statically initialize pxa_last_gpio to the correct value (120 in the case of pxa270):

--- clean-3.3-rc1/drivers/gpio/gpio-pxa.c	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/drivers/gpio/gpio-pxa.c	2012-01-31 12:28:30.760602224 +0000
@@ -52,7 +52,7 @@
 
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
-int pxa_last_gpio;
+int pxa_last_gpio = 120;
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
