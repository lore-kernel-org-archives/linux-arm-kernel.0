From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:21 +0200
Subject: [PATCH 10/15] ARM: shmobile: r8a7779: Stop powering down secondary
 CPUs during early boot
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <62f55ce683e3675aa83cc3e912f070aef1baeff8.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

At .smp_prepare_cpus() time, CPUs 1-3 are still powered down:
  - The bootloader doesn't enable CPUs 1-3,
  - Non-boot CPUs are disabled by kexec before starting the new kernel.

Hence there is no need to try to power them down again, as it will fail
silently with -EIO anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index c6951ee24588..ff1e6fc0b861 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -97,11 +97,6 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 	shmobile_smp_scu_prepare_cpus(R8A7779_SCU_BASE, max_cpus);
 
 	r8a7779_pm_init();
-
-	/* power off secondary CPUs */
-	r8a7779_platform_cpu_kill(1);
-	r8a7779_platform_cpu_kill(2);
-	r8a7779_platform_cpu_kill(3);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.11.0
