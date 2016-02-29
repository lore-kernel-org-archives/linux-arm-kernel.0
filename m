From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 15:44:01 +0000
Subject: [PATCH 7/8] clk: bcm2835: add gates that require PM_DEBUG to be set
In-Reply-To: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456760642-2412-8-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add clocks that require PM_DEBUG to be set and mark this
fact in the gate_data structure, so that this fact can get
referred to if needed.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   16 +++++++++++++++-
 include/dt-bindings/clock/bcm2835.h |    2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 12ce209..2ddff8f 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -463,6 +463,8 @@ struct bcm2835_gate_data {
 	const char *parent;
 
 	u32 ctl_reg;
+
+	bool requires_pm_debug;
 };
 
 struct bcm2835_pll {
@@ -2078,10 +2080,22 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 	 * don't bother exposing) are individual gates off of the
 	 * non-stop vpu clock.
 	 */
+	[BCM2835_CLOCK_PERA] = REGISTER_GATE(
+		.name = "pera",
+		.parent = "vpu",
+		.ctl_reg = CM_PERIACTL,
+		.requires_pm_debug = true),
 	[BCM2835_CLOCK_PERI_IMAGE] = REGISTER_GATE(
 		.name = "peri_image",
 		.parent = "vpu",
-		.ctl_reg = CM_PERIICTL),
+		.ctl_reg = CM_PERIICTL,
+		.requires_pm_debug = true),
+	[BCM2835_CLOCK_SYS] = REGISTER_GATE(
+		.name = "sys",
+		.parent = "vpu",
+		.ctl_reg = CM_SYSCTL,
+		.requires_pm_debug = true),
+
 };
 
 static int bcm2835_clk_probe(struct platform_device *pdev)
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 109086e..7bc03cd 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -71,3 +71,5 @@
 #define BCM2835_CLOCK_DSI1E		53
 #define BCM2835_CLOCK_DSI1_IMAGE	54
 #define BCM2835_CLOCK_ARM		55
+#define BCM2835_CLOCK_PERA		56
+#define BCM2835_CLOCK_SYS		57
-- 
1.7.10.4
