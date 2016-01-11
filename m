From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 11 Jan 2016 19:55:56 +0000
Subject: [PATCH V2 4/4] clk: bcm2835: add missing 22 HW-clocks.
In-Reply-To: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452542157-2387-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

There were 22 HW clocks missing from the clock driver.

These have been included and int_bits and frac_bits
have been set correctly based on information extracted
from the broadcom videocore headers
(http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz)

For an extracted view of the registers please see:
https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md

bcm2835_clock_per_parents has been assigned as the parent
clock for all new clocks, but this may not be correct
in all cases - documentation on this is not publicly
available, so some modifications may be needed in the
future.

Note that some of those clocks may be owned by the firmware,
so we may need an additional flag to set "ownership".

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |  256 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |   22 +++
 2 files changed, 278 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 573b5b1..99cc756 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -92,8 +92,18 @@
 #define CM_PCMDIV		0x09c
 #define CM_PWMCTL		0x0a0
 #define CM_PWMDIV		0x0a4
+#define CM_SLIMCTL		0x0a8
+#define CM_SLIMDIV		0x0ac
 #define CM_SMICTL		0x0b0
 #define CM_SMIDIV		0x0b4
+#define CM_TCNTCTL		0x0c0
+#define CM_TCNTDIV		0x0c4
+#define CM_TECCTL		0x0c8
+#define CM_TECDIV		0x0cc
+#define CM_TD0CTL		0x0d0
+#define CM_TD0DIV		0x0d4
+#define CM_TD1CTL		0x0d8
+#define CM_TD1DIV		0x0dc
 #define CM_TSENSCTL		0x0e0
 #define CM_TSENSDIV		0x0e4
 #define CM_TIMERCTL		0x0e8
@@ -107,6 +117,9 @@
 #define CM_SDCCTL		0x1a8
 #define CM_SDCDIV		0x1ac
 #define CM_ARMCTL		0x1b0
+#define CM_ARMDIV		0x1b4
+#define CM_AVEOCTL		0x1b8
+#define CM_AVEODIV		0x1bc
 #define CM_EMMCCTL		0x1c0
 #define CM_EMMCDIV		0x1c4
 
@@ -838,6 +851,226 @@ static const struct bcm2835_clock_data bcm2835_clock_pcm_data = {
 	.frac_bits = 12,
 };
 
