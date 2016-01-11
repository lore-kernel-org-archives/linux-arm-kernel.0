From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 11 Jan 2016 19:55:55 +0000
Subject: [PATCH V2 3/4] clk: bcm2835: enable management of PCM clock
In-Reply-To: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452542157-2387-4-git-send-email-kernel@martin.sperl.org>
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
index 7c782d3..573b5b1 100644
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
@@ -826,6 +828,16 @@ static const struct bcm2835_clock_data bcm2835_clock_pwm_data = {
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
@@ -1616,6 +1628,7 @@ static const struct bcm2835_register_clock bcm2835_register_clocks[] = {
 	REGISTER_CLOCK(BCM2835_CLOCK_HSM, &bcm2835_clock_hsm_data),
 	REGISTER_CLOCK(BCM2835_CLOCK_EMMC, &bcm2835_clock_emmc_data),
 	REGISTER_CLOCK(BCM2835_CLOCK_PWM, &bcm2835_clock_pwm_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_PCM, &bcm2835_clock_pcm_data),
 };
 
 void bcm2835_register_duplicate_index(
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
