From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 17:44:18 +0000
Subject: [PATCH] arm64: use const cap for system_uses_ttbr0_pan()
Message-ID: <1489167858-24867-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 4b65a5db362783ab ("arm64: Introduce
uaccess_{disable,enable} functionality based on TTBR0_EL1"),
system_uses_ttbr0_pan() has used cpus_have_cap() to determine whether
PAN is present.

Since commit a4023f682739439b ("arm64: Add hypervisor safe helper for
checking constant capabilities"), which was introduced around the same
time, cpus_have_cap() doesn't try to use a static key, and must always
perform a load, test, and consitional branch (likely a tbnz for the
latter two).

Elsewhere, we moved to using cpus_have_const_cap(), which can use a
static key (i.e. a non-conditional branch), which is patched at runtime
when the feature is detected.

This patch makes system_uses_ttbr0_pan() use cpus_have_const_cap(). The
static key is likely a win for hot-paths like the uacccess primitives,
and this makes our usage consistent regardless.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 05310ad..f31c48d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -251,7 +251,7 @@ static inline bool system_supports_fpsimd(void)
 static inline bool system_uses_ttbr0_pan(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN) &&
-		!cpus_have_cap(ARM64_HAS_PAN);
+		!cpus_have_const_cap(ARM64_HAS_PAN);
 }
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.1
