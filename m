From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 18:03:36 +0900
Subject: [PATCH 02/10] SH: intc: Add support OF of IRQ
In-Reply-To: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355562224-29448-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Add information of device node to struct intc_desc.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v7
* Delete "renesas,sh_intcs" and "renesas,sh_intca_irq_pins" as compatible.
  Update their documentation.
* Remove of_sh_intc_get_meminfo() and of_sh_intc_get_pint and
  of_sh_intc_get_intc(). They are not used.

v2 - v6
* No change
---
 Documentation/devicetree/bindings/sh/intc.txt |   15 +----
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |   76 -------------------------
 include/linux/sh_intc.h                       |   29 +---------
 6 files changed, 9 insertions(+), 122 deletions(-)

diff --git a/Documentation/devicetree/bindings/sh/intc.txt b/Documentation/devicetree/bindings/sh/intc.txt
index ebb2398..04b7f73 100644
--- a/Documentation/devicetree/bindings/sh/intc.txt
+++ b/Documentation/devicetree/bindings/sh/intc.txt
@@ -7,10 +7,7 @@ is managed by DT, in order to maintain compatibility.
 
 Main node required properties:
 
-- compatible : should be one of:
-	"renesas,sh_intca"
-	"renesas,sh_intcs"
-	"renesas,sh_intca_irq_pins"
+- compatible : "renesas,sh_intc"
 
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells	: Set already 1.
@@ -100,18 +97,10 @@ Optional:
 	This node required properties:
 	  * vector : This specifies the address phandle of INTCS.
 
-Note:
-- "renesas,sh_intca" needs group_size, intc_group*, intc_vectors,
-  intc_mask_registers and intc_prio_registers.
-- "renesas,sh_intcs" needs group_size, intc_group*, intc_vectors,
-  intc_mask_registers, intc_prio_registers and  intc_intevtsa.
-- "renesas,sh_intca_irq_pins" needs intc_vectors, intc_mask_registers,
-  intc_prio_registers, intc_sense_registers and intc_ack_registers.
-
 Example:
 
 	intca: interrupt-controller at 0 {
-		compatible = "renesas,sh_intca";
+		compatible = "renesas,sh_intc";
 		interrupt-controller;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8f32a13..3963af3 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -311,7 +311,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
 
-	intc_irq_domain_init(d, hw);
+	intc_irq_domain_init(d, hw, desc->of_node);
 
 	/* register the vectors one by one */
 	for (i = 0; i < hw->nr_vectors; i++) {
diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index 7dff08e..e6f64bf 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -190,7 +190,8 @@ void intc_enable_disable_enum(struct intc_desc *desc, struct intc_desc_int *d,
 			      intc_enum enum_id, int enable);
 
 /* irqdomain.c */
-void intc_irq_domain_init(struct intc_desc_int *d, struct intc_hw_desc *hw);
+void intc_irq_domain_init(struct intc_desc_int *d, struct intc_hw_desc *hw,
+				struct device_node *of_node);
 
 /* virq.c */
 void intc_subgroup_init(struct intc_desc *desc, struct intc_desc_int *d);
diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c..c56c736 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -42,7 +42,7 @@ static const struct irq_domain_ops intc_evt_ops = {
 };
 
 void __init intc_irq_domain_init(struct intc_desc_int *d,
-				 struct intc_hw_desc *hw)
+			 struct intc_hw_desc *hw, struct device_node *np)
 {
 	unsigned int irq_base, irq_end;
 
@@ -59,10 +59,10 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 	 * tree penalty for linear cases with non-zero hwirq bases.
 	 */
 	if (irq_base == 0 && irq_end == (irq_base + hw->nr_vectors - 1))
-		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
+		d->domain = irq_domain_add_linear(np, hw->nr_vectors,
 						  &intc_evt_ops, NULL);
 	else
-		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
+		d->domain = irq_domain_add_tree(np, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
 }
diff --git a/drivers/sh/intc/of_intc.c b/drivers/sh/intc/of_intc.c
index 04b0732..8a466f7 100644
--- a/drivers/sh/intc/of_intc.c
+++ b/drivers/sh/intc/of_intc.c
@@ -530,49 +530,6 @@ void __init of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
 		d->skip_syscore_suspend = false;
 }
 
-int __init of_sh_intc_get_meminfo(struct device_node *np,
-				struct resource *res, int res_no)
-{
-	int ret = 0, i;
-
-	for (i = 0 ; i < res_no ; i++) {
-		ret = of_address_to_resource(np, i, &res[i]);
-		if (ret) {
-			pr_err("could not determine device base address\n");
-			return ret;
-		}
-
-		pr_debug("%s: Address 0x%x, size %d\n",
-			__func__, res[i].start, resource_size(&res[i]));
-	}
-
-	return ret;
-}
-
-int __init of_sh_intc_get_pint(struct device_node *np, struct intc_desc *d)
-{
-	/* pint uses vector, mask and sence. */
-	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
-				&d->hw.nr_vectors);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
-				&d->hw.nr_mask_regs);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
-				&d->hw.nr_sense_regs);
-	/* INTC may not need Sence register. */
-	if (ret && ret != -ENOENT)
-		return ret;
-
-	d->of_node = np;
-
-	return 0;
-}
-
 int __init of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d)
 {
 	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
@@ -612,36 +569,3 @@ int __init of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d)
 
 	return 0;
 }
