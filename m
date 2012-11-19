From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:15 +0900
Subject: [RFC 03/15] ARM: mach-shmobile: Add support OF of INTC for r8a7740
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
Message-ID: <1353302007-31045-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This CPU has three interrupt controllers (INTCA, INTCS and INTCA IRQ pins).
This supports these.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v2 [Simon Horman]
* Use #ifdef instead of #if defined
* Use CONFIG_OF in place of CONFIG_OF_SH_INTC
* Allow OF and non OF code to be compiled in the same binary and
  provide r8a7740_init_irq_of() as a way to initialise INTC
  using DT while r8a7740_init_irq() still initialises INTC
  using the previous code paths. This is because we would
  like to be able to use a single configuration to compile a kernel
  for multiple boards and not all r8a7740 boards have DT support yet.

v1 [Nobuhiro Iwamatsu]
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-r8a7740.c        |  136 +++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d47e215..8402b5d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -59,6 +59,7 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
+extern void r8a7740_init_irq_of(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 9a69a31..878fdc6 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -1,8 +1,9 @@
 /*
  * R8A7740 processor support
  *
- * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011, 2012  Renesas Solutions Corp.
  * Copyright (C) 2011  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu@renesas.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,6 +30,105 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#ifdef CONFIG_OF
+
+static struct intc_desc intca_desc __initdata;
+static struct resource intca_resources[2] __initdata;
+static struct intc_desc intcs_desc __initdata;
+static struct resource intcs_resources[2] __initdata;
+static struct intc_desc intca_irq_pins_desc __initdata;
+static struct resource intca_pins_resources[1] __initdata;
+static unsigned short intevtsa_vect;
+
+static int r8a7740_intca_of_init(struct device_node *np,
+			struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np,
+				intca_resources, ARRAY_SIZE(intcs_resources));
+	if (ret)
+		goto error;
+
+	intca_desc.resource = intca_resources;
+	intca_desc.num_resources = ARRAY_SIZE(intca_resources);
+
+	ret = of_sh_intc_get_intc(np, &intca_desc);
+	if (ret)
+		goto error;
+
+	intca_desc.name = "r8a7740-intca";
+error:
+	return ret;
+}
+
+static int r8a7740_intcs_of_init(struct device_node *np,
+			struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np,
+				intcs_resources, ARRAY_SIZE(intcs_resources));
+	if (ret)
+		goto error;
+
+	intcs_desc.resource = intcs_resources;
+	intcs_desc.num_resources = ARRAY_SIZE(intcs_resources);
+
+	ret = of_sh_intc_get_intc(np, &intcs_desc);
+	if (ret)
+		goto error;
+
+	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
+
+	intcs_desc.name = "r8a7740-intcs";
+
+error:
+	return ret;
+}
+
+static int r8a7740_intca_pins_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intca_pins_resources,
+			ARRAY_SIZE(intca_pins_resources));
+	if (ret)
+		goto error;
+
+	intca_irq_pins_desc.resource = intca_pins_resources;
+	intca_irq_pins_desc.num_resources = ARRAY_SIZE(intca_pins_resources);
+
+	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_desc);
+	if (ret)
+		goto error;
+
+	intca_irq_pins_desc.name = "r8a7740-intca-irq-pins";
+
+error:
+	return ret;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh_intcs", .data = r8a7740_intcs_of_init },
+	{ .compatible = "renesas,sh_intca_irq_pins",
+		.data = r8a7740_intca_pins_of_init },
+	{ .compatible = "renesas,sh_intca", .data = r8a7740_intca_of_init },
+	{ /*sentinel*/ }
+};
+
+#endif /* CONFIG_OF */
+
 /*
  *		INTCA
  */
@@ -623,15 +723,41 @@ static void intcs_demux(unsigned int irq, struct irq_desc *desc)
 	generic_handle_irq(intcs_evt2irq(evtcodeas));
 }
 
-void __init r8a7740_init_irq(void)
+static void __init r8a7740_init_irq__(bool of)
 {
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+	void __iomem *intevtsa;
+
+#ifdef CONFIG_OF
+	if (of)
+		of_irq_init(irq_of_match);
+#endif
 
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intcs_desc);
 
 	/* demux using INTEVTSA */
-	irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
-	irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
+	intevtsa = ioremap_nocache(intcs_resources[0].start + 0x100, PAGE_SIZE);
+#ifdef CONFIG_OF
+	if (of) {
+		irq_set_handler_data(evt2irq(intevtsa_vect), (void *)intevtsa);
+		irq_set_chained_handler(evt2irq(intevtsa_vect), intcs_demux);
+	} else
+#endif
+	{
+		irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
+		irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
+	}
+}
+
+#ifdef CONFIG_OF
+void __init r8a7740_init_irq_of(void)
+{
+	r8a7740_init_irq__(true);
+}
+#endif
+
+void __init r8a7740_init_irq(void)
+{
+	r8a7740_init_irq__(false);
 }
-- 
1.7.10.4
