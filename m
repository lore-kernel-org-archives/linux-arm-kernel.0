From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sun, 24 Mar 2013 15:45:30 +0100
Subject: [PATCH v2 2/2] ARM: Orion: add dbg_show function to gpio-orion driver
In-Reply-To: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
References: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1364136330-28193-3-git-send-email-simon.guinot@sequanux.org>
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

 arch/arm/plat-orion/gpio.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index c29ee7e..e39c2ba 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -439,6 +439,64 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	}
 }
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/seq_file.h>
+
+static void orion_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
+	u32 out, io_conf, blink, in_pol, data_in, cause, edg_msk, lvl_msk;
+	int i;
+
+	out	= readl_relaxed(GPIO_OUT(ochip));
+	io_conf	= readl_relaxed(GPIO_IO_CONF(ochip));
+	blink	= readl_relaxed(GPIO_BLINK_EN(ochip));
+	in_pol	= readl_relaxed(GPIO_IN_POL(ochip));
+	data_in	= readl_relaxed(GPIO_DATA_IN(ochip));
+	cause	= readl_relaxed(GPIO_EDGE_CAUSE(ochip));
+	edg_msk	= readl_relaxed(GPIO_EDGE_MASK(ochip));
+	lvl_msk	= readl_relaxed(GPIO_LEVEL_MASK(ochip));
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
+#define orion_gpio_dbg_show NULL
+#endif
+
 void __init orion_gpio_init(struct device_node *np,
 			    int gpio_base, int ngpio,
 			    void __iomem *base, int mask_offset,
@@ -471,6 +529,7 @@ void __init orion_gpio_init(struct device_node *np,
 #ifdef CONFIG_OF
 	ochip->chip.of_node = np;
 #endif
+	ochip->chip.dbg_show = orion_gpio_dbg_show;
 
 	spin_lock_init(&ochip->lock);
 	ochip->base = (void __iomem *)base;
-- 
1.7.10.4
