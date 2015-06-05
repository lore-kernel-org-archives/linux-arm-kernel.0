From: wxt@rock-chips.com (Caesar Wang)
Date: Sat,  6 Jun 2015 01:05:23 +0800
Subject: [PATCH v4 3/3] ARM: rockchip: fix the SMP code style
In-Reply-To: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
References: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433523923-4755-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the below scripts to check:
scripts/checkpatch.pl -f --subject arch/arm/mach-rockchip/platsmp.c
Although there is a check, it's no matter.

CHECK: usleep_range is preferred over udelay; see
Documentation/timers/timers-howto.txt
+167udelay(10);
total: 0 errors, 0 warnings, 1 checks, 362 lines checked

 Changes in v4:
    - Add reset_control_put(rstc) for the non-error case.
    - Fix commit information in PATCH [1/3]

 Changes in v3:
    - FIx the PATCH v2, it doesn't work on chromium 3.14.

 Changes in v2:
    - As Kever points out, Fix the subject typo WIF/WFI in PATCH [2/3].
    - As Heiko suggestion, re-adjust the cpu on/off flow in PATCH [1/3].
    - Use the checkpatch.pl -f --subjective to check in PATCH [3/3].

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/mach-rockchip/platsmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index d809fbc..63e9c7c 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -115,7 +115,7 @@ static int pmu_set_power_domain(int pd, bool on)
 		ret = pmu_power_domain_is_on(pd);
 		if (ret < 0) {
 			pr_err("%s: could not read power domain state\n",
-				 __func__);
+			       __func__);
 			return ret;
 		}
 	}
@@ -139,7 +139,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 
 	if (cpu >= ncores) {
 		pr_err("%s: cpu %d outside maximum number of cpus %d\n",
-							__func__, cpu, ncores);
+		       __func__, cpu, ncores);
 		return -ENXIO;
 	}
 
@@ -158,7 +158,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * */
 		udelay(10);
 		writel(virt_to_phys(rockchip_secondary_startup),
-			sram_base_addr + 8);
+		       sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
@@ -337,7 +337,7 @@ static int rockchip_cpu_kill(unsigned int cpu)
 static void rockchip_cpu_die(unsigned int cpu)
 {
 	v7_exit_coherency_flush(louis);
-	while(1)
+	while (1)
 		cpu_do_idle();
 }
 #endif
@@ -350,4 +350,5 @@ static struct smp_operations rockchip_smp_ops __initdata = {
 	.cpu_die		= rockchip_cpu_die,
 #endif
 };
+
 CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
-- 
1.9.1
