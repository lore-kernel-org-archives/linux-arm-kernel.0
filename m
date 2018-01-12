From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jan 2018 14:38:13 +0100
Subject: [PATCH 3/3] soc: brcmstb: Avoid error messages on non-STB platforms
In-Reply-To: <20180112133813.3716-1-thierry.reding@gmail.com>
References: <20180112133813.3716-1-thierry.reding@gmail.com>
Message-ID: <20180112133813.3716-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Move the check for STB platforms up into the early initcall so that the
code can abort early (and without an error) if it runs on non-STB
platforms.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 2b23ae7b5e9b..1044cc6c3ffc 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -162,22 +162,15 @@ static void __init mcp_b53_set(void)
 	cbc_writel(reg, CPU_WRITEBACK_CTRL_REG);
 }
 
-static int __init setup_hifcpubiuctrl_regs(void)
+static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 {
-	struct device_node *np, *cpu_dn;
+	struct device_node *cpu_dn;
 	int ret = 0;
 
-	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
-	if (!np) {
-		pr_err("missing BIU control node\n");
-		return -ENODEV;
-	}
-
 	cpubiuctrl_base = of_iomap(np, 0);
 	if (!cpubiuctrl_base) {
 		pr_err("failed to remap BIU control base\n");
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	mcp_wr_pairing_en = of_property_read_bool(np, "brcm,write-pairing");
@@ -185,8 +178,7 @@ static int __init setup_hifcpubiuctrl_regs(void)
 	cpu_dn = of_get_cpu_node(0, NULL);
 	if (!cpu_dn) {
 		pr_err("failed to obtain CPU device node\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	if (of_device_is_compatible(cpu_dn, "brcm,brahma-b15"))
@@ -201,9 +193,8 @@ static int __init setup_hifcpubiuctrl_regs(void)
 
 	if (BRCM_ID(brcmstb_get_family_id()) == 0x7260)
 		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
-out:
-	of_node_put(np);
-	return ret;
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -242,9 +233,15 @@ static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
 
 static int __init brcmstb_biuctrl_init(void)
 {
+	struct device_node *np;
 	int ret;
 
-	setup_hifcpubiuctrl_regs();
+	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
+	if (!np)
+		return 0;
+
+	setup_hifcpubiuctrl_regs(np);
+	of_node_put(np);
 
 	ret = mcp_write_pairing_set();
 	if (ret) {
-- 
2.15.1
