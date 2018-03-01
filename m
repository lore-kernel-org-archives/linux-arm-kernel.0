From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu,  1 Mar 2018 14:58:06 +0100
Subject: [PATCH v2 2/2] ARM: mach-stm32: Add Extended TrustZone Protection
 driver
In-Reply-To: <20180301135806.19982-1-benjamin.gaignard@st.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
Message-ID: <20180301135806.19982-3-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extended TrustZone Protection (ETZPC) driver checks that
the hardware block is accessible to non-secure world.
If not it will disable the device tree node by updated it
status property.

Split between secure and non-secure hardware blocks is
done at early boot stage so the driver only needs to read
the status (2 bits) for each of the block.

Hardware blocks status bits location in the registers is
computed from the index of the device phandle in the list.

To avoid to bind a device which will not be accessible ETZPC driver
must be probed early, at least before platform driver, so just after
core initialisation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/mach-stm32/Kconfig       |   7 +++
 arch/arm/mach-stm32/Makefile      |   1 +
 arch/arm/mach-stm32/stm32-etzpc.c | 116 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 5bc7f5ab61cd..a3ef308642be 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -44,6 +44,13 @@ config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
 	default y
 
+config STM32_ETZPC
+	bool "STM32 Extended TrustZone Protection"
+	depends on MACH_STM32MP157
+	help
+	  Select y to enable STM32 Extended TrustZone Protection
+	  Controller (ETZPC)
+
 endif # ARMv7-A
 
 endif
diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
index bd0b7b5d6e9d..2e1e729a68c9 100644
--- a/arch/arm/mach-stm32/Makefile
+++ b/arch/arm/mach-stm32/Makefile
@@ -1 +1,2 @@
 obj-y += board-dt.o
+obj-$(CONFIG_STM32_ETZPC) += stm32-etzpc.o
diff --git a/arch/arm/mach-stm32/stm32-etzpc.c b/arch/arm/mach-stm32/stm32-etzpc.c
new file mode 100644
index 000000000000..ea966b7d519a
--- /dev/null
+++ b/arch/arm/mach-stm32/stm32-etzpc.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ETZPC_DECPROT0		0x10
+#define ETZPC_IP_VER		0x3F4
+
+#define IP_VER_MP1		0x00000020
+
+#define DECPROT_MASK		0x03
+#define NB_PROT_PER_REG		0x10
+#define DECPROT_NB_BITS		2
+
+static void __init stm32_etzpc_update_status(struct device_node *np)
+{
+	struct property *prop;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return;
+
+	prop->name = "status";
+	prop->value = "disabled";
+	prop->length = strlen((char *)prop->value)+1;
+
+	of_update_property(np, prop);
+
+	pr_err("%s status doesn't match ETZPC status\n", of_node_full_name(np));
+}
+
+static bool __init stm32_etzpc_is_secured(void __iomem *base, int index)
+{
+	u32 status;
+	int offset = (index / NB_PROT_PER_REG) * sizeof(u32);
+	int shift = (index % NB_PROT_PER_REG) * DECPROT_NB_BITS;
+
+	status = readl(base + ETZPC_DECPROT0 + offset);
+	status &= DECPROT_MASK << shift;
+
+	return (status != DECPROT_MASK << shift);
+}
+
+static const struct of_device_id stm32_etzpc_of_match[] = {
+	{
+		.compatible = "st,stm32mp1-etzpc",
+	},
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_etzpc_of_match);
+
+static int __init stm32_etzpc_probe(struct device_node *np,
+			     const struct of_device_id *match)
+{
+	struct of_phandle_iterator it;
+	void __iomem *base;
+	int version, index = 0, ret = 0;
+
+	base = of_iomap(np, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	version = readl(base + ETZPC_IP_VER);
+	if (version != IP_VER_MP1) {
+		pr_err("Wrong ETZPC version\n");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	of_for_each_phandle(&it, ret, np, "protected-devices", NULL, 0) {
+		if (of_device_is_available(it.node) &&
+		    stm32_etzpc_is_secured(base, index))
+			stm32_etzpc_update_status(it.node);
+
+		index++;
+	}
+
+failed:
+	iounmap(base);
+	return ret;
+}
+
+/*
+ * stm32_etzpc_init need to be called before starting to probe
+ * platform drivers to be able check the status of each protected devices
+ * that's why it is tagged as postcore_initcall
+ */
+static int __init stm32_etzpc_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *m;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, stm32_etzpc_of_match, &m);
+
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	ret = stm32_etzpc_probe(np, m);
+
+	of_node_put(np);
+
+	return ret;
+}
+postcore_initcall(stm32_etzpc_init);
-- 
2.15.0
