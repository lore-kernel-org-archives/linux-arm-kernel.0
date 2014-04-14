From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Apr 2014 17:10:07 +0200
Subject: [PATCH v7 04/11] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
In-Reply-To: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1397488214-20685-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_cpu_coherent() took the SMP group ID as parameter. But this
parameter was never used, and the CPU always uses the SMP group 0. So
we can remove this parameter.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 4 ++--
 arch/arm/mach-mvebu/coherency.h | 2 +-
 arch/arm/mach-mvebu/platsmp.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 51010dbbf7e4..ad61251f7faf 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -46,7 +46,7 @@ static struct of_device_id of_coherency_table[] = {
 /* Function defined in coherency_ll.S */
 int ll_set_cpu_coherent(void);
 
-int set_cpu_coherent(int smp_group_id)
+int set_cpu_coherent(void)
 {
 	if (!coherency_base) {
 		pr_warn("Can't make current CPU cache coherent.\n");
@@ -140,7 +140,7 @@ int __init coherency_init(void)
 		sync_cache_w(&coherency_phys_base);
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
-		set_cpu_coherent(0);
+		set_cpu_coherent();
 		of_node_put(np);
 	}
 
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index c7e5df368d98..dff16612dd93 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -15,8 +15,8 @@
 #define __MACH_370_XP_COHERENCY_H
 
 extern unsigned long coherency_phys_base;
+int set_cpu_coherent(void);
 
-int set_cpu_coherent(int smp_group_id);
 int coherency_init(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index a99d71a747f0..f2f1830063c8 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -102,7 +102,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 
 	set_secondary_cpus_clock();
 	flush_cache_all();
-	set_cpu_coherent(0);
+	set_cpu_coherent();
 
 	/*
 	 * In order to boot the secondary CPUs we need to ensure
-- 
1.8.1.2
