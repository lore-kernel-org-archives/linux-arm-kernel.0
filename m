From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Dec 2012 09:46:05 +0900
Subject: [PATCH 1/9] SH: intc: Add support OF for INTC
In-Reply-To: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
References: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355791573-20281-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This provides OF support of SH/INTC.

The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
At the moment, SuperH does not have the plan corresponding to DT.
DT of SH/INTC has taken the form where the table data of the C
is managed by DT, in order to maintain compatibility.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v8
* Squash "SH: intc: Add support OF of IRQ" into this patch
* Change patch title from "ARM: shmobile: Add support OF for INTC of shmobile"
  to "SH: intc: Add support OF for INTC"

v7
* Delete "renesas,sh_intcs" and "renesas,sh_intca_irq_pins" as compatible.
  Update their documentation.
* Remove of_sh_intc_get_meminfo() and of_sh_intc_get_pint and
  of_sh_intc_get_intc(). They are not used.

v2 - v6
* No change
---
 Documentation/devicetree/bindings/sh/intc.txt |  152 +++++++
 drivers/sh/intc/Makefile                      |    1 +
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |  571 +++++++++++++++++++++++++
 include/linux/sh_intc.h                       |   56 +++
 7 files changed, 786 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
 create mode 100644 drivers/sh/intc/of_intc.c

