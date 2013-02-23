From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 23 Feb 2013 18:55:47 +0100
Subject: [PATCH] pinctrl or i2c-s3c2410: fix pinctrl NULL return values in
 stubs
Message-ID: <201302231855.47560.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

while implementing devicetree support for the s3c2416 I noticed a fault
in the i2c-s3c2410 driver. The s3c2416 does not support pinctrl at the
moment (and will probably for a while), so the fallback functions in
pinctrl/consumer.h were used. These functions fail silently and the
relevant pinctrl_get only returns NULL but the i2c driver only checked
for real error-pointers. This resulted in the i2c gpios not getting
configured at all.

There are of course two possible solutions. Check for NULL pinctrl
handles in the driver or return meaningful error codes in the pinctrl
stubs. All other pinctrl drivers also only seem to handle real error
codes and would gladly accept NULL handles, so I'm not sure which is
the correct fix to not break to much existing code.

Therefore I implemented both variants and you get to pick :-) .
This of course means from the following patches only one is necessary.


Heiko
