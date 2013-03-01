From: hechtb@gmail.com (Bastian Hecht)
Date: Fri,  1 Mar 2013 11:45:30 -0600
Subject: [PATCH 1/3] clocksource: sh_cmt: Add Device Tree probing
In-Reply-To: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We add the capabilty to probe SH CMT timer devices using Device Tree
setup.

We can deduce former platform data by the device IDs and channel
IDs of our timer instances, so we choose this more intuitive info as our
DT properties.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 .../bindings/timer/renesas,sh-cmt-timer.txt        |   21 +++++
 drivers/clocksource/sh_cmt.c                       |   94 +++++++++++++++++---
 2 files changed, 102 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
new file mode 100644
index 0000000..e5ad808
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
@@ -0,0 +1,21 @@
+* Renesas SH Mobile Compare Match Timer
+
+Required properties:
+- compatible : Should be "renesas,cmt"
+- reg : Address and length of the register set for the device
+- interrupts : Timer IRQ
+- renesas,timer-device-id : The ID of the timer device
+- renesas,timer-channel-id : The channel ID of the timer device
+
+Example for CMT10 of the R8A7740 SoC:
+
+	cmt at 0xe6138010 {
+		compatible = "renesas,cmt";
+		interrupt-parent = <&intca>;
+		reg = <0xe6138010 0xc>;
+		interrupts = <0x0b00>;
+		renesas,timer-device-id = <1>;
+		renesas,timer-channel-id = <0>;
+		renesas,clocksource-rating = <150>;
+		renesas,clockevent-rating = <150>;
+	};
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b72b724..9a7a7d4 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -38,6 +38,8 @@
 struct sh_cmt_priv {
 	void __iomem *mapbase;
 	struct clk *clk;
+	long channel_offset;
+	int timer_bit;
 	unsigned long width; /* 16 or 32 bit version of hardware block */
 	unsigned long overflow_bit;
 	unsigned long clear_bits;
@@ -109,9 +111,7 @@ static void sh_cmt_write32(void __iomem *base, unsigned long offs,
 
 static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_priv *p)
 {
-	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
-
-	return p->read_control(p->mapbase - cfg->channel_offset, 0);
+	return p->read_control(p->mapbase - p->channel_offset, 0);
 }
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
@@ -127,9 +127,7 @@ static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
 static inline void sh_cmt_write_cmstr(struct sh_cmt_priv *p,
 				      unsigned long value)
 {
-	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
-
-	p->write_control(p->mapbase - cfg->channel_offset, 0, value);
+	p->write_control(p->mapbase - p->channel_offset, 0, value);
 }
 
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
@@ -176,7 +174,6 @@ static DEFINE_RAW_SPINLOCK(sh_cmt_lock);
 
 static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
 {
-	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 	unsigned long flags, value;
 
 	/* start stop register shared by multiple timer channels */
@@ -184,9 +181,9 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
 	value = sh_cmt_read_cmstr(p);
 
 	if (start)
-		value |= 1 << cfg->timer_bit;
+		value |= 1 << p->timer_bit;
 	else
-		value &= ~(1 << cfg->timer_bit);
+		value &= ~(1 << p->timer_bit);
 
 	sh_cmt_write_cmstr(p, value);
 	raw_spin_unlock_irqrestore(&sh_cmt_lock, flags);
@@ -673,9 +670,71 @@ static int sh_cmt_register(struct sh_cmt_priv *p, char *name,
 	return 0;
 }
 
-static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
+#ifdef CONFIG_OF
+static const struct of_device_id of_sh_cmt_match[] = {
+	{ .compatible = "renesas,cmt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_sh_cmt_match);
+
+static const int sh_timer_offset_multiplier[] = { 0x60, 0x10, 0x40, 0x40 };
+
+static struct sh_timer_config *sh_cmt_parse_dt(struct device *dev)
+{
+	struct sh_timer_config *cfg;
+	struct device_node *np = dev->of_node;
+	const __be32 *prop;
+	int timer_id, channel_id;
+
+	cfg = devm_kzalloc(dev, sizeof(struct sh_timer_config), GFP_KERNEL);
+	if (!cfg) {
+		dev_err(dev, "failed to allocate DT config data\n");
+		return NULL;
+	}
+
+	prop = of_get_property(np, "renesas,timer-device-id", NULL);
+	if (!prop) {
+		dev_err(dev, "device id missing\n");
+		return NULL;
+	}
+	timer_id = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "renesas,timer-channel-id", NULL);
+	if (!prop) {
+		dev_err(dev, "channel id missing\n");
+		return NULL;
+	}
+	channel_id = be32_to_cpup(prop);
+
+	if (timer_id >= ARRAY_SIZE(sh_timer_offset_multiplier)) {
+		dev_err(dev, "unsupported timer id\n");
+		return NULL;
+	}
+
+	cfg->channel_offset = sh_timer_offset_multiplier[timer_id] *
+							(channel_id + 1);
+	cfg->timer_bit = channel_id;
+
+	prop = of_get_property(np, "renesas,clocksource-rating", NULL);
+	if (prop)
+		cfg->clocksource_rating = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "renesas,clockevent-rating", NULL);
+	if (prop)
+		cfg->clockevent_rating = be32_to_cpup(prop);
+
+	return cfg;
+}
+#else
+static struct sh_timer_config *sh_cmt_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
+static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev,
+						struct sh_timer_config *cfg)
 {
-	struct sh_timer_config *cfg = pdev->dev.platform_data;
 	struct resource *res;
 	int irq, ret;
 	ret = -ENXIO;
@@ -762,6 +821,9 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err2;
 	}
 
+	p->channel_offset = cfg->channel_offset;
+	p->timer_bit = cfg->timer_bit;
+
 	platform_set_drvdata(pdev, p);
 
 	return 0;
@@ -777,7 +839,7 @@ err0:
 static int sh_cmt_probe(struct platform_device *pdev)
 {
 	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
-	struct sh_timer_config *cfg = pdev->dev.platform_data;
+	struct sh_timer_config *cfg;
 	int ret;
 
 	if (!is_early_platform_device(pdev)) {
@@ -785,6 +847,11 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
+	if (pdev->dev.of_node)
+		cfg = sh_cmt_parse_dt(&pdev->dev);
+	else
+		cfg = pdev->dev.platform_data;
+
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");
 		goto out;
@@ -796,7 +863,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = sh_cmt_setup(p, pdev);
+	ret = sh_cmt_setup(p, pdev, cfg);
 	if (ret) {
 		kfree(p);
 		pm_runtime_idle(&pdev->dev);
@@ -824,6 +891,7 @@ static struct platform_driver sh_cmt_device_driver = {
 	.remove		= sh_cmt_remove,
 	.driver		= {
 		.name	= "sh_cmt",
+		.of_match_table = of_match_ptr(of_sh_cmt_match),
 	}
 };
 
-- 
1.7.9.5
