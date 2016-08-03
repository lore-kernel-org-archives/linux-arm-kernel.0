From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Aug 2016 17:38:44 +0200
Subject: [PATCH 2/8] ARM: head-common.S: use PC-relative insn sequence for
 __proc_info
In-Reply-To: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1470238730-30038-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the open coded PC relative offset calculations with adr_l
invocations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/head-common.S | 22 ++++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 8733012d231f..5e0cedd870a5 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -150,11 +150,12 @@ ENDPROC(lookup_processor_type)
  *	r9 = cpuid (preserved)
  */
 __lookup_processor_type:
-	adr	r3, __lookup_processor_type_data
-	ldmia	r3, {r4 - r6}
-	sub	r3, r3, r4			@ get offset between virt&phys
-	add	r5, r5, r3			@ convert virt addresses to
-	add	r6, r6, r3			@ physical address space
+	/*
+	 * Look in <asm/procinfo.h> for information about the __proc_info
+	 * structure.
+	 */
+	adr_l	r5, __proc_info_begin		@ __pa(__proc_info_begin)
+	adr_l	r6, __proc_info_end		@ __pa(__proc_info_end)
 1:	ldmia	r5, {r3, r4}			@ value, mask
 	and	r4, r4, r9			@ mask wanted bits
 	teq	r3, r4
@@ -166,17 +167,6 @@ __lookup_processor_type:
 2:	ret	lr
 ENDPROC(__lookup_processor_type)
 
-/*
- * Look in <asm/procinfo.h> for information about the __proc_info structure.
- */
-	.align	2
-	.type	__lookup_processor_type_data, %object
-__lookup_processor_type_data:
-	.long	.
-	.long	__proc_info_begin
-	.long	__proc_info_end
-	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
-
 __error_lpae:
 #ifdef CONFIG_DEBUG_LL
 	adr	r0, str_lpae
-- 
2.7.4