+static const struct bcm2835_clock_data bcm2835_clock_aveo_data = {
+	.name = "aveo",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_AVEOCTL,
+	.div_reg = CM_AVEODIV,
+	.int_bits = 4,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_cam0_data = {
+	.name = "cam0",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_CAM0CTL,
+	.div_reg = CM_CAM0DIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_cam1_data = {
+	.name = "cam1",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_CAM1CTL,
+	.div_reg = CM_CAM1DIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_ccp2_data = {
+	.name = "ccp2",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_CCP2CTL,
+	.div_reg = CM_CCP2DIV,
+	.int_bits = 1,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dft_data = {
+	.name = "dft",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DFTCTL,
+	.div_reg = CM_DFTDIV,
+	.int_bits = 5,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dpi_data = {
+	.name = "dpi",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DPICTL,
+	.div_reg = CM_DPIDIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dsi0e_data = {
+	.name = "dsi0e",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DSI0ECTL,
+	.div_reg = CM_DSI0EDIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dsi0p_data = {
+	.name = "dsi0p",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DSI0PCTL,
+	.div_reg = CM_DSI0PDIV,
+	.int_bits = 1,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dsi1e_data = {
+	.name = "dsi1e",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DSI1ECTL,
+	.div_reg = CM_DSI1EDIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_dsi1p_data = {
+	.name = "dsi1p",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_DSI1PCTL,
+	.div_reg = CM_DSI1PDIV,
+	.int_bits = 1,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_gnric_data = {
+	.name = "gnric",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_GNRICCTL,
+	.div_reg = CM_GNRICDIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_gp0_data = {
+	.name = "gp0",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_GP0CTL,
+	.div_reg = CM_GP0DIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_gp1_data = {
+	.name = "gp1",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_GP1CTL,
+	.div_reg = CM_GP1DIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_gp2_data = {
+	.name = "gp2",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_GP2CTL,
+	.div_reg = CM_GP2DIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_peria_data = {
+	.name = "peria",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_PERIACTL,
+	.div_reg = CM_PERIADIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_pulse_data = {
+	.name = "pulse",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_PULSECTL,
+	.div_reg = CM_PULSEDIV,
+	.int_bits = 12,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_slim_data = {
+	.name = "slim",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_SLIMCTL,
+	.div_reg = CM_SLIMDIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_smi_data = {
+	.name = "smi",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_SMICTL,
+	.div_reg = CM_SMIDIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_sys_data = {
+	.name = "sys",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_SYSCTL,
+	.div_reg = CM_SYSDIV,
+	.int_bits = 1,
+	.frac_bits = 0,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_td0_data = {
+	.name = "td0",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_TD0CTL,
+	.div_reg = CM_TD0DIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_td1_data = {
+	.name = "td1",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_TD1CTL,
+	.div_reg = CM_TD1DIV,
+	.int_bits = 12,
+	.frac_bits = 12,
+};
+
+static const struct bcm2835_clock_data bcm2835_clock_tec_data = {
+	.name = "tec",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_TECCTL,
+	.div_reg = CM_TECDIV,
+	.int_bits = 6,
+	.frac_bits = 0,
+};
+
 struct bcm2835_pll {
 	struct clk_hw hw;
 	struct bcm2835_cprman *cprman;
@@ -1629,6 +1862,29 @@ static const struct bcm2835_register_clock bcm2835_register_clocks[] = {
 	REGISTER_CLOCK(BCM2835_CLOCK_EMMC, &bcm2835_clock_emmc_data),
 	REGISTER_CLOCK(BCM2835_CLOCK_PWM, &bcm2835_clock_pwm_data),
 	REGISTER_CLOCK(BCM2835_CLOCK_PCM, &bcm2835_clock_pcm_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_AVEO, &bcm2835_clock_aveo_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_CAM0, &bcm2835_clock_cam0_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_CAM1, &bcm2835_clock_cam1_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_CCP2, &bcm2835_clock_ccp2_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DFT, &bcm2835_clock_dft_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DPI, &bcm2835_clock_dpi_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DSI0E, &bcm2835_clock_dsi0e_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DSI0P, &bcm2835_clock_dsi0p_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DSI1E, &bcm2835_clock_dsi1e_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_DSI1P, &bcm2835_clock_dsi1p_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_GNRIC, &bcm2835_clock_gnric_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_GP0, &bcm2835_clock_gp0_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_GP1, &bcm2835_clock_gp1_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_GP2, &bcm2835_clock_gp2_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_PERIA, &bcm2835_clock_peria_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_PULSE, &bcm2835_clock_pulse_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_SLIM, &bcm2835_clock_slim_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_SMI, &bcm2835_clock_smi_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_SYS, &bcm2835_clock_sys_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_TD0, &bcm2835_clock_td0_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_TD1, &bcm2835_clock_td1_data),
+	REGISTER_CLOCK(BCM2835_CLOCK_TEC, &bcm2835_clock_tec_data),
+
 };
 
 void bcm2835_register_duplicate_index(
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 9a7b4a5..d29f181 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -45,3 +45,25 @@
 #define BCM2835_CLOCK_PERI_IMAGE	29
 #define BCM2835_CLOCK_PWM		30
 #define BCM2835_CLOCK_PCM		31
+#define BCM2835_CLOCK_AVEO		32
+#define BCM2835_CLOCK_CAM0		33
+#define BCM2835_CLOCK_CAM1		34
+#define BCM2835_CLOCK_CCP2		35
+#define BCM2835_CLOCK_DFT		36
+#define BCM2835_CLOCK_DPI		37
+#define BCM2835_CLOCK_DSI0E		38
+#define BCM2835_CLOCK_DSI0P		39
+#define BCM2835_CLOCK_DSI1E		40
+#define BCM2835_CLOCK_DSI1P		41
+#define BCM2835_CLOCK_GNRIC		42
+#define BCM2835_CLOCK_GP0		43
+#define BCM2835_CLOCK_GP1		44
+#define BCM2835_CLOCK_GP2		45
+#define BCM2835_CLOCK_PERIA		46
+#define BCM2835_CLOCK_PULSE		47
+#define BCM2835_CLOCK_SLIM		48
+#define BCM2835_CLOCK_SMI		49
+#define BCM2835_CLOCK_SYS		50
+#define BCM2835_CLOCK_TD0		51
+#define BCM2835_CLOCK_TD1		52
+#define BCM2835_CLOCK_TEC		53
-- 
1.7.10.4
