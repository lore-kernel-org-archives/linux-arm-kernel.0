From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 17:23:41 +0900
Subject: [PATCH] ARM: S5PV310: Fix on Secondary CPU startup
Message-ID: <1282811021-21612-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

Following occurs on boot message without this patch.
    CPU1: processor failed to boot
    Brought up 1 CPUs
    SMP: Total of 1 processors activated

This patch adds SYSRAM mapping for fixing Secondary CPU startup.
    CPU1: Booted secondary processor
    Brought up 2 CPUs
    SMP: Total of 2 processors activated

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c              |    5 +++++
 arch/arm/mach-s5pv310/include/mach/map.h |    2 ++
 arch/arm/mach-s5pv310/platsmp.c          |    2 +-
 arch/arm/plat-s5p/include/plat/map-s5p.h |    1 +
 4 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 2b74295..32b6972 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -50,6 +50,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5PV310_PA_CMU),
 		.length		= SZ_128K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(S5PV310_PA_SYSRAM),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	}
 };
 
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 3c00495..213e110 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -23,6 +23,8 @@
 
 #include <plat/map-s5p.h>
 
+#define S5PV310_PA_SYSRAM		(0x02025000)
+
 #define S5PV310_PA_CHIPID		(0x10000000)
 #define S5P_PA_CHIPID			S5PV310_PA_CHIPID
 
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index fe9469a..d357c19 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -187,6 +187,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		 * until it receives a soft interrupt, and then the
 		 * secondary CPU branches to this address.
 		 */
-	__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)), S5P_INFORM0);
+	__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)), S5P_VA_SYSRAM);
 	}
 }
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 5897792..c4ff88b 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -17,6 +17,7 @@
 #define S5P_VA_GPIO		S3C_ADDR(0x00500000)
 #define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
 #define S5P_VA_SROMC		S3C_ADDR(0x01100000)
+#define S5P_VA_SYSRAM		S3C_ADDR(0x01180000)
 
 #define S5P_VA_COMBINER_BASE	S3C_ADDR(0x00600000)
 #define S5P_VA_COMBINER(x)	(S5P_VA_COMBINER_BASE + ((x) >> 2) * 0x10)
-- 
1.6.2.5
