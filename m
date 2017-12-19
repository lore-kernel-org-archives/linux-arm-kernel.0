From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:41 -0800
Subject: [PATCH v2 3/9] soc: brcmstb: Make CPU credit offset more parameterized
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for fixing and changing values in the CPU_CREDIT_REG
register for B53-based systems, make the offset parameterized.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 3c39415d484f..c3c548fcaa8c 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -26,6 +26,7 @@
 
 static void __iomem *cpubiuctrl_base;
 static bool mcp_wr_pairing_en;
+static unsigned int cpu_credit_reg_offset = CPU_CREDIT_REG_OFFSET;
 
 static int __init mcp_write_pairing_set(void)
 {
@@ -34,15 +35,15 @@ static int __init mcp_write_pairing_set(void)
 	if (!cpubiuctrl_base)
 		return -1;
 
-	creds = readl_relaxed(cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+	creds = readl_relaxed(cpubiuctrl_base + cpu_credit_reg_offset);
 	if (mcp_wr_pairing_en) {
 		pr_info("MCP: Enabling write pairing\n");
 		writel_relaxed(creds | CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
-			     cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+			     cpubiuctrl_base + cpu_credit_reg_offset);
 	} else if (creds & CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK) {
 		pr_info("MCP: Disabling write pairing\n");
 		writel_relaxed(creds & ~CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK,
-				cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+				cpubiuctrl_base + cpu_credit_reg_offset);
 	} else {
 		pr_info("MCP: Write pairing already disabled\n");
 	}
@@ -81,7 +82,7 @@ static int brcmstb_cpu_credit_reg_suspend(void)
 {
 	if (cpubiuctrl_base)
 		cpu_credit_reg_dump =
-			readl_relaxed(cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+			readl_relaxed(cpubiuctrl_base + cpu_credit_reg_offset);
 	return 0;
 }
 
@@ -89,7 +90,7 @@ static void brcmstb_cpu_credit_reg_resume(void)
 {
 	if (cpubiuctrl_base)
 		writel_relaxed(cpu_credit_reg_dump,
-				cpubiuctrl_base + CPU_CREDIT_REG_OFFSET);
+				cpubiuctrl_base + cpu_credit_reg_offset);
 }
 
 static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
-- 
2.9.3
