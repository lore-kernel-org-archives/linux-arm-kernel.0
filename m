From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 08:53:09 +0200
Subject: [PATCH 04/12] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1377240797-4047-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_cpu_coherent() took the SMP group ID as parameter. But this
parameter was never used, and the CPU always use the SMP group 0. So
we can remove this parameter.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 4 ++--
 arch/arm/mach-mvebu/coherency.h | 2 +-
 arch/arm/mach-mvebu/platsmp.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index e48518e..a2b6366 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -45,7 +45,7 @@ static struct of_device_id of_coherency_table[] = {
 /* Function defined in coherency_ll.S */
 int ll_set_cpu_coherent(bool use_virt_addr);
 
-int set_cpu_coherent(int smp_group_id)
+int set_cpu_coherent(void)
 {
 	if (!coherency_base) {
 		pr_warn("Can't make current CPU cache coherent.\n");
@@ -139,7 +139,7 @@ int __init coherency_init(void)
 		sync_cache_w(&coherency_phys_base);
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
-		set_cpu_coherent(0);
+		set_cpu_coherent();
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index d4bc067..700376e 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -14,7 +14,7 @@
 #ifndef __MACH_370_XP_COHERENCY_H
 #define __MACH_370_XP_COHERENCY_H
 
-int set_cpu_coherent(int smp_group_id);
+int set_cpu_coherent(void);
 int coherency_init(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 455f7cb..751ff06 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -116,7 +116,7 @@ void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 {
 	set_secondary_cpus_clock();
 	flush_cache_all();
-	set_cpu_coherent(0);
+	set_cpu_coherent();
 	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
 }
 
-- 
1.8.1.2
