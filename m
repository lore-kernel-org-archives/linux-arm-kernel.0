From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:27 +0200
Subject: [PATCH 13/23] AT91 DMA OF support
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-14-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/mach-at91/include/mach/at_hdmac.h |    1 +
 drivers/of/Kconfig                         |    4 +
 drivers/of/Makefile                        |    1 +
 drivers/of/of_atmel.c                      |  112 ++++++++++++++++++++++++++++
 include/linux/of_atmel.h                   |   29 +++++++
 5 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/of_atmel.c
 create mode 100644 include/linux/of_atmel.h

diff --git a/arch/arm/mach-at91/include/mach/at_hdmac.h b/arch/arm/mach-at91/include/mach/at_hdmac.h
index cab0997..35667bd 100644
--- a/arch/arm/mach-at91/include/mach/at_hdmac.h
+++ b/arch/arm/mach-at91/include/mach/at_hdmac.h
@@ -52,6 +52,7 @@ struct at_dma_slave {
 #define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
 #define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
 #define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
+#define	ATC_AHB_PROT(h)		(((h) <<  24) && ATC_AHB_PROT_MASK)
 #define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
 #define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
 #define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..4667960 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -83,4 +83,8 @@ config OF_MTD
 	depends on MTD
 	def_bool y
 
+config OF_ATMEL
+	depends on AT_HDMAC
+	def_bool y
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..897de3b 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
+obj-$(CONFIG_OF_ATMEL)	+= of_atmel.o
diff --git a/drivers/of/of_atmel.c b/drivers/of/of_atmel.c
new file mode 100644
index 0000000..bcd3c54a
--- /dev/null
+++ b/drivers/of/of_atmel.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2012 Richard Genoud, Paratronic S.A.
+ *                    <richard.genoud@gmail.com>
+ *
+ * Atmel specifics OF helpers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/printk.h>
+#include <linux/byteorder/generic.h>
+#include <mach/at_hdmac.h>
+#include <linux/of.h>
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+/**
+ * of_create_at_dma_slave - Alloc and initialize the struct at_dma_slave
+ * @np: pointer to node to create the struct for
+ * @bus: pointer to the bus type of the DMA device.
+ *
+ * Returns pointer to created DMA slave structure, or NULL in case of error.
+ */
+struct at_dma_slave *of_create_at_dma_slave(struct device_node *np,
+					    struct bus_type *bus)
+{
+	struct at_dma_slave *atslave;
+	struct device_node *n;
+	struct property *prop;
+	const __be32 *dma_list;
+	phandle phandle;
+	int size;
+	int err = -1;
+	u32 val;
+
+	atslave = kzalloc(sizeof(struct at_dma_slave), GFP_KERNEL);
+	if (unlikely(!atslave)) {
+		pr_err("cannot allocate memory\n");
+		goto error;
+	}
+
+	atslave->cfg |= of_property_read_bool(np, "atc_src_rep") ? ATC_SRC_REP : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_dst_rep") ? ATC_DST_REP : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_src_h2sel_hw") ? ATC_SRC_H2SEL_HW : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_dst_h2sel_hw") ? ATC_DST_H2SEL_HW : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_sod") ? ATC_SOD : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_lock_if") ? ATC_LOCK_IF : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_lock_b") ? ATC_LOCK_B : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_lock_if_l") ? ATC_LOCK_IF_L : 0;
+	atslave->cfg |= of_property_read_bool(np, "atc_lock_if_l_buffer") ? ATC_LOCK_IF_L_BUFFER : 0;
+	if (of_property_read_bool(np, "atc_fifocfg_halffifo"))
+		atslave->cfg = (atslave->cfg & ~ATC_FIFOCFG_MASK) | ATC_FIFOCFG_HALFFIFO;
+	if (of_property_read_bool(np, "atc_fifocfg_enoughspace"))
+		atslave->cfg = (atslave->cfg & ~ATC_FIFOCFG_MASK) | ATC_FIFOCFG_ENOUGHSPACE;
+	if (of_property_read_bool(np, "atc_fifocfg_largestburst"))
+		atslave->cfg = (atslave->cfg & ~ATC_FIFOCFG_MASK) | ATC_FIFOCFG_LARGESTBURST;
+	if (!of_property_read_u32(np, "atc_ahb_prot", &val))
+		atslave->cfg |= ATC_AHB_PROT(val);
+	if (!of_property_read_u32(np, "atc_src_per", &val))
+		atslave->cfg |= ATC_SRC_PER(val);
+	if (!of_property_read_u32(np, "atc_dst_per", &val))
+		atslave->cfg |= ATC_DST_PER(val);
+
+	/* we need to associate the wanted dma struct device to
+	 * atslave->dma_dev. This is needed when searching for
+	 * a free dma channel
+	 */
+	prop = of_find_property(np, "dma", &size);
+	if (!prop) {
+		pr_err("can't find the dma child node\n");
+		goto error;
+	}
+	dma_list = prop->value;
+	size /= sizeof(*dma_list);
+	if (size != 1) {
+		pr_err("only one dma handle is supported\n");
+		goto error;
+	}
+
+	phandle = be32_to_cpup(dma_list);
+	n = of_find_node_by_phandle(phandle);
+	if (!n) {
+		pr_err("unable to find dma device: invalid phandle %s\n",
+		       prop->name);
+		goto error;
+	}
+
+	atslave->dma_dev = bus_find_device(bus, NULL, n, of_dev_node_match);
+	if (!atslave->dma_dev) {
+		pr_err("can't find struct device for DMA %s\n", prop->name);
+		goto error;
+	}
+
+	pr_debug("DMA cfg register=0x%x DMA device path=%s\n",
+		 atslave->cfg, prop->name);
+	err = 0;
+error:
+	if (err)
+		kfree(atslave);
+	return atslave;
+}
+EXPORT_SYMBOL_GPL(of_create_at_dma_slave);
+
diff --git a/include/linux/of_atmel.h b/include/linux/of_atmel.h
new file mode 100644
index 0000000..256f336
--- /dev/null
+++ b/include/linux/of_atmel.h
@@ -0,0 +1,29 @@
+#ifndef _LINUX_OF_ATMEL_H
+#define _LINUX_OF_ATMEL_H
+/*
+ * Copyright (C) 2012 Richard Genoud, Paratronic S.A.
+ *                    <richard.genoud@gmail.com>
+ *
+ * Atmel specifics OF helpers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/of.h>
+#include <linux/device.h>
+#include <mach/at_hdmac.h>
+
+#ifdef CONFIG_OF_ATMEL
+extern struct at_dma_slave *of_create_at_dma_slave(struct device_node *np,
+						   struct bus_type *bus);
+#else
+static struct at_dma_slave *of_create_at_dma_slave(struct device_node *np,
+						   struct bus_type *bus)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF_ATMEL */
+
+#endif	/* _LINUX_OF_ATMEL_H */
-- 
1.7.2.5
