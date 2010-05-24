From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:09 +0100
Subject: [PATCH 8/8] ARM: SAMSUNG: gpio-cfg.h: update documentation
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the documentation on the gpio configuration calls to add more
references to useful information and also to document the values that
are passed.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 4683823..db4112c 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -43,6 +43,11 @@ struct s3c_gpio_chip;
  * layouts. Provide an point to vector control routine and provide any
  * per-bank configuration information that other systems such as the
  * external interrupt code will need.
+ *
+ * @sa s3c_gpio_cfgpin
+ * @sa s3c_gpio_getcfg
+ * @sa s3c_gpio_setpull
+ * @sa s3c_gpio_getpull
  */
 struct s3c_gpio_cfg {
 	unsigned int	cfg_eint;
@@ -75,6 +80,20 @@ struct s3c_gpio_cfg {
  * Configure which function is actually connected to the external
  * pin, such as an gpio input, output or some form of special function
  * connected to an internal peripheral block.
+ *
+ * The @to parameter can be one of the generic S3C_GPIO_INPUT, S3C_GPIO_OUTPUT
+ * or S3C_GPIO_SFN() to indicate one of the possible values that the helper
+ * will then generate the correct bit mask and shift for the configuration.
+ *
+ * If a bank of GPIOs all needs to be set to special-function 2, then
+ * the following code will work:
+ *
+ *	for (gpio = start; gpio < end; gpio++)
+ *		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+ *
+ * The @to parameter can also be a specific value already shifted to the
+ * correct position in the control register, although these are discouraged
+ * in newer kernels and are only being kept for compatibility.
  */
 extern int s3c_gpio_cfgpin(unsigned int pin, unsigned int to);
 
@@ -108,6 +127,8 @@ extern unsigned s3c_gpio_getcfg(unsigned int pin);
  * This function sets the state of the pull-{up,down} resistor for the
  * specified pin. It will return 0 if successfull, or a negative error
  * code if the pin cannot support the requested pull setting.
+ *
+ * @pull is one of S3C_GPIO_PULL_NONE, S3C_GPIO_PULL_DOWN or S3C_GPIO_PULL_UP.
 */
 extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
 
-- 
1.6.3.3
