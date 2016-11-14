From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:09 +0530
Subject: [PATCH 14/16] ARM: hisi: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-15-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-hisi/platsmp.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index e1d6764..425a291 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -39,29 +39,14 @@ int hi3xxx_get_cpu_jump(int cpu)
 	return readl_relaxed(ctrl_base + ((cpu - 1) << 2));
 }
 
-static void __init hisi_enable_scu_a9(void)
-{
-	unsigned long base = 0;
-	void __iomem *scu_base = NULL;
-
-	if (scu_a9_has_base()) {
-		base = scu_a9_get_base();
-		scu_base = ioremap(base, SZ_4K);
-		if (!scu_base) {
-			pr_err("ioremap(scu_base) failed\n");
-			return;
-		}
-		scu_enable(scu_base);
-		iounmap(scu_base);
-	}
-}
-
 static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np = NULL;
 	u32 offset = 0;
 
-	hisi_enable_scu_a9();
+	if (scu_a9_has_base())
+		of_scu_enable();
+
 	if (!ctrl_base) {
 		np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
 		if (!np) {
@@ -100,7 +85,8 @@ static const struct smp_operations hi3xxx_smp_ops __initconst = {
 
 static void __init hisi_common_smp_prepare_cpus(unsigned int max_cpus)
 {
-	hisi_enable_scu_a9();
+	if (scu_a9_has_base())
+		of_scu_enable();
 }
 
 static void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
-- 
2.7.4
