From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Mar 2011 10:59:49 +0100
Subject: [PATCH 2/2 v2] ARM: mxc91231/iomux: allow pin_list to be const
In-Reply-To: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1299059989-16360-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it remove some useless consts from unsigned int arguments.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxc91231/iomux.c                  |   14 +++++++-------
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h |    8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mxc91231/iomux.c b/arch/arm/mach-mxc91231/iomux.c
index 405d9b1..66fc41c 100644
--- a/arch/arm/mach-mxc91231/iomux.c
+++ b/arch/arm/mach-mxc91231/iomux.c
@@ -50,7 +50,7 @@ unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
 /*
  * set the mode for a IOMUX pin.
  */
-int mxc_iomux_mode(const unsigned int pin_mode)
+int mxc_iomux_mode(unsigned int pin_mode)
 {
 	u32 side, field, l, mode, ret = 0;
 	void __iomem *reg;
@@ -114,7 +114,7 @@ EXPORT_SYMBOL(mxc_iomux_set_pad);
  * 	- reserves the pin so that it is not claimed by another driver
  * 	- setups the iomux according to the configuration
  */
-int mxc_iomux_alloc_pin(const unsigned int pin_mode, const char *label)
+int mxc_iomux_alloc_pin(unsigned int pin_mode, const char *label)
 {
 	unsigned pad = PIN_GLOBAL_NUM(pin_mode);
 	if (pad >= (PIN_MAX + 1)) {
@@ -134,10 +134,10 @@ int mxc_iomux_alloc_pin(const unsigned int pin_mode, const char *label)
 }
 EXPORT_SYMBOL(mxc_iomux_alloc_pin);
 
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label)
 {
-	unsigned int *p = pin_list;
+	const unsigned int *p = pin_list;
 	int i;
 	int ret = -EINVAL;
 
@@ -155,7 +155,7 @@ setup_error:
 }
 EXPORT_SYMBOL(mxc_iomux_setup_multiple_pins);
 
-void mxc_iomux_release_pin(const unsigned int pin_mode)
+void mxc_iomux_release_pin(unsigned int pin_mode)
 {
 	unsigned pad = PIN_GLOBAL_NUM(pin_mode);
 
@@ -164,9 +164,9 @@ void mxc_iomux_release_pin(const unsigned int pin_mode)
 }
 EXPORT_SYMBOL(mxc_iomux_release_pin);
 
-void mxc_iomux_release_multiple_pins(unsigned int *pin_list, int count)
+void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count)
 {
-	unsigned int *p = pin_list;
+	const unsigned int *p = pin_list;
 	int i;
 
 	for (i = 0; i < count; i++) {
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
index 15d5951..bf28df0 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
@@ -46,12 +46,12 @@
  * 	- setups the iomux according to the configuration
  * 	- if the pin is configured as a GPIO, we claim it through kernel gpiolib
  */
-int mxc_iomux_alloc_pin(const unsigned int pin_mode, const char *label);
+int mxc_iomux_alloc_pin(unsigned int pin_mode, const char *label);
 /*
  * setups mutliple pins
  * convenient way to call the above function with tables
  */
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label);
 
 /*
@@ -60,12 +60,12 @@ int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
  * 	- frees the GPIO if the pin was configured as GPIO
  * 	- DOES NOT reconfigure the IOMUX in its reset state
  */
-void mxc_iomux_release_pin(const unsigned int pin_mode);
+void mxc_iomux_release_pin(unsigned int pin_mode);
 /*
  * releases multiple pins
  * convenvient way to call the above function with tables
  */
-void mxc_iomux_release_multiple_pins(unsigned int *pin_list, int count);
+void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count);
 
 #define MUX_SIDE_AP		(0)
 #define MUX_SIDE_SP		(1)
-- 
1.7.2.3
