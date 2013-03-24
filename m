From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sun, 24 Mar 2013 15:45:29 +0100
Subject: [PATCH v2 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
References: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1364136330-28193-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a dedicated dbg_show function to the gpio-mvebu driver.
In addition to the generic gpiolib informations, this function displays
informations related with the specific Marvell registers (blink enable,
data in polarity, interrupt masks and cause).

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
Changes for v2:
 - In order to match registers type, swith msk type to u32.

 drivers/gpio/gpio-mvebu.c |   59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 61a6fde..3bd0398 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -470,6 +470,64 @@ static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/seq_file.h>
+
+static void mvebu_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	u32 out, io_conf, blink, in_pol, data_in, cause, edg_msk, lvl_msk;
+	int i;
+
+	out	= readl_relaxed(mvebu_gpioreg_out(mvchip));
+	io_conf	= readl_relaxed(mvebu_gpioreg_io_conf(mvchip));
+	blink	= readl_relaxed(mvebu_gpioreg_blink(mvchip));
+	in_pol	= readl_relaxed(mvebu_gpioreg_in_pol(mvchip));
+	data_in	= readl_relaxed(mvebu_gpioreg_data_in(mvchip));
+	cause	= readl_relaxed(mvebu_gpioreg_edge_cause(mvchip));
+	edg_msk	= readl_relaxed(mvebu_gpioreg_edge_mask(mvchip));
+	lvl_msk	= readl_relaxed(mvebu_gpioreg_level_mask(mvchip));
+
+	for (i = 0; i < chip->ngpio; i++) {
+		const char *label;
+		u32 msk;
+		bool is_out;
+
+		label = gpiochip_is_requested(chip, i);
+		if (!label)
+			continue;
+
+		msk = 1 << i;
+		is_out = !(io_conf & msk);
+
+		seq_printf(s, " gpio-%-3d (%-20.20s)", chip->base + i, label);
+
+		if (is_out) {
+			seq_printf(s, " out %s %s\n",
+				   out & msk ? "hi" : "lo",
+				   blink & msk ? "(blink )" : "");
+			continue;
+		}
+
+		seq_printf(s, " in  %s (act %s) - IRQ",
+			   (data_in ^ in_pol) & msk  ? "hi" : "lo",
+			   in_pol & msk ? "lo" : "hi");
+		if (!((edg_msk | lvl_msk) & msk)) {
+			seq_printf(s, " disabled\n");
+			continue;
+		}
+		if (edg_msk & msk)
+			seq_printf(s, " edge ");
+		if (lvl_msk & msk)
+			seq_printf(s, " level");
+		seq_printf(s, " (%s)\n", cause & msk ? "pending" : "clear  ");
+	}
+}
+#else
+#define mvebu_gpio_dbg_show NULL
+#endif
+
 static struct of_device_id mvebu_gpio_of_match[] = {
 	{
 		.compatible = "marvell,orion-gpio",
@@ -550,6 +608,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.ngpio = ngpios;
 	mvchip->chip.can_sleep = 0;
 	mvchip->chip.of_node = np;
+	mvchip->chip.dbg_show = mvebu_gpio_dbg_show;
 
 	spin_lock_init(&mvchip->lock);
 	mvchip->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
1.7.10.4
