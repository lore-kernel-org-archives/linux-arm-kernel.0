From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 12:52:48 -0700
Subject: [PATCH 2/3] soc: brcmstb: Add Bus Interface Unit control setup
In-Reply-To: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
References: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1442260369-6575-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom STB SoCs (brcmstb) require an early setup of their Bus
Interface Unit control register, this needs to happen before SMP is
brought up because it affects how the CPU complex will be interfaced to
the memory controller.

Add support code which properly initializes the BIU registers based on
whether "brcm,write-pairing" is present in Device Tree, and take care of
saving and restoring credit register settings during system-wide
suspend/resume operations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/brcmstb/Makefile        |   2 +-
 drivers/soc/brcmstb/biuctrl.c       | 117 ++++++++++++++++++++++++++++++++++++
 include/linux/soc/brcmstb/brcmstb.h |  10 +++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h

diff --git a/drivers/soc/brcmstb/Makefile b/drivers/soc/brcmstb/Makefile
index 677e3fa0d042..75df0e0c091d 100644
--- a/drivers/soc/brcmstb/Makefile
+++ b/drivers/soc/brcmstb/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_BRCMSTB_PM)	+= pm/
 
-obj-y				+= common.o
+obj-y				+= common.o biuctrl.o
diff --git a/drivers/soc/brcmstb/biuctrl.c b/drivers/soc/brcmstb/biuctrl.c
new file mode 100644
index 000000000000..7e4ead2c9565
--- /dev/null
+++ b/drivers/soc/brcmstb/biuctrl.c
@@ -0,0 +1,117 @@
+/*
+ * Broadcom STB SoCs Bus Unit Interface controls
+ *
+ * Copyright (C) 2015, Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#define CPU_CREDIT_REG_OFFSET			0x184
+#define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
+
+static void __iomem *cpubiuctrl_base;
+static bool mcp_wr_pairing_en;
+
+static int __init mcp_write_pairing_set(void)
+{
+	u32 creds = 0;
+
+	if (!cpubiuctrl_base)
+		return -1;
+
+	creds = readl_relaxed(cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+	if (mcp_wr_pairing_en) {
+		pr_info("MCP: Enabling write pairing\n");
+		writel_relaxed(creds | CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
+			     cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+	} else if (creds & CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK) {
+		pr_info("MCP: Disabling write pairing\n");
+		writel_relaxed(creds & ~CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
+				cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+	} else {
+		pr_info("MCP: Write pairing already disabled\n");
+	}
+
+	return 0;
+}
+
+static int __init setup_hifcpubiuctrl_regs(void)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
+	if (!np) {
+		pr_err("missing BIU control node\n");
+		return -ENODEV;
+	}
+
+	cpubiuctrl_base = of_iomap(np, 0);
+	if (!cpubiuctrl_base) {
+		pr_err("failed to remap BIU control base\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mcp_wr_pairing_en = of_property_read_bool(np, "brcm,write-pairing");
+out:
+	of_node_put(np);
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static u32 cpu_credit_reg_dump;  /* for save/restore */
+
+static int brcmstb_cpu_credit_reg_suspend(void)
+{
+	if (cpubiuctrl_base)
+		cpu_credit_reg_dump =
+			readl_relaxed(cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+	return 0;
+}
+
+static void brcmstb_cpu_credit_reg_resume(void)
+{
+	if (cpubiuctrl_base)
+		writel_relaxed(cpu_credit_reg_dump,
+				cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+}
+
+static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
+	.suspend = brcmstb_cpu_credit_reg_suspend,
+	.resume = brcmstb_cpu_credit_reg_resume,
+};
+#endif
+
+
+int __init brcmstb_biuctrl_init(void)
+{
+	int ret = 0;
+
+	ret = setup_hifcpubiuctrl_regs();
+	if (ret)
+		return ret;
+
+	ret = mcp_write_pairing_set();
+	if (ret) {
+		pr_err("MCP: Unable to disable write pairing!\n");
+		return ret;
+	}
+
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
+#endif
+	return ret;
+}
diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
new file mode 100644
index 000000000000..7009f61ea24c
--- /dev/null
+++ b/include/linux/soc/brcmstb/brcmstb.h
@@ -0,0 +1,10 @@
+#ifndef __BRCMSTB_SOC_H
+#define __BRCMSTB_SOC_H
+
+/*
+ * Bus Interface Unit control register setup, must happen early during boot,
+ * before SMP is brought up, called by machine entry point.
+ */
+int brcmstb_biuctrl_init(void);
+
+#endif /* __BRCMSTB_SOC_H */
-- 
2.1.0
