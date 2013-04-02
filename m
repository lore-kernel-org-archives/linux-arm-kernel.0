From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:32:26 +0800
Subject: [PATCH] ARM: imx: do not bring up unavailable cores
Message-ID: <1364913146-26084-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 Quad can be fused as i.MX6 Dual chip, and similarly i.MX6
DualLite can be fused as i.MX6 Solo.  The actual number of available
cores can be found out from SCU.

Since we do not reflect the fusing thing in device tree, the function
arm_dt_init_cpu_maps() will always call set_cpu_possible(true) for 4
cores on i.MX6 Quad/Dual and 2 cores for i.MX6 DualLite/Solo.  This
causes failures when kernel tries to bring those unavailable cores
online.  For example, the following failure message will be seen when
booting an i.MX6 Solo chip.

  CPU1: failed to come online

Though kernel will still boot fine, the message is somehow annoying.
Let's get rid of it by calling set_cpu_possible(false) on those
unavailable cores.

While at it, the set_cpu_possible(true) for available cores is removed,
since it's already been done in arm_dt_init_cpu_maps().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/platsmp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7c0b03f..7061bde 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -79,8 +79,8 @@ static void __init imx_smp_init_cpus(void)
 
 	ncores = scu_get_core_count(scu_base);
 
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	for (i = ncores; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
 }
 
 void imx_smp_prepare(void)
-- 
1.7.9.5
