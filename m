From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:42 -0800
Subject: [PATCH v2 4/9] soc: brcmstb: Correct CPU_CREDIT_REG offset for
 Brahma-B53 CPUs
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Broadcom Brahma-B53 CPUs, the CPU_CREDIT_REG offset got moved to
0x0b0 instead of 0x184, correct this such that we correcty
enable/disable write-pairing for these chips.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index c3c548fcaa8c..e8322e663831 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -21,12 +21,13 @@
 #include <linux/syscore_ops.h>
 #include <linux/soc/brcmstb/brcmstb.h>
 
-#define CPU_CREDIT_REG_OFFSET			0x184
+#define B15_CPU_CREDIT_REG_OFFSET		0x184
+#define B53_CPU_CREDIT_REG_OFFSET		0x0b0
 #define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
 
 static void __iomem *cpubiuctrl_base;
 static bool mcp_wr_pairing_en;
-static unsigned int cpu_credit_reg_offset = CPU_CREDIT_REG_OFFSET;
+static unsigned int cpu_credit_reg_offset;
 
 static int __init mcp_write_pairing_set(void)
 {
@@ -53,7 +54,7 @@ static int __init mcp_write_pairing_set(void)
 
 static int __init setup_hifcpubiuctrl_regs(void)
 {
-	struct device_node *np;
+	struct device_node *np, *cpu_dn;
 	int ret = 0;
 
 	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
@@ -70,6 +71,23 @@ static int __init setup_hifcpubiuctrl_regs(void)
 	}
 
 	mcp_wr_pairing_en = of_property_read_bool(np, "brcm,write-pairing");
+
+	cpu_dn = of_get_cpu_node(0, NULL);
+	if (!cpu_dn) {
+		pr_err("failed to obtain CPU device node\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (of_device_is_compatible(cpu_dn, "brcm,brahma-b15"))
+		cpu_credit_reg_offset = B15_CPU_CREDIT_REG_OFFSET;
+	else if (of_device_is_compatible(cpu_dn, "brcm,brahma-b53"))
+		cpu_credit_reg_offset = B53_CPU_CREDIT_REG_OFFSET;
+	else {
+		pr_err("unsupported CPU\n");
+		ret = -EINVAL;
+	}
+	of_node_put(cpu_dn);
 out:
 	of_node_put(np);
 	return ret;
-- 
2.9.3
