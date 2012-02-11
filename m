From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:41 +0900
Subject: [PATCH v2 07/11] ARM: EXYNOS: add support get_core_count() for
 EXYNOS5250
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EXYNOS5250 has two Cortex-A15 cores and there's no
need to call scu_enable() in platform_smp_prepare_cpus().

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 0f2035a..36c3984 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -166,7 +166,10 @@ void __init smp_init_cpus(void)
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	if (soc_is_exynos5250())
+		ncores = 2;
+	else
+		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
 	if (ncores > nr_cpu_ids) {
@@ -183,8 +186,8 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-
-	scu_enable(scu_base_addr());
+	if (!soc_is_exynos5250())
+		scu_enable(scu_base_addr());
 
 	/*
 	 * Write the address of secondary startup into the
-- 
1.7.4.4
