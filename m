From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:07 +0900
Subject: [PATCH 10/27] ARM: SAMSUNG: Add s3c_gpio_cfgall_range() function
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Add a function to configure a range of GPIOs function and
pull in one go, mainly for the SDHCI and framebuffer helpers
which tend to do this.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: Fix small comments]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/gpio-config.c           |   16 ++++++++++++++++
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |   19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index fa180dc..8a37211 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -56,6 +56,22 @@ int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
 }
 EXPORT_SYMBOL_GPL(s3c_gpio_cfgpin_range);
 
+int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
+			  unsigned int cfg, s3c_gpio_pull_t pull)
+{
+	int ret;
+
+	for (; nr > 0; nr--, start++) {
+		s3c_gpio_setpull(start, pull);
+		ret = s3c_gpio_cfgpin(start, cfg);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_gpio_cfgall_range);
+
 unsigned s3c_gpio_getcfg(unsigned int pin)
 {
 	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 5fa3d89..ef0f1e3 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -153,6 +153,25 @@ extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
 */
 extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
 
+/* configure `all` aspects of an gpio */
+
+/**
+ * s3c_gpio_cfgall_range() - configure range of gpio functtion and pull.
+ * @start: The gpio number to start at.
+ * @nr: The number of gpio to configure from @start.
+ * @cfg: The configuration to use
+ * @pull: The pull setting to use.
+ *
+ * Run s3c_gpio_cfgpin() and s3c_gpio_setpull() over the gpio range starting
+ * @gpio and running for @size.
+ *
+ * @sa s3c_gpio_cfgpin
+ * @sa s3c_gpio_setpull
+ * @sa s3c_gpio_cfgpin_range
+ */
+extern int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
+				 unsigned int cfg, s3c_gpio_pull_t pull);
+
 /* Define values for the drvstr available for each gpio pin.
  *
  * These values control the value of the output signal driver strength,
-- 
1.6.2.5
