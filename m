From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:11 +0100
Subject: [PATCH 02/10] arm64: proc: de-scope TLBI operation during cold boot
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When cold-booting a CPU, we must invalidate any junk entries from the
local TLB prior to enabling the MMU. This doesn't require broadcasting
within the inner-shareable domain, so de-scope the operation to apply
only to the local CPU.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/proc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index e4ee7bd8830a..bbde13d77da5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -146,8 +146,8 @@ ENDPROC(cpu_do_switch_mm)
  *	value of the SCTLR_EL1 register.
  */
 ENTRY(__cpu_setup)
-	tlbi	vmalle1is			// invalidate I + D TLBs
-	dsb	ish
+	tlbi	vmalle1				// Invalidate local TLB
+	dsb	nsh
 
 	mov	x0, #3 << 20
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
-- 
2.1.4
