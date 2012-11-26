From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2012 09:16:51 +0900
Subject: [PATCH 4/7] ARM: shmobile: pfc-sh73a0: Register device tree
In-Reply-To: <1353889014-17142-1-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
Message-ID: <1353889014-17142-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the pfc with sh73a0_init_gpio_dt() to allow
gpios provided by pfc to be accessed by devices which
are registered using device tree.

The motivation of this is to allow the gpio used for carrier detect
but the Micro SD SDHI port of the KZM-9A-GT board to be accessed
using device tree. Thus, allowing the SDHI device of the KZM-9A-GT
board to be registered using device tree.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/pfc-sh73a0.c |   45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index b442f9d..d1a04c0b 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -2797,7 +2797,52 @@ static struct pinmux_info sh73a0_pinmux_info = {
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
+#ifdef CONFIG_OF_GPIO
+static int sh73a0_gpio_xlate(struct gpio_chip *gc,
+			     const struct of_phandle_args *gpiospec,
+			     u32 *flags)
+{
+	if (WARN_ON(gc->of_gpio_n_cells < 2))
+		return -EINVAL;
+
+	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
+		return -EINVAL;
+
+	if (gpiospec->args[0] > gc->ngpio)
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[1];
+
+	return gpiospec->args[0];
+}
+
+static const struct of_device_id sh73a0_gpio_dt_match[] __initdata = {
+	{ .compatible = "renesas,sh_pfc-sh73a0", },
+	{}
+};
+
+static inline void sh73a0_init_gpio_dt(void)
+{
+	struct device_node *of_node;
+
+	if (!of_have_populated_dt())
+		return;
+
+	of_node = of_find_matching_node(NULL, sh73a0_gpio_dt_match);
+	sh73a0_pinmux_info.of_node = of_node;
+	sh73a0_pinmux_info.of_gpio_n_cells = 2;
+	sh73a0_pinmux_info.of_xlate = sh73a0_gpio_xlate;
+}
+
+#else
+
+static inline void sh73a0_init_gpio_dt(void) {}
+
+#endif
+
 void sh73a0_pinmux_init(void)
 {
+	sh73a0_init_gpio_dt();
 	register_pinmux(&sh73a0_pinmux_info);
 }
-- 
1.7.10.4
