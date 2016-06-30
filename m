From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:20 +0200
Subject: [PATCH 4/8] ARM: shmobile: apmu: Move #ifdef CONFIG_SMP to cover more
 functions
In-Reply-To: <cover.1467293089.git.horms+renesas@verge.net.au>
References: <cover.1467293089.git.horms+renesas@verge.net.au>
Message-ID: <d3f3fb0cfdcf4cbf69af65e8bfdde65cedf4e53a.1467293089.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

shmobile_smp_apmu_prepare_cpus() is used only if CONFIG_SMP=y.

Hence move the #ifdef to cover shmobile_smp_apmu_prepare_cpus() and all
functions only called by it (apmu_init_cpu() and apmu_parse_cfg()).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index aba75c89f9c1..c1558ef0c590 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -74,6 +74,7 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
 	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
 }
 
+#ifdef CONFIG_SMP
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
 	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
@@ -128,7 +129,6 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
 }
 
-#ifdef CONFIG_SMP
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-- 
2.7.0.rc3.207.g0ac5344
