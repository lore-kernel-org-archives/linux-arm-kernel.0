From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  5 May 2016 15:53:25 +0000
Subject: [PATCH 2/5] clk: bcm2835: expose the parent clocks via
 include/dt-bindings
In-Reply-To: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1462463608-22940-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Expose the parent clocks via include/dt-bindings,
so that they can easily get referred to in the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       | 45 ++++++++++++++++++-------------------
 include/dt-bindings/clock/bcm2835.h | 26 +++++++++++++++++++++
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index c19b99c9..1b1657d 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1303,10 +1303,10 @@ struct bcm2835_clk_desc {
 
 /* main oscillator parent mux */
 static const char *const bcm2835_clock_osc_parents[] = {
-	"gnd",
-	"xosc",
-	"testdebug0",
-	"testdebug1"
+	[BCM2835_OSC_PARENT_GND]	= "gnd",
+	[BCM2835_OSC_PARENT_OSC]	= "xosc",
+	[BCM2835_OSC_PARENT_TESTDEBUG0]	= "testdebug0",
+	[BCM2835_OSC_PARENT_TESTDEBUG1]	= "testdebug1",
 };
 
 #define REGISTER_OSC_CLK(...)	REGISTER_CLK(				\
@@ -1316,14 +1316,14 @@ static const char *const bcm2835_clock_osc_parents[] = {
 
 /* main peripherial parent mux */
 static const char *const bcm2835_clock_per_parents[] = {
-	"gnd",
-	"xosc",
-	"testdebug0",
-	"testdebug1",
-	"plla_per",
-	"pllc_per",
-	"plld_per",
-	"pllh_aux",
+	[BCM2835_PER_PARENT_GND]	= "gnd",
+	[BCM2835_PER_PARENT_OSC]	= "xosc",
+	[BCM2835_PER_PARENT_TESTDEBUG0]	= "testdebug0",
+	[BCM2835_PER_PARENT_TESTDEBUG1]	= "testdebug1",
+	[BCM2835_PER_PARENT_PLLA_PER]	= "plla_per",
+	[BCM2835_PER_PARENT_PLLC_PER]	= "pllc_per",
+	[BCM2835_PER_PARENT_PLLD_PER]	= "plld_per",
+	[BCM2835_PER_PARENT_PLLH_AUX]	= "pllh_aux",
 };
 
 #define REGISTER_PER_CLK(...)	REGISTER_CLK(				\
@@ -1333,18 +1333,17 @@ static const char *const bcm2835_clock_per_parents[] = {
 
 /* main vpu parent mux */
 static const char *const bcm2835_clock_vpu_parents[] = {
-	"gnd",
-	"xosc",
-	"testdebug0",
-	"testdebug1",
-	"plla_core",
-	"pllc_core0",
-	"plld_core",
-	"pllh_aux",
-	"pllc_core1",
-	"pllc_core2",
+	[BCM2835_VPU_PARENT_GND]	= "gnd",
+	[BCM2835_VPU_PARENT_OSC]	= "xosc",
+	[BCM2835_VPU_PARENT_TESTDEBUG0]	= "testdebug0",
+	[BCM2835_VPU_PARENT_TESTDEBUG1]	= "testdebug1",
+	[BCM2835_VPU_PARENT_PLLA_CORE]	= "plla_core",
+	[BCM2835_VPU_PARENT_PLLC_CORE0]	= "pllc_core0",
+	[BCM2835_VPU_PARENT_PLLD_CORE]	= "plld_core",
+	[BCM2835_VPU_PARENT_PLLH_AUX]	= "pllh_aux",
+	[BCM2835_VPU_PARENT_PLLC_CORE1]	= "pllc_core1",
+	[BCM2835_VPU_PARENT_PLLC_CORE2]	= "pllc_core2",
 };
-
 #define REGISTER_VPU_CLK(...)	REGISTER_CLK(				\
 	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_vpu_parents),	\
 	.parents = bcm2835_clock_vpu_parents,				\
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 360e00c..e5396fe 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -64,3 +64,29 @@
 #define BCM2835_CLOCK_CAM1		46
 #define BCM2835_CLOCK_DSI0E		47
 #define BCM2835_CLOCK_DSI1E		48
+
+/* the parent clock for different clock types */
+#define BCM2835_OSC_PARENT_GND		0
+#define BCM2835_OSC_PARENT_OSC		1
+#define BCM2835_OSC_PARENT_TESTDEBUG0	2
+#define BCM2835_OSC_PARENT_TESTDEBUG1	3
+
+#define BCM2835_PER_PARENT_GND		0
+#define BCM2835_PER_PARENT_OSC		1
+#define BCM2835_PER_PARENT_TESTDEBUG0	2
+#define BCM2835_PER_PARENT_TESTDEBUG1	3
+#define BCM2835_PER_PARENT_PLLA_PER	4
+#define BCM2835_PER_PARENT_PLLC_PER	5
+#define BCM2835_PER_PARENT_PLLD_PER	6
+#define BCM2835_PER_PARENT_PLLH_AUX	7
+
+#define BCM2835_VPU_PARENT_GND		0
+#define BCM2835_VPU_PARENT_OSC		1
+#define BCM2835_VPU_PARENT_TESTDEBUG0	2
+#define BCM2835_VPU_PARENT_TESTDEBUG1	3
+#define BCM2835_VPU_PARENT_PLLA_CORE	4
+#define BCM2835_VPU_PARENT_PLLC_CORE0	5
+#define BCM2835_VPU_PARENT_PLLD_CORE	6
+#define BCM2835_VPU_PARENT_PLLH_AUX	7
+#define BCM2835_VPU_PARENT_PLLC_CORE1	8
+#define BCM2835_VPU_PARENT_PLLC_CORE2	9
-- 
2.1.4
