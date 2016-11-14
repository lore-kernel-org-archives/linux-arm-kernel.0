From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:00 +0530
Subject: [PATCH 05/16] ARM: socfpga: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Dinh Nguyen <dinguyen@opensource.altera.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-socfpga/platsmp.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 0794574..d3f0a07 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -79,19 +79,10 @@ static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle
 
 static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 {
-	struct device_node *np;
-	void __iomem *socfpga_scu_base_addr;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-	if (!np) {
+	if (of_scu_enable()) {
 		pr_err("%s: missing scu\n", __func__);
 		return;
 	}
-
-	socfpga_scu_base_addr = of_iomap(np, 0);
-	if (!socfpga_scu_base_addr)
-		return;
-	scu_enable(socfpga_scu_base_addr);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.7.4
