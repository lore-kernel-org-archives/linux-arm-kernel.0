From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon,  4 Mar 2013 10:40:06 +0800
Subject: [PATCH] pinctrl: core: add dependence of GPIOLIB
Message-ID: <1362364806-23076-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In file included from drivers/pinctrl/core.c:30:0:
include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
include/asm-generic/gpio.h:270:2: error: implicit declaration of
function '__gpio_get_value' [-Werror=implicit-function-declaration]
include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
include/asm-generic/gpio.h:276:2: error: implicit declaration of
function '__gpio_set_value' [-Werror=implicit-function-declaration]
drivers/pinctrl/core.c: In function 'pinctrl_ready_for_gpio_range':
drivers/pinctrl/core.c:297:9: error: implicit declaration of function
'gpio_to_chip' [-Werror=implicit-function-declaration]
drivers/pinctrl/core.c:297:27: warning: initialization makes pointer
from integer without a cast [enabled by default]
drivers/pinctrl/core.c:304:45: error: dereferencing pointer to
incomplete type
drivers/pinctrl/core.c:305:26: error: dereferencing pointer to
incomplete type
drivers/pinctrl/core.c:305:39: error: dereferencing pointer to
incomplete type
cc1: some warnings being treated as errors
make[2]: *** [drivers/pinctrl/core.o] Error 1
make[1]: *** [drivers/pinctrl] Error 2
make[1]: *** Waiting for unfinished jobs....

It's caused by CONFIG_GPIOLIB isn't enabled for some platform. So
add the dependence on pinctrl_ready_for_gpio_range().

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f8a632d..a969947 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -27,7 +27,11 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/machine.h>
+
+#ifdef CONFIG_GPIOLIB
 #include <asm-generic/gpio.h>
+#endif
+
 #include "core.h"
 #include "devicetree.h"
 #include "pinmux.h"
@@ -290,6 +294,7 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
  * certain GPIO pin doesn't have back-end pinctrl device. If the return value
  * is false, it means that pinctrl device may not be ready.
  */
+#ifdef CONFIG_GPIOLIB
 static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 {
 	struct pinctrl_dev *pctldev;
@@ -309,6 +314,9 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 	}
 	return false;
 }
+#else
+static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
+#endif
 
 /**
  * pinctrl_get_device_gpio_range() - find device for GPIO range
-- 
1.7.10.4
