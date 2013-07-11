From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 11 Jul 2013 18:52:57 +0900
Subject: [PATCH 4/4] ARM: shmobile: smp-r8a7790: power up a CPU core at
 .smp_boot_secondary stage
In-Reply-To: <51DE7FF4.5050800@renesas.com>
References: <20130710104151.20742.56398.sendpatchset@w520>
 <51DE7FF4.5050800@renesas.com>
Message-ID: <51DE8079.6000001@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the CPU hotplug support in mind, we should not let oneline CPU cores
get powered on at .smp_prepare_cpus stage _just_ _once_, but should power
up a requested CPU core one by one, when .smp_boot_secondary is processed.

Otherwise, the power supply to CPU cores can never be on again after
resume or cpu_up request via CPU hotplug.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 1448e387..6d23c52 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -120,11 +120,9 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 	memcpy_toio(p, shmobile_boot_vector, 16);
 	iounmap(p);
 
-	/* keep secondary CPU cores in reset, but powered on */
-	for (k = 1; k < 8; k++) {
+	/* keep secondary CPU cores in reset */
+	for (k = 1; k < 8; k++)
 		r8a7790_assert_reset(k);
-		r8a7790_power_on(k);
-	}
 }
 
 static int __cpuinit r8a7790_boot_secondary(unsigned int cpu,
@@ -134,6 +132,7 @@ static int __cpuinit r8a7790_boot_secondary(unsigned int cpu,
 	if (r8a7790_clst_id(cpu) != r8a7790_clst_id(0))
 		return -ENOTSUPP;
 
+	r8a7790_power_on(cpu);
 	r8a7790_deassert_reset(cpu);
 	return 0;
 }
-- 
1.8.3.2
