From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Jun 2016 18:07:28 +0100
Subject: [PATCH v2 2/6] arm64: fix "dc cvau" cache operation on
 errata-affected core
In-Reply-To: <20160628170732.523-1-andre.przywara@arm.com>
References: <20160628170732.523-1-andre.przywara@arm.com>
Message-ID: <20160628170732.523-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM errata 819472, 826319, 827319 and 824069 for affected
Cortex-A53 cores demand to promote "dc cvau" instructions to
"dc civac" as well.
Attribute the usage of the instruction in __flush_cache_user_range
to also be covered by our alternative patching efforts.
For that we introduce an assembly macro which both deals with
alternatives while still tagging the instructions as USER.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/alternative.h | 4 ++++
 arch/arm64/mm/cache.S                | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 7288071..8746ff6 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -133,6 +133,10 @@ void apply_alternatives(void *start, size_t length);
 #define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
 	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
 
+.macro user_alt, label, oldinstr, newinstr, cond
+9999:	alternative_insn "\oldinstr", "\newinstr", \cond
+	_ASM_EXTABLE 9999b, \label
+.endm
 
 /*
  * Generate the assembly for UAO alternatives with exception table entries.
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 50ff9ba..07d7352 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -52,7 +52,7 @@ ENTRY(__flush_cache_user_range)
 	sub	x3, x2, #1
 	bic	x4, x0, x3
 1:
-USER(9f, dc	cvau, x4	)		// clean D line to PoU
+user_alt 9f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	add	x4, x4, x2
 	cmp	x4, x1
 	b.lo	1b
-- 
2.9.0
