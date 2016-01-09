From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  9 Jan 2016 09:25:54 +0000
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Enable the PCM clock in the SOC, which is used by the
bcm2835-i2s driver.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   15 +++++++++++++++
 include/dt-bindings/clock/bcm2835.h |    3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 015e687..5d45457 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -88,6 +88,8 @@
 #define CM_HSMDIV		0x08c
 #define CM_OTPCTL		0x090
 #define CM_OTPDIV		0x094
+#define CM_PCMCTL		0x098
+#define CM_PCMDIV		0x09c
 #define CM_PWMCTL		0x0a0
 #define CM_PWMDIV		0x0a4
 #define CM_SMICTL		0x0b0
@@ -817,6 +819,16 @@ static const struct bcm2835_clock_data bcm2835_clock_pwm_data = {
 	.frac_bits = 12,
 };
 
+static const struct bcm2835_clock_data bcm2835_clock_pcm_data = {
+	.name = "pcm",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_PCMCTL,
+	.div_reg = CM_PCMDIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
 struct bcm2835_pll {
 	struct clk_hw hw;
 	struct bcm2835_cprman *cprman;
@@ -1515,6 +1527,7 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	cprman->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cprman->regs))
 		return PTR_ERR(cprman->regs);
+	pr_info("CLK: %pK %zx\n", cprman->regs, res->start);
 
 	cprman->osc_name = of_clk_get_parent_name(dev->of_node, 0);
 	if (!cprman->osc_name)
@@ -1581,6 +1594,8 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 		bcm2835_register_clock(cprman, &bcm2835_clock_hsm_data);
 	clks[BCM2835_CLOCK_EMMC] =
 		bcm2835_register_clock(cprman, &bcm2835_clock_emmc_data);
+	clks[BCM2835_CLOCK_PCM] =
+		bcm2835_register_clock(cprman, &bcm2835_clock_pcm_data);
 
 	/*
 	 * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 61f1d20..0ec850e 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -44,5 +44,6 @@
 #define BCM2835_CLOCK_EMMC		28
 #define BCM2835_CLOCK_PERI_IMAGE	29
 #define BCM2835_CLOCK_PWM		30
+#define BCM2835_CLOCK_PCM		31
 
-#define BCM2835_CLOCK_COUNT		31
+#define BCM2835_CLOCK_COUNT		32
-- 
1.7.10.4
