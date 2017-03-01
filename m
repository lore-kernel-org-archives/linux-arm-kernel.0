From: romain.perier@collabora.com (Romain Perier)
Date: Wed,  1 Mar 2017 15:53:09 +0100
Subject: [PATCH 3/4] mmc: pwrseq_simple: Add an optional pre-power-on-delay
In-Reply-To: <20170301145310.22813-1-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
Message-ID: <20170301145310.22813-4-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices need a while between the enablement of its clk and the time
where the reset line is asserted. When this time happens between the
pre_power_on and the post_power_on callbacks, there is a need to do an
msleep at the end of the pre_power_on callback.

This commit adds an optional DT property for such devices.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index e254368..821feaaf 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -18,6 +18,8 @@ Optional properties:
   "ext_clock" (External clock provided to the card).
 - post-power-on-delay-ms : Delay in ms after powering the card and
 	de-asserting the reset-gpios (if any)
+- pre-power-on-delay-ms : Delay in ms before powering the card and
+	asserting the reset-gpios (if any)
 
 Example:
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index a9aad9a..7218675 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -27,6 +27,7 @@ struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
 	u32 post_power_on_delay_ms;
+	u32 pre_power_on_delay_ms;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
 };
@@ -60,6 +61,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 	}
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+
+	if (pwrseq->pre_power_on_delay_ms)
+		msleep(pwrseq->pre_power_on_delay_ms);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
@@ -129,6 +133,8 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &pwrseq->post_power_on_delay_ms);
+	device_property_read_u32(dev, "pre-power-on-delay-ms",
+				 &pwrseq->pre_power_on_delay_ms);
 
 	pwrseq->pwrseq.dev = dev;
 	if (device_property_read_bool(dev, "post-ios-power-on"))
-- 
2.9.3
