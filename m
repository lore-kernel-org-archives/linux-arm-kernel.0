From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Mar 2015 16:14:35 +0000
Subject: [PATCH 2/4] arm64: head.S: fix __boot_cpu_mode alignment
In-Reply-To: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1426263277-9827-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently align the allocation of the __boot_cpu_mode data _after_
allocating the label. Thus the label may point to padding before the
data. While we seem to have gotten away with this so far, it's not a
good idea to rely on any existing alignment in the object.

Perform the alignment padding before allocating the label to avoid this
possibility.

Fixes: c218bca74eeafa2f ("arm64: Relax the kernel cache requirements for boot")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 8ce88e0..07f9305 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -585,8 +585,8 @@ ENDPROC(set_cpu_boot_mode_flag)
  * zeroing of .bss would clobber it.
  */
 	.pushsection	.data..cacheline_aligned
-ENTRY(__boot_cpu_mode)
 	.align	L1_CACHE_SHIFT
+ENTRY(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL2
 	.long	0
 	.popsection
-- 
1.9.1
