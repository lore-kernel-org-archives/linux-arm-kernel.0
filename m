From: kuleshovmail@gmail.com (Alexander Kuleshov)
Date: Fri,  4 Sep 2015 00:12:59 +0600
Subject: [PATCH 3/3] arm64/fpsimd: Use ID_AA64PFR0_EL1_.* macros
In-Reply-To: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <1441303979-9535-1-git-send-email-kuleshovmail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 26d75e67c commit (arm64/cpufeature.h: Add macros for a cpu features
testing) provides set of macros for the testing processor's FP and advanced
SIMD features.

Let's use these macros instead of direct calculation.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/arm64/kernel/fpsimd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 44d6f75..12943a5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -27,6 +27,7 @@
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
+#include <asm/cpufeature.h>
 
 #define FPEXC_IOF	(1 << 0)
 #define FPEXC_DZF	(1 << 1)
@@ -333,13 +334,13 @@ static int __init fpsimd_init(void)
 {
 	u64 pfr = read_cpuid(ID_AA64PFR0_EL1);
 
-	if (pfr & (0xf << 16)) {
+	if (ID_AA64PFR0_EL1_FP(pfr)) {
 		pr_notice("Floating-point is not implemented\n");
 		return 0;
 	}
 	elf_hwcap |= HWCAP_FP;
 
-	if (pfr & (0xf << 20))
+	if (ID_AA64PFR0_EL1_ADV_SIMD(pfr))
 		pr_notice("Advanced SIMD is not implemented\n");
 	else
 		elf_hwcap |= HWCAP_ASIMD;
-- 
2.5.0
