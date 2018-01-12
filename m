From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 12 Jan 2018 13:08:14 -0800
Subject: [PATCH 1/2] soc: brcmstb: biuctrl: exit without warning on non
 brcmstb platforms
In-Reply-To: <20180112210815.9684-1-f.fainelli@gmail.com>
References: <20180112210815.9684-1-f.fainelli@gmail.com>
Message-ID: <20180112210815.9684-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Currently if this driver is included, we get the following warning
on any platforms irrespective of whether it's brcmstb platform or not.
"
 brcmstb: biuctrl: missing BIU control node
 brcmstb: biuctrl: MCP: Unable to disable write pairing!
"

This patch allows to exit early without any warning messages on non
brcmstb platforms as it's meaningless for them.

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[florian: Add fixes tag, make initcall non fatal]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 2b23ae7b5e9b..6d89ebf13b8a 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -162,17 +162,11 @@ static void __init mcp_b53_set(void)
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
@@ -242,9 +236,17 @@ static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
 
 static int __init brcmstb_biuctrl_init(void)
 {
+	struct device_node *np;
 	int ret;
 
-	setup_hifcpubiuctrl_regs();
+	/* We might be running on a multi-platform kernel, don't make this a
+	 * fatal error, just bail out early
+	 */
+	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
+	if (!np)
+		return 0;
+
+	setup_hifcpubiuctrl_regs(np);
 
 	ret = mcp_write_pairing_set();
 	if (ret) {
-- 
2.14.1