diff --git a/Documentation/devicetree/bindings/sh/intc.txt b/Documentation/devicetree/bindings/sh/intc.txt
new file mode 100644
index 0000000..04b7f73
--- /dev/null
+++ b/Documentation/devicetree/bindings/sh/intc.txt
@@ -0,0 +1,152 @@
+* Renesas SuperH / SH-MOBILE Interrupt Controller
+
+The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
+At the moment, SuperH does not have the plan corresponding to DT.
+DT of SH/INTC has taken the form where the table data of the C
+is managed by DT, in order to maintain compatibility.
+
+Main node required properties:
+
+- compatible : "renesas,sh_intc"
+
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells	: Set already 1.
+- #address-cells	: Set already 1.
+- #size-cells	: Set already 1.
+- ranges        : Non value.
+- reg 			: Specifies base physical address(s) and size of the INTC
+				  registers.
+- intsrc*		: This sets up the vector for every device.
+
+- *_registers	: There are vector table, mask, priority, ack, and sense
+				  register in INTC.  In order to hold these data, it is
+				  necessary to set up the following contents.
+
+ -- intc_vectors: This needs to have vector_table.
+				  This specifies phandle which intsrc* defined.
+
+ -- intc_mask_registers	: This specifies the contents of the mask register.
+    This node required properties:
+	* address-cells	: Set already 1.
+	* size-cells 	: Set already 1.
+	* ranges		: Non value.
+	* intc_mask*	: This has regs and reginfo.
+	 ** reg	: This specifies the address of mask register. First specifies
+			  mask register, and 2nd specifies mask clear register.
+			  First cell is address, and 2nd sell is address size. 1 is 8bit.
+			  2 is 16bit, 4 is 32bit.
+	 ** reginfo: This specifies phandle of devices.
+
+ -- intc_prio_registers	: This sets up the contents of the priority register.
+    This node required properties:
+	* address-cells	: Set already 1.
+	* size-cells 	: Set already 1.
+	* ranges		: Non value.
+	* intc_prio*: This has regs and reginfo.
+	 ** reg	: This specifies the address of priority register. First specifies
+			  priority set register, and 2nd specifies priority clear register.
+			  If there is not priority clear register, specifies 0x00.
+			  First cell is address, and 2nd sell is address size. 1 is 8bit.
+			  2 is 16bit, 4 is 32bit.
+	 ** field-width : Bit size is specified for every device.
+	 ** reginfo: This specifies phandle of devices.
+
+ -- intc_sense_registers	: This sets up the contents of the sense register.
+    This node required properties:
+	* address-cells	: Set already 1.
+	* size-cells 	: Set already 1.
+	* ranges		: Non value.
+	* intc_sense*: This has regs and reginfo.
+	 ** reg	: This specifies the address of sense register.
+			  First cell is address, and 2nd sell is address size. 1 is 8bit.
+			  2 is 16bit, 4 is 32bit.
+	 ** field-width : Bit size is specified for every device.
+	 ** reginfo: This specifies phandle of devices.
+
+-- intc_ack_registers	: This sets up the contents of the ACK register.
+   This node required properties:
+	* address-cells	: Set already 1.
+	* size-cells 	: Set already 1.
+	* ranges		: Non value.
+	* intc_ack*: This has regs and reginfo.
+	 ** reg	: This specifies the address of ack register.
+			  First cell is address, and 2nd sell is address size. 1 is 8bit.
+			  2 is 16bit, 4 is 32bit.
+	 ** reginfo: This specifies phandle of devices.
+
+Optional:
+
+- group_size	: If this INTC register has Group, set up this value.
+- intc_group*	: This needs to have group, If INTC device have group.
+   This node required properties:
+    * group : This specifies the address phandle of group.
+	  For example, when TMU1 of priority regisdter is sharing with TMU1_0,
+	  TMU1_1 and TMU1_2, it describes like below.
+
+	     TMU1:   intc_group2 { group = <&TMU1_0 &TMU1_1 &TMU1_2>; };
+
+	  And the phandle is specified as priority regisdter.
+
+         intc_prio11 {
+             reg = <0xffd50030 2>, <0x0 0>;
+             field-width = <4>;
+			 reginfo = <&TMU1 0 0 0>;
+		 };
+
+- intc_intevtsa	: This set up the contents of INTEVTSA.
+	This node required properties:
+	  * vector : This specifies the address phandle of INTCS.
+
+Example:
+
+	intca: interrupt-controller at 0 {
+		compatible = "renesas,sh_intc";
+		interrupt-controller;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		ranges;
+
+		reg = <0xe6940000 0x200>, <0xe6950000 0x200>;
+		group_size = <19>;
+
+		DIRC: intsrc1 { vector = <0x0560>; };
+		ATAPI: intsrc2 { vector = <0x05E0>; };
+		....
+
+		DMAC1_1: intc_group0 { group = <&DMAC1_1_DEI0 &DMAC1_1_DEI1
+				&DMAC1_1_DEI2 &DMAC1_1_DEI3>; };
+		DMAC1_2: intc_group1 { group = <&DMAC1_2_DEI4 &DMAC1_2_DEI5
+						 &DMAC1_2_DADERR>; };
+		....
+		intc_vectors {
+			vector_table = <&DIRC &ATAPI &IIC1_ALI &IIC1_TACKI &IIC1_WAITI,
+		....
+		};
+
+		intc_mask_registers {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			intc_mask0 {
+				reg = <0xe6940080 1>, <0xe69400c0 1>;
+				reginfo = <&DMAC2_1_DEI3 &DMAC2_1_DEI2 &DMAC2_1_DEI1
+					&DMAC2_1_DEI0 0 0 &AP_ARM_COMMTX &AP_ARM_COMMRX>;
+			};
+			....
+		};
+
+		intc_prio_registers {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			intc_prio0 {
+				reg = <0xe6940000 2>, <0x0 0>;
+				field-width = <4>;
+				reginfo = <&DMAC3_1 &DMAC3_2 &CMT2 &ICBS0>;
+			};
+			....
+		};
+	};
diff --git a/drivers/sh/intc/Makefile b/drivers/sh/intc/Makefile
index 54ec2a0..b53ab7e 100644
--- a/drivers/sh/intc/Makefile
+++ b/drivers/sh/intc/Makefile
@@ -3,3 +3,4 @@ obj-y 	:= access.o chip.o core.o handle.o irqdomain.o virq.o
 obj-$(CONFIG_INTC_BALANCING)		+= balancing.o
 obj-$(CONFIG_INTC_USERIMASK)		+= userimask.o
 obj-$(CONFIG_INTC_MAPPING_DEBUG)	+= virq-debugfs.o
