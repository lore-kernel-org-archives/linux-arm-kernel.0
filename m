From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:39 +0100
Subject: [PATCH V3 12/15] ASoC: samsung: i2s: Add clock provider for the I2S
 internal clocks
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-13-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock provider (currently only for DT platforms) for
the CODECLKO (CDCLK) gate, RCLKSRC mux and RCLK pre-scaler divider
divider clock. Those all tree clock are only available in the IIS
Multi Audio Interface (I2S0), the regular IIS Bus Interface has only
CDCLK gate clock.

The motivation behind this patch is to expose the I2S internal clocks
which are currently controlled through set_sysclk() through the clk
API, so dedicated sound machine driver per each board can be avoided.

The intention is also to fix the CDCLK gating issue reported by
Daniel Drake:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081753.html

This patch also reverts commit b97c60abf9a561f86ae71bd741add02673cc1
("ASoC: samsung-i2s: Maintain CDCLK settings across i2s_{shutdown/
startup}") The problem that commit attempted to solve only affects
the Odroid X2/U3, which doesn't configure the CDCLK clock in
struct snd_soc_dai_ops hw_params callback and the issue should be
now resolved by using clk API, i.e. having the codec enabling/
disabling the CDCLK clock as required.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |  113 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 20 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 05fc2f0..b92ab40 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -10,9 +10,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/sound/samsung-i2s.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -81,8 +83,6 @@ struct i2s_dai {
 #define DAI_OPENED	(1 << 0) /* Dai is opened */
 #define DAI_MANAGER	(1 << 1) /* Dai is the manager */
 	unsigned mode;
-	/* CDCLK pin direction: 0  - input, 1 - output */
-	unsigned int cdclk_out:1;
 	/* Driver for this DAI */
 	struct snd_soc_dai_driver i2s_dai_drv;
 	/* DMA parameters */
@@ -98,6 +98,10 @@ struct i2s_dai {
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t spinlock;
 	spinlock_t *lock;
+
+	/* Below fields are only valid if this is the primary FIFO */
+	struct clk *clk_table[3];
+	struct clk_onecell_data clk_data;
 };
 
 /* Lock for cross i/f checks */
@@ -774,9 +778,6 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 
 	spin_unlock_irqrestore(&lock, flags);
 
-	if (!is_opened(other) && i2s->cdclk_out)
-		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
-				0, SND_SOC_CLOCK_OUT);
 	return 0;
 }
 
@@ -786,31 +787,20 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
-	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
 	spin_lock_irqsave(&lock, flags);
 
 	i2s->mode &= ~DAI_OPENED;
 	i2s->mode &= ~DAI_MANAGER;
 
-	if (is_opened(other)) {
+	if (is_opened(other))
 		other->mode |= DAI_MANAGER;
-	} else {
-		u32 mod = readl(i2s->addr + I2SMOD);
-		i2s->cdclk_out = !(mod & (1 << i2s_regs->cdclkcon_off));
-		if (other)
-			other->cdclk_out = i2s->cdclk_out;
-	}
+
 	/* Reset any constraint on RFS and BFS */
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 
 	spin_unlock_irqrestore(&lock, flags);
-
-	/* Gate CDCLK by default */
-	if (!is_opened(other))
-		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
-				0, SND_SOC_CLOCK_IN);
 }
 
 static int config_setup(struct i2s_dai *i2s)
@@ -1147,6 +1137,87 @@ static int i2s_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+static void i2s_unregister_clocks(struct i2s_dai *i2s)
+{
+	int i;
+
+	for (i = 0; i < i2s->clk_data.clk_num; i++) {
+		if (!IS_ERR(i2s->clk_table[i]))
+			clk_unregister(i2s->clk_table[i]);
+	}
+}
+
+static void i2s_unregister_clock_provider(struct platform_device *pdev)
+{
+	struct i2s_dai *i2s = dev_get_drvdata(&pdev->dev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	i2s_unregister_clocks(i2s);
+}
+
+static int i2s_register_clock_provider(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
+	const char *p_names[2] = { NULL };
+	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	struct clk *rclksrc;
+	int ret, i;
+
+	/* Register the clock provider only if it's expected in the DTB */
+	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
+		return 0;
+
+	/* Get the RCLKSRC mux clock parent clock names */
+	for (i = 0; i < ARRAY_SIZE(p_names); i++) {
+		rclksrc = clk_get(dev, clk_name[i]);
+		if (IS_ERR(rclksrc))
+			continue;
+		p_names[i] = __clk_get_name(rclksrc);
+		clk_put(rclksrc);
+	}
+
+	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		/* Activate the prescaler */
+		u32 val = readl(i2s->addr + I2SPSR);
+		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
+
+		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(NULL,
+				"i2s_rclksrc", p_names, ARRAY_SIZE(p_names),
+				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+				i2s->addr + I2SMOD, reg_info->rclksrc_off,
+				1, 0, i2s->lock);
+
+		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(NULL,
+				"i2s_presc", "i2s_rclksrc",
+				CLK_SET_RATE_PARENT,
+				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
+
+		p_names[0] = "i2s_presc";
+		i2s->clk_data.clk_num = 2;
+	}
+	of_property_read_string_index(dev->of_node,
+				"clock-output-names", 0, &clk_name[0]);
+
+	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(NULL, clk_name[0],
+				p_names[0], CLK_SET_RATE_PARENT,
+				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
+				CLK_GATE_SET_TO_DISABLE, i2s->lock);
+
+	i2s->clk_data.clk_num += 1;
+	i2s->clk_data.clks = i2s->clk_table;
+
+	ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
+				  &i2s->clk_data);
+	if (ret < 0) {
+		dev_err(dev, "failed to add clock provider: %d\n", ret);
+		i2s_unregister_clocks(i2s);
+	}
+
+	return ret;
+}
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1297,7 +1368,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret != 0)
 		return ret;
 
-	return 0;
+	return i2s_register_clock_provider(pdev);
 }
 
 static int samsung_i2s_remove(struct platform_device *pdev)
@@ -1314,8 +1385,10 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 	}
 
-	if (!is_secondary(i2s))
+	if (!is_secondary(i2s)) {
+		i2s_unregister_clock_provider(pdev);
 		clk_disable_unprepare(i2s->clk);
+	}
 
 	i2s->pri_dai = NULL;
 	i2s->sec_dai = NULL;
-- 
1.7.9.5
