From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 10:13:04 +0100
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
In-Reply-To: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The need for reset GPIOs has several times been pointed out from
erlier posted patchsets. Especially some WLAN chips which are
attached to an SDIO interface may use a GPIO reset.

The reset GPIO is asserted at initialization and prior we start the
power up procedure. The GPIO will be de-asserted right after the power
has been provided to the card, from the ->post_power_on() callback.

Note, the reset GPIO is optional. Thus we don't return an error even if
we can't find a GPIO for the consumer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Fixed call to kfree().

---
 drivers/mmc/core/pwrseq_simple.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 61c991e..0958c69 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -18,31 +19,68 @@
 
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
+	struct gpio_desc *reset_gpio;
 };
 
+static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+}
+
+static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+}
+
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_put(pwrseq->reset_gpio);
+
 	kfree(pwrseq);
 	host->pwrseq = NULL;
 }
 
 static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
+	.post_power_on = mmc_pwrseq_simple_post_power_on,
+	.power_off = mmc_pwrseq_simple_pre_power_on,
 	.free = mmc_pwrseq_simple_free,
 };
 
 int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
+	int ret = 0;
 
 	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
 	if (!pwrseq)
 		return -ENOMEM;
 
+	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
+	if (IS_ERR(pwrseq->reset_gpio) &&
+		PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
+		PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
+		ret = PTR_ERR(pwrseq->reset_gpio);
+		goto free;
+	}
+
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	host->pwrseq = &pwrseq->pwrseq;
 
 	return 0;
+free:
+	kfree(pwrseq);
+	return ret;
 }
-- 
1.9.1