+obj-$(CONFIG_OF)			+= of_intc.o
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
new file mode 100644
index 0000000..8a466f7
--- /dev/null
+++ b/drivers/sh/intc/of_intc.c
@@ -0,0 +1,571 @@
+/*
+ * OF helpers for SH intc
+ *
+ * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/sh_intc.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+static void __init of_sh_intc_get_reg_addrs(struct device_node *np,
+				unsigned long *set_reg, unsigned long *clr_reg,
+				unsigned long *reg_width,
+				unsigned long *field_width)
+{
+	struct resource res;
+
+	if (set_reg) {
+		of_address_to_resource(np, 0, &res);
+		*set_reg = res.start;
+	}
+
+	if (resource_size(&res) && reg_width)
+		*reg_width = resource_size(&res) * 8; /* byte */
+
+	if (clr_reg) {
+		of_address_to_resource(np, 1, &res);
+		*clr_reg = res.start;
+	}
+
+	if (field_width) {
+		u32 width;
+		of_property_read_u32(np, "field-width", &width);
+		*field_width = width;
+	}
+}
+
+static int of_sh_intc_parse_vector(struct device_node *np, uint32_t *vect)
+{
+	return of_property_read_u32(np, "vector", vect);
+}
+
+static int of_sh_intc_parse_group(struct device_node *np,
+				struct intc_group *grp)
+{
+	const __be32 *list, *list_end;
+	int size, ret = 0, count = 0;
+	phandle phandle;
+
+	/* Retrieve the phandle list property */
+	list = of_get_property(np, "group", &size);
+	if (!list)
+		return -ENOENT;
+
+	list_end = list + size / sizeof(*list);
+
+	grp->enum_id = np->phandle;
+	/* Loop over the phandles until all the requested entry is found */
+	while (list < list_end) {
+		/* If phandle is 0, then it is an empty entry with
+		   no arguments. */
+		phandle = be32_to_cpup(list);
+		if (phandle)
+			grp->enum_ids[count] = phandle;
+		list++;
+		count++;
+	}
+
+	pr_debug("%d:[", grp->enum_id);
+	for (size = 0 ; size < count ; size++)
+		pr_debug(" %d ", grp->enum_ids[size]);
+
+	pr_debug("]\n");
+
+	return ret;
+}
+
+static int of_sh_intc_parse_vectortbl(struct device_node *np,
+				struct intc_vect **vect, int *tbl_size)
+{
+	const __be32 *list, *list_end;
+	int size, ret = 0, count = 0;
+	struct device_node *node = NULL;
+	phandle phandle;
+
+	/* Retrieve the phandle list property */
+	list = of_get_property(np, "vector_table", &size);
+	if (!list)
+		return -ENOENT;
+
+	*tbl_size = size / sizeof(*list);
+
+	pr_debug("vector table size: %d\n", *tbl_size);
+
+	*vect = kzalloc(sizeof(struct intc_vect) * *tbl_size,
+					GFP_KERNEL);
+	if (!*vect)
+		return -ENOMEM;
+
+	list_end = list + *tbl_size;
+
+	/* Loop over the phandles until all the requested entry is found */
+	while (list < list_end) {
+		/* If phandle is 0, then it is an empty entry with
+		   no arguments. */
+		phandle = be32_to_cpup(list);
+		if (phandle) {
+			uint32_t vector_id;
+
+			(*vect)[count].enum_id = phandle;
+			node = of_find_node_by_phandle(phandle);
+
+			ret = of_sh_intc_parse_vector(node, &vector_id);
+			if (ret)
+				return ret;
+
+			(*vect)[count].vect = vector_id;
+			pr_debug("id %d : vector 0x%x\n",
+				(*vect)[count].enum_id, (*vect)[count].vect);
+		} else {
+			ret = -EINVAL;
+			goto error;
+		}
+		list++;
+		count++;
+	}
+	return ret;
+
+error:
+	kfree(*vect);
+
+	return ret;
+}
+
+static int of_sh_intc_parse_reginfo(struct device_node *np,
+				struct intc_mask_reg *mask,
+				struct intc_prio_reg *prio,
+				struct intc_sense_reg *sense)
+{
+	const __be32 *list, *list_end;
+	int size, id, ret = 0, count = 0;
+	phandle phandle;
+
+	/* Retrieve the phandle list property */
+	list = of_get_property(np, "reginfo", &size);
+	if (!list)
+		return -ENOENT;
+
+	list_end = list + size / sizeof(*list);
+
+	/* Loop over the phandles until all the requested entry is found */
+	while (list < list_end) {
+		/* If phandle is 0, then it is an empty entry with
+		   no arguments. */
+		phandle = be32_to_cpup(list);
+		if (phandle)
+			id = phandle;
+		else
+			id = 0;
+
+		if (mask)
+			mask->enum_ids[count] = id;
+		if (prio)
+			prio->enum_ids[count] = id;
+		if (sense)
+			sense->enum_ids[count] = id;
+
+		pr_debug("reg: [%d] %d\n", count, id);
+		list++;
+		count++;
+	}
+
+	return ret;
+}
+
+static struct device_node *
+__init of_sh_intc_check_base_node(struct device_node *np,
+		const char *node_name, int *tbl_size)
+{
+	struct device_node *node;
+
+	node = of_find_node_by_name(np, node_name);
+	if (!node) {
+		pr_err("%s table not found\n", node_name);
+		return NULL;
+	}
+
+	pr_debug("%s\n", node->full_name);
+
+	*tbl_size = of_get_child_count(node);
+
+	pr_debug("Size of %s: %d\n", node_name, *tbl_size);
+
+	return node;
+}
+
+static int __init of_sh_intc_get_mask_ack(struct device_node *np,
+				struct intc_mask_reg **masks, int *tbl_size,
+				const char *base_name, const char *reg_name)
+{
+	struct device_node *intc_node, *reg_node;
+	int i, ret;
+	char node_name[13]; /* intc_mask + 999 */
+
+	intc_node = of_sh_intc_check_base_node(np, base_name, tbl_size);
+	if (!intc_node)
+		return -ENOENT;
+
+	*masks = kzalloc(sizeof(struct intc_mask_reg) * *tbl_size, GFP_KERNEL);
+	if (!*masks)
+		return -ENOMEM;
+
+	for (i = 0 ; i < *tbl_size; i++) {
+		memset(node_name, 0, sizeof(node_name));
+		snprintf(node_name, sizeof(node_name), "%s%d", reg_name, i);
+
+		pr_debug("intc node[%d]: name: %s\n", i, node_name);
+
+		reg_node = of_find_node_by_name(intc_node, node_name);
+		if (!reg_node) {
+			pr_warn("%s not found\n", node_name);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		of_sh_intc_get_reg_addrs(reg_node, &(*masks)[i].set_reg,
+					&(*masks)[i].clr_reg,
+					&(*masks)[i].reg_width, NULL);
+
+#ifdef CONFIG_INTC_BALANCING
+		of_property_read_u32(reg_node, "dist_reg",
+						&(*masks)[i].dist_reg);
+#endif
+#ifdef CONFIG_SMP
+		of_property_read_u32(reg_node, "smp",
+						(u32 *)&(*masks)[i].smp);
+#endif
+
+		pr_debug("set reg: 0x%lx clr reg: 0x%lx reg_width: %ld\n",
+				(*masks)[i].set_reg, (*masks)[i].clr_reg,
+				(*masks)[i].reg_width);
+
+		ret = of_sh_intc_parse_reginfo(reg_node, &(*masks)[i], NULL,
+						NULL);
+		if (ret)
+			goto error;
+	}
+
+	return ret;
+
+error:
+	kfree(*masks);
+	return ret;
+}
+
+static int __init of_sh_intc_get_vector(struct device_node *np,
+				struct intc_vect **vectors, int *tbl_size)
+{
+	struct device_node *intc_node;
+
+	/* Get INTCA vector register info */
+	intc_node = of_find_node_by_name(np, "intc_vectors");
+	if (!intc_node) {
+		pr_err("Get INTC vector table not found\n");
+		return -ENOENT;
+	}
+
+	return of_sh_intc_parse_vectortbl(intc_node, vectors, tbl_size);
+}
+
+static int __init of_sh_intc_get_prio(struct device_node *np,
+				struct intc_prio_reg **prios, int *tbl_size)
+{
+	struct device_node *intc_node, *reg_node;
+	int i, ret;
+	char node_name[13]; /* intc_prio + 999 */
+
+	intc_node = of_sh_intc_check_base_node(np, "intc_prio_registers",
+					tbl_size);
+	if (!intc_node)
+		return -ENOENT;
+
+	*prios = kzalloc(sizeof(struct intc_prio_reg) * *tbl_size, GFP_KERNEL);
+	if (!*prios)
+		return -ENOMEM;
+
+	/* Get INTC priority register info */
+	for (i = 0 ; i < *tbl_size; i++) {
+		memset(node_name, 0, sizeof(node_name));
+		snprintf(node_name, sizeof(node_name), "intc_prio%d", i);
+
+		pr_debug("INTC node name: %s\n", node_name);
+
+		reg_node = of_find_node_by_name(intc_node, node_name);
+
+		if (!intc_node) {
+			pr_err("INTC prio register not found\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		of_sh_intc_get_reg_addrs(reg_node, &(*prios)[i].set_reg,
+				&(*prios)[i].clr_reg, &(*prios)[i].reg_width,
+				&(*prios)[i].field_width);
+
+		pr_debug("\tset reg: 0x%lx clr reg: 0x%lx\n",
+				(*prios)[i].set_reg, (*prios)[i].clr_reg);
+		pr_debug("\treg_width: %ld field_width: %ld\n",
+				(*prios)[i].reg_width, (*prios)[i].field_width);
+
+		ret = of_sh_intc_parse_reginfo(reg_node, NULL, &(*prios)[i],
+						NULL);
+		if (ret)
+			goto error;
+	}
+
+	return ret;
+
+error:
+	kfree(*prios);
+	return ret;
+}
+
+static int __init of_sh_intc_get_sense(struct device_node *np,
+				struct intc_sense_reg **senses, int *tbl_size)
+{
+	struct device_node *intc_node, *reg_node;
+	int i, ret;
+	char node_name[14]; /* intc_sense + 999 */
+
+	intc_node = of_sh_intc_check_base_node(np, "intc_sense_registers",
+					tbl_size);
+	if (!intc_node)
+		return -ENOENT;
+
+	*senses = kzalloc(sizeof(struct intc_sense_reg) * *tbl_size,
+					GFP_KERNEL);
+	if (!*senses)
+		return -ENOMEM;
+
+	/* Get INTC priority register info */
+	for (i = 0 ; i < *tbl_size; i++) {
+		memset(node_name, 0, sizeof(node_name));
+		snprintf(node_name, sizeof(node_name), "intc_sense%d", i);
+
+		pr_debug("INTC node name: %s\n", node_name);
+
+		reg_node = of_find_node_by_name(intc_node, node_name);
+
+		if (!intc_node) {
+			pr_err("INTC senses register not found\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		of_sh_intc_get_reg_addrs(reg_node, &(*senses)[i].reg, NULL,
+					&(*senses)[i].reg_width,
+					&(*senses)[i].field_width);
+
+		pr_debug("\tset reg: 0x%lx\n", (*senses)[i].reg);
+		pr_debug("\treg_width: %ld field_width: %ld\n",
+					(*senses)[i].reg_width,
+					(*senses)[i].field_width);
+
+		ret = of_sh_intc_parse_reginfo(reg_node, NULL, NULL,
+						&(*senses)[i]);
+		if (ret)
+			goto error;
+	}
+
+	return ret;
+
+error:
+	kfree(*senses);
+	return ret;
+}
+
+static int __init of_sh_intc_get_ack(struct device_node *np,
+				struct intc_mask_reg **masks, int *tbl_size)
+{
+	return of_sh_intc_get_mask_ack(np, masks, tbl_size,
+					"intc_ack_registers", "intc_ack");
+}
+
+static int __init of_sh_intc_get_mask(struct device_node *np,
+				struct intc_mask_reg **masks, int *tbl_size)
+{
+	return of_sh_intc_get_mask_ack(np, masks, tbl_size,
+					"intc_mask_registers", "intc_mask");
+}
+
+static int __init of_sh_intc_get_group(struct device_node *np,
+				struct intc_group **groups, int *tbl_size)
+{
+	int i, ret, size;
+	const __be32 *list;
+	struct device_node *grp_node;
+	char node_name[15]; /* intc_group@999 */
+
+	/* Get size of group */
+	if (of_property_read_u32(np, "group_size", tbl_size)) {
+		pr_debug("%s size infomation not found\n", node_name);
+		return -ENOENT;
+	}
+
+	pr_debug("Group size %d\n", *tbl_size);
+	pr_debug("%s\n", np->full_name);
+
+	*groups = kzalloc(sizeof(struct intc_group) * *tbl_size, GFP_KERNEL);
+	if (!*groups)
+		return -ENOMEM;
+
+	/* Get INTCA node info */
+	for (i = 0 ; i < *tbl_size; i++) {
+		memset(node_name, 0, sizeof(node_name));
+		snprintf(node_name, sizeof(node_name), "intc_group%d", i);
+
+		pr_debug("intc group[%d]: name: %s\n", i, node_name);
+
+		grp_node = of_find_node_by_name(np, node_name);
+		if (!grp_node) {
+			pr_warn("%s not found\n", node_name);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		list = of_get_property(np, node_name, &size);
+		ret = of_sh_intc_parse_group(grp_node, &(*groups)[i]);
+		if (ret) {
+			pr_err("intc group not found\n");
+			goto error;
+		}
+	}
+
+	return ret;
+
+error:
+	kfree(*groups);
+	return ret;
+}
+
+int __init of_sh_intc_get_intevtsa_vect(struct device_node *np,
+				unsigned short *vect)
+{
+	int size;
+	const __be32 *list;
+	struct device_node *node;
+	phandle phandle;
+
+	node = of_find_node_by_name(np, "intc_intevtsa");
+	if (!node)
+		return -ENOENT;
+
+	/* Retrieve the phandle list property */
+	list = of_get_property(node, "vector", &size);
+	if (!list)
+		return -ENOENT;
+
+	phandle = be32_to_cpup(list);
+	if (phandle) {
+		uint32_t tmp;
+		struct device_node *vect_node =
+				of_find_node_by_phandle(phandle);
+
+		if (!of_sh_intc_parse_vector(vect_node, &tmp))
+			*vect = tmp;
+		else
+			return -ENOENT;
+	} else {
+		pr_debug("intc_intevtsa data not found\n");
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static int of_sh_intc_get_force_flags(struct device_node *np,
+				const char *node_name)
+{
+	int size;
+	const __be32 *list = of_get_property(np, node_name, &size);
+	if (list)
+		return be32_to_cpup(list);
+
+	return 0;
+}
+
+void __init of_sh_intc_get_force_enable(struct device_node *np,
+				struct intc_desc *d)
+{
+	d->force_enable =
+		of_sh_intc_get_force_flags(np, "force_enable");
+}
+
+void __init of_sh_intc_get_force_disable(struct device_node *np,
+				struct intc_desc *d)
+{
+	d->force_disable =
+		of_sh_intc_get_force_flags(np, "force_disable");
+}
+
+void __init of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
+				struct intc_desc *d)
+{
+	if (of_find_property(np, "skip_syscore_suspend", NULL))
+		d->skip_syscore_suspend = true;
+	else
+		d->skip_syscore_suspend = false;
+}
+
+int __init of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d)
+{
+	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
+				&d->hw.nr_vectors);
+	if (ret)
+		return ret;
+
+	ret = of_sh_intc_get_group(np, &d->hw.groups,
+				&d->hw.nr_groups);
+	/* INTC may not need groups. */
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
+				&d->hw.nr_mask_regs);
+	if (ret)
+		return ret;
+
+	ret = of_sh_intc_get_prio(np, &d->hw.prio_regs,
+				&d->hw.nr_prio_regs);
+	if (ret)
+		return ret;
+
+	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
+				&d->hw.nr_sense_regs);
+	/* INTC may not need Sense register. */
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	ret = of_sh_intc_get_ack(np, &d->hw.ack_regs,
+				&d->hw.nr_ack_regs);
+	/* INTC may not need Ack register. */
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	d->of_node = np;
+
+	return 0;
+}
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 3238328..c7954ee 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -2,6 +2,10 @@
 #define __SH_INTC_H
 
 #include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
 
 #ifdef CONFIG_SUPERH
 #define INTC_NR_IRQS	512
@@ -114,6 +118,7 @@ struct intc_desc {
 	intc_enum force_disable;
 	bool skip_syscore_suspend;
 	struct intc_hw_desc hw;
+	struct device_node *of_node;
 };
 
 #define DECLARE_INTC_DESC(symbol, chipname, vectors, groups,		\
@@ -146,4 +151,55 @@ static inline int register_intc_userimask(unsigned long addr)
 }
 #endif
 
