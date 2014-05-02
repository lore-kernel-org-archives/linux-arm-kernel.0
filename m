From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:13 +0100
Subject: [PATCH 6/8] arm64: head: fix cache flushing and barriers in
 set_cpu_boot_mode_flag
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_cpu_boot_mode_flag is used to identify which exception levels are
encountered across the system by CPUs trying to enter the kernel. The
basic algorithm is: if a CPU is booting at EL2, it will set a flag at
an offset of #4 from __boot_cpu_mode, a cacheline-aligned variable.
Otherwise, a flag is set at an offset of zero into the same cacheline.
This enables us to check that all CPUs booted at the same exception
level.

This cacheline is written with the stage-1 MMU off (that is, via a
strongly-ordered mapping) and will bypass any clean lines in the cache,
leading to potential coherence problems when the variable is later
checked via the normal, cacheable mapping of the kernel image.

This patch reworks the broken flushing code so that we:

  (1) Use a DMB to order the strongly-ordered write of the cacheline
      against the subsequent cache-maintenance operation (by-VA
      operations only hazard against normal, cacheable accesses).

  (2) Use a single dc ivac instruction to invalidate any clean lines
      containing a stale copy of the line after it has been updated.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0fd565000772..b96a732e4859 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -230,11 +230,9 @@ ENTRY(set_cpu_boot_mode_flag)
 	cmp	w20, #BOOT_CPU_MODE_EL2
 	b.ne	1f
 	add	x1, x1, #4
-1:	dc	cvac, x1			// Clean potentially dirty cache line
-	dsb	sy
-	str	w20, [x1]			// This CPU has booted in EL1
-	dc	civac, x1			// Clean&invalidate potentially stale cache line
-	dsb	sy
+1:	str	w20, [x1]			// This CPU has booted in EL1
+	dmb	sy
+	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
 ENDPROC(set_cpu_boot_mode_flag)
 
-- 
1.9.2
