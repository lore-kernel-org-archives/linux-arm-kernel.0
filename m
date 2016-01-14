From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 14 Jan 2016 13:45:40 +0000
Subject: [PATCH V3 5/6] clk: bcm2835: enable management of PCM clock
In-Reply-To: <1452779142-20615-1-git-send-email-kernel@martin.sperl.org>
References: <1452779142-20615-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452779142-20615-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Enable the PCM clock in the SOC, which is used by the
bcm2835-i2s driver.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   13 +++++++++++++
 include/dt-bindings/clock/bcm2835.h |    1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 6b0ebf7..7bbe310 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -89,6 +89,8 @@
 #define CM_HSMDIV		0x08c
 #define CM_OTPCTL		0x090
 #define CM_OTPDIV		0x094
+#define CM_PCMCTL		0x098
+#define CM_PCMDIV		0x09c
 #define CM_PWMCTL		0x0a0
 #define CM_PWMDIV		0x0a4
 #define CM_SMICTL		0x0b0
@@ -860,6 +862,16 @@ static const struct bcm2835_clock_data bcm2835_clock_pwm_data = {
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
 struct bcm2835_gate_data {
 	const char *name;
 	const char *parent;
@@ -1676,6 +1688,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 	[BCM2835_CLOCK_HSM]	= REGISTER_CLK(&bcm2835_clock_hsm_data),
 	[BCM2835_CLOCK_EMMC]	= REGISTER_CLK(&bcm2835_clock_emmc_data),
 	[BCM2835_CLOCK_PWM]	= REGISTER_CLK(&bcm2835_clock_pwm_data),
+	[BCM2835_CLOCK_PCM]	= REGISTER_CLK(&bcm2835_clock_pcm_data),
 	/* the gates */
 	[BCM2835_CLOCK_PERI_IMAGE] = REGISTER_GATE(
 		&bcm2835_clock_peri_image_data),
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 87235ac..9a7b4a5 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -44,3 +44,4 @@
 #define BCM2835_CLOCK_EMMC		28
 #define BCM2835_CLOCK_PERI_IMAGE	29
 #define BCM2835_CLOCK_PWM		30
+#define BCM2835_CLOCK_PCM		31
-- 
1.7.10.4
