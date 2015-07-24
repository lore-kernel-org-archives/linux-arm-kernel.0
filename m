From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:41:57 +0100
Subject: [PATCH v2 06/20] arm64: alternatives: add cpu feature for lse atomics
In-Reply-To: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
Message-ID: <1437734531-10698-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CPU feature for the LSE atomic instructions, so that they can be
patched in at runtime when we detect that they are supported.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 3 ++-
 arch/arm64/kernel/setup.c           | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index eb09f1ee8036..d58db9d3b4fa 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -25,8 +25,9 @@
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
 #define ARM64_WORKAROUND_845719			2
 #define ARM64_HAS_SYSREG_GIC_CPUIF		3
+#define ARM64_CPU_FEAT_LSE_ATOMICS		4
 
-#define ARM64_NCAPS				4
+#define ARM64_NCAPS				5
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c7fd2c946374..5b170df96aaf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -286,6 +286,7 @@ static void __init setup_processor(void)
 		default:
 		case 2:
 			elf_hwcap |= HWCAP_ATOMICS;
+			cpus_set_cap(ARM64_CPU_FEAT_LSE_ATOMICS);
 		case 1:
 			/* RESERVED */
 		case 0:
-- 
2.1.4
