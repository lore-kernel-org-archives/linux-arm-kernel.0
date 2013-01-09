From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Jan 2013 15:30:01 +0900
Subject: [PATCH 2/8] ARM: shmobile: Add support OF of INTC for r8a7740
In-Reply-To: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1357713007-4005-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This CPU has three interrupt controllers (INTCA and INTCA IRQ pins).
This supports these.
NOTE: This supports DT of INTCA only.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v9
* Update compatible string to use '-' instead of '_'
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-r8a7740.c        |   70 +++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 5f2870e..d0a5790 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -46,6 +46,7 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
+extern void r8a7740_init_irq_of(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 9a69a31..46dca1f 100644
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
@@ -17,6 +18,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#define pr_fmt(fmt) "intc: " fmt
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -623,15 +625,71 @@ static void intcs_demux(unsigned int irq, struct irq_desc *desc)
 	generic_handle_irq(intcs_evt2irq(evtcodeas));
 }
 
-void __init r8a7740_init_irq(void)
+static void __init r8a7740_init_intc(resource_size_t intcs0_start,
+					unsigned short vect)
+{
+	void __iomem *intevtsa;
+
+	/* demux using INTEVTSA */
+	intevtsa = ioremap_nocache(intcs0_start + 0x100, PAGE_SIZE);
+	irq_set_handler_data(evt2irq(vect), (void *)intevtsa);
+	irq_set_chained_handler(evt2irq(vect), intcs_demux);
+}
+
+#ifdef CONFIG_OF
+static unsigned short intevtsa_vect;
+
+#define INTC_RES_MAX 2
+static struct {
+	struct intc_desc intc_desc;
+	struct resource intc_res[INTC_RES_MAX];
+} intc_data __initdata;
+
+static int __init intc_of_init(struct device_node *np,
+	struct device_node *parent)
+{
+	int ret, i;
+
+	memset(&intc_data, 0, sizeof(intc_data));
+
+	for (i = 0; i < INTC_RES_MAX; i++) {
+		ret = of_address_to_resource(np, i, &intc_data.intc_res[i]);
+		if (ret < 0)
+			break;
+	}
+
+	intc_data.intc_desc.name = (char *)of_node_full_name(np);
+	intc_data.intc_desc.resource = intc_data.intc_res;
+	intc_data.intc_desc.num_resources = i;
+
+	ret = of_sh_intc_get_intc(np, &intc_data.intc_desc);
+	if (ret)
+		return ret;
+
+	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
+
+	register_intc_controller(&intc_data.intc_desc);
+	return 0;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh-intc", .data = intc_of_init },
+	{ /*sentinel*/ }
+};
+
+void __init r8a7740_init_irq_of(void)
 {
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+	of_irq_init(irq_of_match);
 
+	register_intc_controller(&intcs_desc);
+}
+#endif /* CONFIG_OF */
+
+void __init r8a7740_init_irq(void)
+{
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intcs_desc);
 
-	/* demux using INTEVTSA */
-	irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
-	irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
+	r8a7740_init_intc(0xffd20000, 0xf80);
 }
-- 
1.7.10.4
