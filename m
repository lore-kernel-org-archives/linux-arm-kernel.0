From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:45 -0800
Subject: [PATCH v2 7/9] soc: brcmstb: biuctrl: Fine tune B53 MCP interface
 settings
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to achieve expected MCP bus throughput on 3 particular chips:
7268, 7271 and 7278, do the appropriate programming of the MCP
interface: increase number of MCP write credits, turn on write-back
throttling when present.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index d498f9db01ab..dd45bbfe64dd 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -22,6 +22,18 @@
 #include <linux/soc/brcmstb/brcmstb.h>
 
 #define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
+#define CPU_CREDIT_REG_MCPx_READ_CRED_MASK	0xf
+#define CPU_CREDIT_REG_MCPx_WRITE_CRED_MASK	0xf
+#define CPU_CREDIT_REG_MCPx_READ_CRED_SHIFT(x)	((x) * 8)
+#define CPU_CREDIT_REG_MCPx_WRITE_CRED_SHIFT(x)	(((x) * 8) + 4)
+
+#define CPU_MCP_FLOW_REG_MCPx_RDBUFF_CRED_SHIFT(x)	((x) * 8)
+#define CPU_MCP_FLOW_REG_MCPx_RDBUFF_CRED_MASK		0xff
+
+#define CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_THRESHOLD_MASK	0xf
+#define CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_TIMEOUT_MASK		0xf
+#define CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_TIMEOUT_SHIFT	4
+#define CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_ENABLE		BIT(8)
 
 static void __iomem *cpubiuctrl_base;
 static bool mcp_wr_pairing_en;
@@ -59,6 +71,13 @@ static const int b15_cpubiuctrl_regs[] = {
 	[CPU_WRITEBACK_CTRL_REG] = -1,
 };
 
+/* Odd cases, e.g: 7260 */
+static const int b53_cpubiuctrl_no_wb_regs[] = {
+	[CPU_CREDIT_REG] = 0x0b0,
+	[CPU_MCP_FLOW_REG] = 0x0b4,
+	[CPU_WRITEBACK_CTRL_REG] = -1,
+};
+
 static const int b53_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x0b0,
 	[CPU_MCP_FLOW_REG] = 0x0b4,
@@ -90,6 +109,59 @@ static int __init mcp_write_pairing_set(void)
 	return 0;
 }
 
+static const u32 b53_mach_compat[] = {
+	0x7268,
+	0x7271,
+	0x7278,
+};
+
+static void __init mcp_b53_set(void)
+{
+	unsigned int i;
+	u32 reg;
+
+	reg = brcmstb_get_family_id();
+
+	for (i = 0; i < ARRAY_SIZE(b53_mach_compat); i++) {
+		if (BRCM_ID(reg) == b53_mach_compat[i])
+			break;
+	}
+
+	if (i == ARRAY_SIZE(b53_mach_compat))
+		return;
+
+	/* Set all 3 MCP interfaces to 8 credits */
+	reg = cbc_readl(CPU_CREDIT_REG);
+	for (i = 0; i < 3; i++) {
+		reg &= ~(CPU_CREDIT_REG_MCPx_WRITE_CRED_MASK <<
+			 CPU_CREDIT_REG_MCPx_WRITE_CRED_SHIFT(i));
+		reg &= ~(CPU_CREDIT_REG_MCPx_READ_CRED_MASK <<
+			 CPU_CREDIT_REG_MCPx_READ_CRED_SHIFT(i));
+		reg |= 8 << CPU_CREDIT_REG_MCPx_WRITE_CRED_SHIFT(i);
+		reg |= 8 << CPU_CREDIT_REG_MCPx_READ_CRED_SHIFT(i);
+	}
+	cbc_writel(reg, CPU_CREDIT_REG);
+
+	/* Max out the number of in-flight Jwords reads on the MCP interface */
+	reg = cbc_readl(CPU_MCP_FLOW_REG);
+	for (i = 0; i < 3; i++)
+		reg |= CPU_MCP_FLOW_REG_MCPx_RDBUFF_CRED_MASK <<
+			CPU_MCP_FLOW_REG_MCPx_RDBUFF_CRED_SHIFT(i);
+	cbc_writel(reg, CPU_MCP_FLOW_REG);
+
+	/* Enable writeback throttling, set timeout to 128 cycles, 256 cycles
+	 * threshold
+	 */
+	reg = cbc_readl(CPU_WRITEBACK_CTRL_REG);
+	reg |= CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_ENABLE;
+	reg &= ~CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_THRESHOLD_MASK;
+	reg &= ~(CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_TIMEOUT_MASK <<
+		 CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_TIMEOUT_SHIFT);
+	reg |= 8;
+	reg |= 7 << CPU_WRITEBACK_CTRL_REG_WB_THROTTLE_TIMEOUT_SHIFT;
+	cbc_writel(reg, CPU_WRITEBACK_CTRL_REG);
+}
+
 static int __init setup_hifcpubiuctrl_regs(void)
 {
 	struct device_node *np, *cpu_dn;
@@ -126,6 +198,9 @@ static int __init setup_hifcpubiuctrl_regs(void)
 		ret = -EINVAL;
 	}
 	of_node_put(cpu_dn);
+
+	if (BRCM_ID(brcmstb_get_family_id()) == 0x7260)
+		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
 out:
 	of_node_put(np);
 	return ret;
@@ -177,6 +252,7 @@ void __init brcmstb_biuctrl_init(void)
 		return;
 	}
 
+	mcp_b53_set();
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
 #endif
-- 
2.9.3
