From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:47 +0100
Subject: [PATCH 3/6] arm64: include alternative handling in dcache_by_line_op
In-Reply-To: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462812590-4494-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced dcache_by_line_op macro is used at least in
one occassion at the moment to issue a "dc cvau" instruction,
which is affected by ARM errata 819472, 826319, 827319 and 824069.
Change the macro to allow for alternative patching in there to
protect affected Cortex-A53 cores.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/mm/proc-macros.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
index e6a30e1..5786017 100644
--- a/arch/arm64/mm/proc-macros.S
+++ b/arch/arm64/mm/proc-macros.S
@@ -78,7 +78,14 @@
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
-9998:	dc	\op, \kaddr
+9998:
+	alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE, (\op == cvau || \op == cvac)
+	dc	\op, \kaddr
+	.if	(\op == cvau || \op == cvac)
+	alternative_else
+	dc	civac, \kaddr
+	alternative_endif
+	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
-- 
2.7.3
