From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:43 -0800
Subject: [PATCH v2 5/9] soc: brcmstb: biuctrl: Prepare for saving/restoring
 other registers
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for saving/restoring additional registers required on
some newer platforms (7268, 7271, 7278), migrate the code to use enums
and helper functions to access registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 75 ++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index e8322e663831..16cbfc2e953a 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -21,13 +21,45 @@
 #include <linux/syscore_ops.h>
 #include <linux/soc/brcmstb/brcmstb.h>
 
-#define B15_CPU_CREDIT_REG_OFFSET		0x184
-#define B53_CPU_CREDIT_REG_OFFSET		0x0b0
 #define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
 
 static void __iomem *cpubiuctrl_base;
 static bool mcp_wr_pairing_en;
-static unsigned int cpu_credit_reg_offset;
+static const int *cpubiuctrl_regs;
+
+static inline u32 cbc_readl(int reg)
+{
+	int offset = cpubiuctrl_regs[reg];
+
+	if (offset == -1)
+		return (u32)-1;
+
+	return readl_relaxed(cpubiuctrl_base + offset);
+}
+
+static inline void cbc_writel(u32 val, int reg)
+{
+	int offset = cpubiuctrl_regs[reg];
+
+	if (offset == -1)
+		return;
+
+	writel_relaxed(val,  cpubiuctrl_base + offset);
+}
+
+enum cpubiuctrl_regs {
+	CPU_CREDIT_REG = 0,
+};
+
+static const int b15_cpubiuctrl_regs[] = {
+	[CPU_CREDIT_REG] = 0x184,
+};
+
+static const int b53_cpubiuctrl_regs[] = {
+	[CPU_CREDIT_REG] = 0x0b0,
+};
+
+#define NUM_CPU_BIUCTRL_REGS	1
 
 static int __init mcp_write_pairing_set(void)
 {
@@ -36,15 +68,15 @@ static int __init mcp_write_pairing_set(void)
 	if (!cpubiuctrl_base)
 		return -1;
 
-	creds = readl_relaxed(cpubiuctrl_base + cpu_credit_reg_offset);
+	creds = cbc_readl(CPU_CREDIT_REG);
 	if (mcp_wr_pairing_en) {
 		pr_info("MCP: Enabling write pairing\n");
-		writel_relaxed(creds | CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
-			     cpubiuctrl_base + cpu_credit_reg_offset);
+		cbc_writel(creds | CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
+			   CPU_CREDIT_REG);
 	} else if (creds & CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK) {
 		pr_info("MCP: Disabling write pairing\n");
-		writel_relaxed(creds & ~CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
-				cpubiuctrl_base + cpu_credit_reg_offset);
+		cbc_writel(creds & ~CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
+			   CPU_CREDIT_REG);
 	} else {
 		pr_info("MCP: Write pairing already disabled\n");
 	}
@@ -80,9 +112,9 @@ static int __init setup_hifcpubiuctrl_regs(void)
 	}
 
 	if (of_device_is_compatible(cpu_dn, "brcm,brahma-b15"))
-		cpu_credit_reg_offset = B15_CPU_CREDIT_REG_OFFSET;
+		cpubiuctrl_regs = b15_cpubiuctrl_regs;
 	else if (of_device_is_compatible(cpu_dn, "brcm,brahma-b53"))
-		cpu_credit_reg_offset = B53_CPU_CREDIT_REG_OFFSET;
+		cpubiuctrl_regs = b53_cpubiuctrl_regs;
 	else {
 		pr_err("unsupported CPU\n");
 		ret = -EINVAL;
@@ -94,21 +126,30 @@ static int __init setup_hifcpubiuctrl_regs(void)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static u32 cpu_credit_reg_dump;  /* for save/restore */
+static u32 cpubiuctrl_reg_save[NUM_CPU_BIUCTRL_REGS];
 
 static int brcmstb_cpu_credit_reg_suspend(void)
 {
-	if (cpubiuctrl_base)
-		cpu_credit_reg_dump =
-			readl_relaxed(cpubiuctrl_base + cpu_credit_reg_offset);
+	unsigned int i;
+
+	if (!cpubiuctrl_base)
+		return 0;
+
+	for (i = 0; i < NUM_CPU_BIUCTRL_REGS; i++)
+		cpubiuctrl_reg_save[i] = cbc_readl(i);
+
 	return 0;
 }
 
 static void brcmstb_cpu_credit_reg_resume(void)
 {
-	if (cpubiuctrl_base)
-		writel_relaxed(cpu_credit_reg_dump,
-				cpubiuctrl_base + cpu_credit_reg_offset);
+	unsigned int i;
+
+	if (!cpubiuctrl_base)
+		return;
+
+	for (i = 0; i < NUM_CPU_BIUCTRL_REGS; i++)
+		cbc_writel(cpubiuctrl_reg_save[i], i);
 }
 
 static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
-- 
2.9.3
