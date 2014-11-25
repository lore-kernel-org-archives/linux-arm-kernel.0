From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 24 Nov 2014 22:21:50 -0800
Subject: [RFC] ARM: exynos: MCPM: [is this a] fix for secondary boot on 5422?
Message-ID: <1416896510-24612-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

Using the current exynos_defconfig on the exynos5422-odroid-xu3, only
6 of 8 CPUs come online with MCPM boot.  CPU0 is an A7, CPUs 1-4 are
A15s and CPU5-7 are the other A7s, but with the current code, CPUs 5
and 7 do not boot:

   [...]
   Exynos MCPM support installed
   CPU1: update cpu_capacity 1535
   CPU1: thread -1, cpu 0, socket 0, mpidr 80000000
   CPU2: update cpu_capacity 1535
   CPU2: thread -1, cpu 1, socket 0, mpidr 80000001
   CPU3: update cpu_capacity 1535
   CPU3: thread -1, cpu 2, socket 0, mpidr 80000002
   CPU4: update cpu_capacity 1535
   CPU4: thread -1, cpu 3, socket 0, mpidr 80000003
   CPU5: failed to come online
   CPU6: update cpu_capacity 448
   CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
   CPU7: failed to come online
   Brought up 6 CPUs
   CPU: WARNING: CPU(s) started in wrong/inconsistent modes
   (primary CPU mode 0x13)
   CPU: This may indicate a broken bootloader or firmware.

Thanks to a tip from Abhilash, this patch gets all 8 CPUs booting
again, but the warning about CPUs started in inconsistent modes
remains.  Also, not being terribly familiar with Exynos internals,
it's not at all obvious to me why this register write (done for *all*
secondaries) makes things work works for the 2 secondary CPUs that
didn't come online.  It's also not obvious whether this is the right
general fix, since it doesn't seem to be needed on other 542x or 5800
platforms.

I suspect the "right" fix is in the bootloader someplace, but not
knowing this hardware well, I'm not sure if the fix is in u-boot
proper, or somewhere in the binary blobs (bl1/bl2/tz) that start
before u-boot.  The u-boot I'm using is from the hardkernel u-boot
repo[1], and I'd welcome any suggestions to try.  I'm able to rebuild
my own u-boot from there, but only have binaries for bl1/bl2/tz.

[1] branch "odroidxu3-v2012.07" of: https://github.com/hardkernel/u-boot.git


Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
Cc: Abhilash Kesavan <a.kesavan@samsung.com>,
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 2 ++
 arch/arm/mach-exynos/regs-pmu.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index b0d3c2e876fb..612a770d5284 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -88,6 +88,8 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
 		cluster >= EXYNOS5420_NR_CLUSTERS)
 		return -EINVAL;
 
+	pmu_raw_writel(0x1, S5P_PMU_SPARE2);
+
 	/*
 	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
 	 * variant exists, we need to disable IRQs manually here.
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index b5f4406fc1b5..70d9eb5a4fcc 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -49,6 +49,7 @@
 #define S5P_INFORM5				0x0814
 #define S5P_INFORM6				0x0818
 #define S5P_INFORM7				0x081C
+#define S5P_PMU_SPARE2				0x0908
 #define S5P_PMU_SPARE3				0x090C
 
 #define EXYNOS_IROM_DATA2			0x0988
-- 
2.1.3
