From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat, 14 Jun 2014 18:23:31 +0200
Subject: [PATCH v3 09/19] clocksource: sh_cmt: Add DT support
In-Reply-To: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402763021-4067-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document DT bindings and parse them in the CMT driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/timer/renesas,cmt.txt      | 49 ++++++++++++++++
 drivers/clocksource/sh_cmt.c                       | 66 ++++++++++++++++------
 2 files changed, 97 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
new file mode 100644
index 0000000..d6a82cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -0,0 +1,49 @@
+* Renesas R-Car Compare Match Timer (CMT)
+
+The CMT is a multi-channel 16/32/48-bit timer/counter with configurable clock
+inputs and programmable compare match.
+
+Channels share hardware resources but their counter and compare match value
+are independent. A particular CMT instance can implement only a subset of the
+channels supported by the CMT model. Channel indices represent the hardware
+position of the channel in the CMT and don't match the channel numbers in the
+datasheets.
+
+Required Properties:
+
+  - compatible: must contain one of the following.
+    - "renesas,cmt-32" for the 32-bit CMT
+		(CMT0 on sh7372, sh73a0 and r8a7740)
+    - "renesas,cmt-32-fast" for the 32-bit CMT with fast clock support
+		(CMT[234] on sh7372, sh73a0 and r8a7740)
+    - "renasas,cmt-48" for the 48-bit CMT
+		(CMT1 on sh7372, sh73a0 and r8a7740)
+    - "renesas,cmt-48-gen2" for the second generation 48-bit CMT
+		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
+
+  - reg: base address and length of the registers block for the timer module.
+  - interrupt-parent, interrupts: interrupt-specifier for the timer, one per
+    channel.
+  - clocks: a list of phandle + clock-specifier pairs, one for each entry
+    in clock-names.
+  - clock-names: must contain "fck" for the functional clock.
+
+  - renesas,channels-mask: bitmask of the available channels.
+
+
+Example: R8A7790 (R-Car H2) CMT0 node
+
+	CMT0 on R8A7790 implements hardware channels 5 and 6 only and names
+	them channels 0 and 1 in the documentation.
+
+	cmt0: timer at ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0x60>;
+	};
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 4d00e4b..3a27ce3 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -122,6 +123,7 @@ struct sh_cmt_device {
 
 	struct sh_cmt_channel *channels;
 	unsigned int num_channels;
+	unsigned int hw_channels;
 
 	bool has_clockevent;
 	bool has_clocksource;
@@ -924,10 +926,35 @@ static int sh_cmt_map_memory(struct sh_cmt_device *cmt)
 	return 0;
 }
 
+static const struct platform_device_id sh_cmt_id_table[] = {
+	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
+	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
+	{ "sh-cmt-32-fast", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT_FAST] },
+	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
+	{ "sh-cmt-48-gen2", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT_GEN2] },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
+
+static const struct of_device_id sh_cmt_of_table[] = {
+	{ .compatible = "renesas,cmt-32", .data = &sh_cmt_info[SH_CMT_32BIT] },
+	{ .compatible = "renesas,cmt-32-fast", .data = &sh_cmt_info[SH_CMT_32BIT_FAST] },
+	{ .compatible = "renasas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
+	{ .compatible = "renesas,cmt-48-gen2", .data = &sh_cmt_info[SH_CMT_48BIT_GEN2] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
+
+static int sh_cmt_parse_dt(struct sh_cmt_device *cmt)
+{
+	struct device_node *np = cmt->pdev->dev.of_node;
+
+	return of_property_read_u32(np, "renesas,channels-mask",
+				    &cmt->hw_channels);
+}
+
 static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 {
-	struct sh_timer_config *cfg = pdev->dev.platform_data;
-	const struct platform_device_id *id = pdev->id_entry;
 	unsigned int mask;
 	unsigned int i;
 	int ret;
@@ -936,13 +963,26 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	cmt->pdev = pdev;
 	raw_spin_lock_init(&cmt->lock);
 
-	if (!cfg) {
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		const struct of_device_id *id;
+
+		id = of_match_node(sh_cmt_of_table, pdev->dev.of_node);
+		cmt->info = id->data;
+
+		ret = sh_cmt_parse_dt(cmt);
+		if (ret < 0)
+			return ret;
+	} else if (pdev->dev.platform_data) {
+		struct sh_timer_config *cfg = pdev->dev.platform_data;
+		const struct platform_device_id *id = pdev->id_entry;
+
+		cmt->info = (const struct sh_cmt_info *)id->driver_data;
+		cmt->hw_channels = cfg->channels_mask;
+	} else {
 		dev_err(&cmt->pdev->dev, "missing platform data\n");
 		return -ENXIO;
 	}
 
-	cmt->info = (const struct sh_cmt_info *)id->driver_data;
-
 	/* Get hold of clock. */
 	cmt->clk = clk_get(&cmt->pdev->dev, "fck");
 	if (IS_ERR(cmt->clk)) {
@@ -960,8 +1000,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 		goto err_clk_unprepare;
 
 	/* Allocate and setup the channels. */
-	cmt->num_channels = hweight8(cfg->channels_mask);
-
+	cmt->num_channels = hweight8(cmt->hw_channels);
 	cmt->channels = kzalloc(cmt->num_channels * sizeof(*cmt->channels),
 				GFP_KERNEL);
 	if (cmt->channels == NULL) {
@@ -973,7 +1012,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	 * Use the first channel as a clock event device and the second channel
 	 * as a clock source. If only one channel is available use it for both.
 	 */
-	for (i = 0, mask = cfg->channels_mask; i < cmt->num_channels; ++i) {
+	for (i = 0, mask = cmt->hw_channels; i < cmt->num_channels; ++i) {
 		unsigned int hwidx = ffs(mask) - 1;
 		bool clocksource = i == 1 || cmt->num_channels == 1;
 		bool clockevent = i == 0;
@@ -1044,21 +1083,12 @@ static int sh_cmt_remove(struct platform_device *pdev)
 	return -EBUSY; /* cannot unregister clockevent and clocksource */
 }
 
-static const struct platform_device_id sh_cmt_id_table[] = {
-	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
-	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
-	{ "sh-cmt-32-fast", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT_FAST] },
-	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
-	{ "sh-cmt-48-gen2", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT_GEN2] },
-	{ }
-};
-MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
-
 static struct platform_driver sh_cmt_device_driver = {
 	.probe		= sh_cmt_probe,
 	.remove		= sh_cmt_remove,
 	.driver		= {
 		.name	= "sh_cmt",
+		.of_match_table = of_match_ptr(sh_cmt_of_table),
 	},
 	.id_table	= sh_cmt_id_table,
 };
-- 
1.8.5.5
