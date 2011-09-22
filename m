From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Sep 2011 21:25:11 +0100
Subject: [PATCH][RESEND] ARM: cache: detect PIPT I-cache using CTR
Message-ID: <1316723111-10473-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cache Type Register L1Ip field identifies I-caches with a PIPT
policy using the encoding 11b.

This patch extends the cache policy parsing to identify PIPT I-caches
correctly and prevent them from being treated as VIPT aliasing in cases
where they are sufficiently large.

Signed-off-by: Will Deacon <will.deacon@arm.com>
KernelVersion: 3.1-rc3
---

Russell - this has been sitting in the patch system as 7062/1 for a
while now. Please can you add it to your for-next branch for 3.2?

Thanks,

Will


 arch/arm/include/asm/cachetype.h |    5 ++++-
 arch/arm/kernel/setup.c          |   15 +++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index c023db0..7ea7814 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -7,6 +7,7 @@
 #define CACHEID_VIPT			(CACHEID_VIPT_ALIASING|CACHEID_VIPT_NONALIASING)
 #define CACHEID_ASID_TAGGED		(1 << 3)
 #define CACHEID_VIPT_I_ALIASING		(1 << 4)
+#define CACHEID_PIPT			(1 << 5)
 
 extern unsigned int cacheid;
 
@@ -16,6 +17,7 @@ extern unsigned int cacheid;
 #define cache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_ALIASING)
 #define icache_is_vivt_asid_tagged()	cacheid_is(CACHEID_ASID_TAGGED)
 #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
+#define icache_is_pipt()		cacheid_is(CACHEID_PIPT)
 
 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
@@ -26,7 +28,8 @@ extern unsigned int cacheid;
 #if __LINUX_ARM_ARCH__ >= 7
 #define __CACHEID_ARCH_MIN	(CACHEID_VIPT_NONALIASING |\
 				 CACHEID_ASID_TAGGED |\
-				 CACHEID_VIPT_I_ALIASING)
+				 CACHEID_VIPT_I_ALIASING |\
+				 CACHEID_PIPT)
 #elif __LINUX_ARM_ARCH__ >= 6
 #define	__CACHEID_ARCH_MIN	(~CACHEID_VIVT)
 #else
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 2cdba13..6311da7 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -248,6 +248,10 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 	int aliasing_icache;
 	unsigned int id_reg, num_sets, line_size;
 
+	/* PIPT caches never alias. */
+	if (icache_is_pipt())
+		return 0;
+
 	/* arch specifies the register format */
 	switch (arch) {
 	case CPU_ARCH_ARMv7:
@@ -282,8 +286,14 @@ static void __init cacheid_init(void)
 			/* ARMv7 register format */
 			arch = CPU_ARCH_ARMv7;
 			cacheid = CACHEID_VIPT_NONALIASING;
-			if ((cachetype & (3 << 14)) == 1 << 14)
+			switch (cachetype & (3 << 14)) {
+			case (1 << 14):
 				cacheid |= CACHEID_ASID_TAGGED;
+				break;
+			case (3 << 14):
+				cacheid |= CACHEID_PIPT;
+				break;
+			}
 		} else {
 			arch = CPU_ARCH_ARMv6;
 			if (cachetype & (1 << 23))
@@ -300,10 +310,11 @@ static void __init cacheid_init(void)
 	printk("CPU: %s data cache, %s instruction cache\n",
 		cache_is_vivt() ? "VIVT" :
 		cache_is_vipt_aliasing() ? "VIPT aliasing" :
-		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" : "unknown",
+		cache_is_vipt_nonaliasing() ? "PIPT / VIPT nonaliasing" : "unknown",
 		cache_is_vivt() ? "VIVT" :
 		icache_is_vivt_asid_tagged() ? "VIVT ASID tagged" :
 		icache_is_vipt_aliasing() ? "VIPT aliasing" :
+		icache_is_pipt() ? "PIPT" :
 		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" : "unknown");
 }
 
-- 
1.7.0.4
