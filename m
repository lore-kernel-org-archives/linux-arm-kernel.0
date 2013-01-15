From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 08:14:07 -0000
Subject: [v3 5/9] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358237598-32413-6-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Skip scu_enable(scu_base) if CPU is not Cortex A9.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 689ee4b..e329e93 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -38,7 +38,6 @@
 extern void tegra_secondary_startup(void);
 
 static cpumask_t tegra_cpu_init_mask;
-static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 
 #define EVP_CPU_RESET_VECTOR \
 	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
@@ -184,10 +183,14 @@ static void __init tegra_smp_init_cpus(void)
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
+	phys_addr_t base;
+
 	/* Always mark the boot CPU (CPU0) as initialized. */
 	cpumask_set_cpu(0, &tegra_cpu_init_mask);
 
-	scu_enable(scu_base);
+	base = scu_get_base();
+	if (base)
+		scu_enable(IO_ADDRESS(base));
 }
 
 struct smp_operations tegra_smp_ops __initdata = {
-- 
1.7.9.5