-
-int __init of_sh_intc_get_intc_pins(struct device_node *np,
-				struct intc_desc *d)
-{
-	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
-				&d->hw.nr_vectors);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
-				&d->hw.nr_mask_regs);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_prio(np, &d->hw.prio_regs,
-				&d->hw.nr_prio_regs);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
-				&d->hw.nr_sense_regs);
-	if (ret)
-		return ret;
-
-	ret = of_sh_intc_get_ack(np, &d->hw.ack_regs,
-				&d->hw.nr_ack_regs);
-	if (ret)
-		return ret;
-
-	d->of_node = np;
-
-	return 0;
-}
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index b0e7925..c7954ee 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -118,6 +118,7 @@ struct intc_desc {
 	intc_enum force_disable;
 	bool skip_syscore_suspend;
 	struct intc_hw_desc hw;
+	struct device_node *of_node;
 };
 
 #define DECLARE_INTC_DESC(symbol, chipname, vectors, groups,		\
@@ -160,26 +161,6 @@ static inline int register_intc_userimask(unsigned long addr)
 int of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d);
 
 /*
- * of_sh_initc_get_intc_pins() - Get INTC Pins table.
- * @np:     device node to get INTC from
- * @d:      a pointer of intc pins table
- *
- * Return: one of the errno value on the error condition
- */
-int of_sh_intc_get_intc_pins(struct device_node *np, struct intc_desc *d);
-
-/*
- * of_sh_intc_get_meminfo() - Get and set INTC register of memory.
- * @np:     device node to get INTC from
- * @res_mem:   a pointer of resource
- * @res_no:  resource number
- *
- * Return: one of the errno value on the error condition
- */
-int of_sh_intc_get_meminfo(struct device_node *np,
-				struct resource *res_mem, int resno);
-
-/*
  * of_sh_intc_get_force_enable - Get and set force_enable vector in
  *                               struct intc_desc.
  * @np:  device node to get INTC from
@@ -220,13 +201,5 @@ void of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
  * Return: one of the errno value on the error condition
  */
 int of_sh_intc_get_intevtsa_vect(struct device_node *np, unsigned short *vect);
-/*
- * of_sh_initc_get_intc_pint() - Get INTC Pint table.
- * @np:     device node to get INTC from
- * @d:      a pointer of intc pint table
- *
- * Return: one of the errno value on the error condition
- */
-int of_sh_intc_get_pint(struct device_node *np, struct intc_desc *d);
 
 #endif /* __SH_INTC_H */
-- 
1.7.10.4
