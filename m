From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 19:15:49 +0100
Subject: [PATCH v2 2/6] mmc: pwrseq_simple: Extend to support more pins
In-Reply-To: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1422468953-7594-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many WLAN attached to a SDIO/MMC interface, needs more than one pin for
their reset sequence. For example, is very common for chips to have two
pins: one for reset and one for power enable.

This patch adds support for more reset pins to the pwrseq_simple driver
and instead hardcoding a fixed number, it uses the of_gpio_named_count()
since the MMC power sequence is only built when CONFIG_OF is enabled.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v1:
 - Many code cleanups suggested by Srinivas Kandagatla
    * Rename reset_gpio array to reset_gpios.
    * Use a zero length array for reset_gpios to avoid a kmalloc.
    * Refactor GPIO assert and de-ssert logic into a common function.
    * Simplify gpiod_put logic in case of gpiod_get error.
---
 drivers/mmc/core/pwrseq_simple.c | 55 +++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 0958c696137f..e53d3c7e059c 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 
 #include <linux/mmc/host.h>
@@ -19,16 +20,26 @@
 
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
-	struct gpio_desc *reset_gpio;
+	int nr_gpios;
+	struct gpio_desc *reset_gpios[0];
 };
 
+static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
+					      int value)
+{
+	int i;
+
+	for (i = 0; i < pwrseq->nr_gpios; i++)
+		if (!IS_ERR(pwrseq->reset_gpios[i]))
+			gpiod_set_value_cansleep(pwrseq->reset_gpios[i], value);
+}
+
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	if (!IS_ERR(pwrseq->reset_gpio))
-		gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
@@ -36,17 +47,18 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	if (!IS_ERR(pwrseq->reset_gpio))
-		gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
+	int i;
 
-	if (!IS_ERR(pwrseq->reset_gpio))
-		gpiod_put(pwrseq->reset_gpio);
+	for (i = 0; i < pwrseq->nr_gpios; i++)
+		if (!IS_ERR(pwrseq->reset_gpios[i]))
+			gpiod_put(pwrseq->reset_gpios[i]);
 
 	kfree(pwrseq);
 	host->pwrseq = NULL;
@@ -62,20 +74,33 @@ static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
-	int ret = 0;
+	int i, nr_gpios, ret = 0;
 
-	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
+	nr_gpios = of_gpio_named_count(dev->of_node, "reset-gpios");
+	if (nr_gpios < 0)
+		nr_gpios = 0;
+
+	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple) + nr_gpios *
+			 sizeof(struct gpio_desc *), GFP_KERNEL);
 	if (!pwrseq)
 		return -ENOMEM;
 
-	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpio) &&
-		PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
-		PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
-		ret = PTR_ERR(pwrseq->reset_gpio);
-		goto free;
+	for (i = 0; i < nr_gpios; i++) {
+		pwrseq->reset_gpios[i] = gpiod_get_index(dev, "reset", i,
+							 GPIOD_OUT_HIGH);
+		if (IS_ERR(pwrseq->reset_gpios[i]) &&
+		    PTR_ERR(pwrseq->reset_gpios[i]) != -ENOENT &&
+		    PTR_ERR(pwrseq->reset_gpios[i]) != -ENOSYS) {
+			ret = PTR_ERR(pwrseq->reset_gpios[i]);
+
+			while (--i)
+				gpiod_put(pwrseq->reset_gpios[i]);
+
+			goto free;
+		}
 	}
 
+	pwrseq->nr_gpios = nr_gpios;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	host->pwrseq = &pwrseq->pwrseq;
 
-- 
2.1.3