+/*
+ * of_sh_initc_get_intc() - Get INTC table.
+ * @np:     device node to get INTC from
+ * @d:      a pointer of intc table
+ *
+ * Return: one of the errno value on the error condition
+ */
+int of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d);
+
+/*
+ * of_sh_intc_get_force_enable - Get and set force_enable vector in
+ *                               struct intc_desc.
+ * @np:  device node to get INTC from
+ * @d:   a pointer of struct intc_desc
+ *
+ * Return: none
+ */
+void of_sh_intc_get_force_enable(struct device_node *np,
+				struct intc_desc *d);
+
+/*
+ * of_sh_intc_get_force_disable - Get and set force_disable vector in
+ *                                struct intc_desc.
+ * @np:  device node to get INTC from
+ * @d:   a pointer of struct intc_desc
+ *
+ * Return: none
+ */
+void of_sh_intc_get_force_disable(struct device_node *np,
+				struct intc_desc *d);
+
+/*
+ * of_sh_intc_get_skip_syscore_suspend - Get and set skip_syscore_suspend
+ *                                       flag in struct intc_desc.
+ * @np:  device node to get INTC from
+ * @d:   a pointer of struct intc_desc
+ *
+ * Return: none
+ */
+void of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
+				struct intc_desc *d);
+
+/*
+ * of_sh_intc_get_intevtsa_vect  - Get using vector by intevtsa
+ * @np:  device node to get INTC from
+ * @vect:a pointer of value for vector
+ *
+ * Return: one of the errno value on the error condition
+ */
+int of_sh_intc_get_intevtsa_vect(struct device_node *np, unsigned short *vect);
+
 #endif /* __SH_INTC_H */
-- 
1.7.10.4
