From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:36 +0100
Subject: [PATCH 14/14] ARM: shmobile: rcar-gen2: Add watchdog support
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <01d675f159e0f0792947fb823cf2425da4d747ad.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds watchdog support by installing shmobile_boot_vector_gen2
to ICRAM1 when enough memory is available, in which case we also keep a
copy of MPIDR to complete the reset vector logic.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4422b615a6ee..ba732effc90b 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -191,6 +191,7 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = __pa_symbol(shmobile_smp_boot);
+	shmobile_boot_fn_gen2 = shmobile_boot_fn;
 }
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index e5f215c8b218..5a798b406af0 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
+#include <asm/cputype.h>
 #include "common.h"
 #include "rcar-gen2.h"
 
@@ -37,7 +38,6 @@
 #define CA7RESCNT_CODE	0x5a5a0000
 #define CA7RESCNT_CPUS	0xf		/* CPU0-3 */
 
-
 /* On-chip RAM */
 #define ICRAM1		0xe63c0000	/* Inter Connect RAM1 (4 KiB) */
 
@@ -119,8 +119,17 @@ void __init rcar_gen2_pm_init(void)
 	p = ioremap(res.start, resource_size(&res));
 	if (!p)
 		return;
-
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	/*
+	 * install the reset vector, use the largest version if we have enough
+	 * memory available
+	 */
+	if (resource_size(&res) >= shmobile_boot_size_gen2) {
+		shmobile_boot_cpu_gen2 = read_cpuid_mpidr();
+		memcpy_toio(p, shmobile_boot_vector_gen2,
+			    shmobile_boot_size_gen2);
+	} else {
+		memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	}
 	iounmap(p);
 
 	/* setup reset vectors */
-- 
2.11.0
