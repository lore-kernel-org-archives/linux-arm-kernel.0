From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 18:05:39 +0200
Subject: [PATCH 3/3] drm/omap: include gpio/consumer.h where needed
In-Reply-To: <1462982509-342936-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
Message-ID: <1462982845-461029-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of the display drivers for OMAP use the gpio descriptor functions
that are only available in linux/gpio.h if GPIOLIB is enabled and
otherwise produce a build error:

drivers/gpu/drm/omapdrm/displays/encoder-opa362.c: In function 'opa362_enable':
drivers/gpu/drm/omapdrm/displays/encoder-opa362.c:101:3: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
drivers/gpu/drm/omapdrm/displays/panel-dpi.c: In function 'panel_dpi_probe_pdata':
drivers/gpu/drm/omapdrm/displays/panel-dpi.c:189:23: error: implicit declaration of function 'gpio_to_desc' [-Werror=implicit-function-declaration]
drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c: In function 'sharp_ls_enable':
drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c:120:3: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]

This replaces the existing linux/gpio.h with linux/gpio/consumer.h
where needed. In case of panel-lgphilips-lb035q02.c however, we
also have to include linux/gpio.h to get the definition of gpio_is_valid
and gpio_set_value_cansleep that are used for the non-DT case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c           | 1 +
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c           | 2 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c           | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c                | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c             | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c | 1 +
 drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c     | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c  | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c     | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c     | 2 +-
 10 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c b/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
index 225fd8d6ab31..667ca4a24ece 100644
--- a/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
+++ b/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
@@ -9,6 +9,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
index 8c246c213e06..9594ff7a2b0c 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
@@ -14,7 +14,7 @@
  * the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
index 2fd5602880a7..671806ca7d6a 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
@@ -9,7 +9,7 @@
  * the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dpi.c b/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
index e780fd4f8b46..7c2331be8d15 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
@@ -9,7 +9,7 @@
  * the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 36485c2137ce..2b118071b5a1 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -14,7 +14,7 @@
 #include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
index 458f77bc473d..ac680e1de603 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c b/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
index 780cb263a318..38d2920a95e6 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
@@ -15,7 +15,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
index 529a017602e4..4363fffc87e3 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
index 31efcca801bd..deb416736aad 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
@@ -29,7 +29,7 @@
 #include <linux/sched.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
index 03e2beb7b4f0..d93175b03a12 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
-- 
2.7.0
