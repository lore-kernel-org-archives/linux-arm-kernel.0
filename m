From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:01 +0530
Subject: [PATCH 06/16] ARM: STi: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-7-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-sti/platsmp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index ea5a227..0bc7ff8 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -99,19 +99,12 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
-	void __iomem *scu_base;
 	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
 	unsigned long entry_pa = virt_to_phys(sti_secondary_startup);
 
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-
-	if (np) {
-		scu_base = of_iomap(np, 0);
-		scu_enable(scu_base);
-		of_node_put(np);
-	}
+	of_scu_enable();
 
 	if (max_cpus <= 1)
 		return;
-- 
2.7.4
