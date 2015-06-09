From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  9 Jun 2015 17:49:59 +0800
Subject: [PATCH v6 3/3] ARM: rockchip: fix the SMP code style
In-Reply-To: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433843400-24831-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the below scripts to check:
scripts/checkpatch.pl -f --subject arch/arm/mach-rockchip/platsmp.c

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v6:
- fix the commnet Unified format.
Series-changes: 5
- Add the changelog.
Series-changes: 2
- Use the checkpatch.pl -f --subjective to check.

 arch/arm/mach-rockchip/platsmp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index d629206..30ccb82 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -100,7 +100,7 @@ static int pmu_set_power_domain(int pd, bool on)
 		ret = pmu_power_domain_is_on(pd);
 		if (ret < 0) {
 			pr_err("%s: could not read power domain state\n",
-				 __func__);
+			       __func__);
 			return ret;
 		}
 	}
@@ -130,7 +130,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 
 	if (cpu >= ncores) {
 		pr_err("%s: cpu %d outside maximum number of cpus %d\n",
-							__func__, cpu, ncores);
+		       __func__, cpu, ncores);
 		return -ENXIO;
 	}
 
@@ -140,7 +140,8 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		return ret;
 
 	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
-		/* We communicate with the bootrom to active the cpus other
+		/*
+		 * We communicate with the bootrom to active the cpus other
 		 * than cpu0, after a blob of initialize code, they will
 		 * stay at wfe state, once they are actived, they will check
 		 * the mailbox:
@@ -149,11 +150,11 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * The cpu0 need to wait the other cpus other than cpu0 entering
 		 * the wfe state.The wait time is affected by many aspects.
 		 * (e.g: cpu frequency, bootrom frequency, sram frequency, ...)
-		 * */
+		 */
 		mdelay(1); /* ensure the cpus other than cpu0 to startup */
 
 		writel(virt_to_phys(rockchip_secondary_startup),
-			sram_base_addr + 8);
+		       sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
@@ -336,7 +337,7 @@ static int rockchip_cpu_kill(unsigned int cpu)
 static void rockchip_cpu_die(unsigned int cpu)
 {
 	v7_exit_coherency_flush(louis);
-	while(1)
+	while (1)
 		cpu_do_idle();
 }
 #endif
@@ -349,4 +350,5 @@ static struct smp_operations rockchip_smp_ops __initdata = {
 	.cpu_die		= rockchip_cpu_die,
 #endif
 };
+
 CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
-- 
1.9.1
