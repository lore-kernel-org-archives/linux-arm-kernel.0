From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Mar 2011 10:59:48 +0100
Subject: [PATCH 1/2 v2] ARM: iomux-imx31: allow pin_list to be const
In-Reply-To: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1299059989-16360-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning in a mx3_defconfig build:

	arch/arm/mach-mx3/mach-bug.c: In function 'bug_board_init':
	arch/arm/mach-mx3/mach-bug.c:47: warning: passing argument 1 of 'mxc_iomux_setup_multiple_pins' discards qualifiers from pointer target type

While at it remove some useless consts from unsigned int arguments.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

while testing the first version Sascha noticed that the
mxc_iomux_release_multiple_pins function needs a const, too, because
it's called by mxc_iomux_setup_multiple_pins in the error path.
(And it's a logical thing to do, too.)

When implementing that I wondered about the useless const unsigned ints
and removed them.

Thanks
Uwe

 arch/arm/mach-mx3/iomux-imx31.c            |   12 ++++++------
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mx3/iomux-imx31.c b/arch/arm/mach-mx3/iomux-imx31.c
index a1d7fa5..cf8f809 100644
--- a/arch/arm/mach-mx3/iomux-imx31.c
+++ b/arch/arm/mach-mx3/iomux-imx31.c
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(mxc_iomux_set_pad);
  * 	- reserves the pin so that it is not claimed by another driver
  * 	- setups the iomux according to the configuration
  */
-int mxc_iomux_alloc_pin(const unsigned int pin, const char *label)
+int mxc_iomux_alloc_pin(unsigned int pin, const char *label)
 {
 	unsigned pad = pin & IOMUX_PADNUM_MASK;
 
@@ -118,10 +118,10 @@ int mxc_iomux_alloc_pin(const unsigned int pin, const char *label)
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
 
@@ -139,7 +139,7 @@ setup_error:
 }
 EXPORT_SYMBOL(mxc_iomux_setup_multiple_pins);
 
-void mxc_iomux_release_pin(const unsigned int pin)
+void mxc_iomux_release_pin(unsigned int pin)
 {
 	unsigned pad = pin & IOMUX_PADNUM_MASK;
 
@@ -148,9 +148,9 @@ void mxc_iomux_release_pin(const unsigned int pin)
 }
 EXPORT_SYMBOL(mxc_iomux_release_pin);
 
-void mxc_iomux_release_multiple_pins(unsigned int *pin_list, int count)
+void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count)
 {
-	unsigned int *p = pin_list;
+	const unsigned int *p = pin_list;
 	int i;
 
 	for (i = 0; i < count; i++) {
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index cbaed29..c92f0b1 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -112,12 +112,12 @@ enum iomux_gp_func {
  * 	- setups the iomux according to the configuration
  * 	- if the pin is configured as a GPIO, we claim it through kernel gpiolib
  */
-int mxc_iomux_alloc_pin(const unsigned int pin, const char *label);
+int mxc_iomux_alloc_pin(unsigned int pin, const char *label);
 /*
  * setups mutliple pins
  * convenient way to call the above function with tables
  */
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label);
 
 /*
@@ -126,12 +126,12 @@ int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
  * 	- frees the GPIO if the pin was configured as GPIO
  * 	- DOES NOT reconfigure the IOMUX in its reset state
  */
-void mxc_iomux_release_pin(const unsigned int pin);
+void mxc_iomux_release_pin(unsigned int pin);
 /*
  * releases multiple pins
  * convenvient way to call the above function with tables
  */
-void mxc_iomux_release_multiple_pins(unsigned int *pin_list, int count);
+void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count);
 
 /*
  * This function enables/disables the general purpose function for a particular
-- 
1.7.2.3
