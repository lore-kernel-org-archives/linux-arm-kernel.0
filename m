From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Mar 2015 20:11:28 +0100
Subject: [PATCH v3 4/4] arm64: remove __lookup_processor_type_data,
 object from head.S
In-Reply-To: <1425496288-14483-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425496288-14483-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1425496288-14483-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes __lookup_processor_type_data, replacing the original
user with a simple PC-relative address load.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2b60b587a70f..cd3b94cb597f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -709,15 +709,9 @@ ENDPROC(__error)
  * This function gets the processor ID in w0 and searches the cpu_table[] for
  * a match. It returns a pointer to the struct cpu_info it found. The
  * cpu_table[] must end with an empty (all zeros) structure.
- *
- * This routine can be called via C code and it needs to work with the MMU
- * both disabled and enabled (the offset is calculated automatically).
  */
 ENTRY(lookup_processor_type)
-	adr	x1, __lookup_processor_type_data
-	ldp	x2, x3, [x1]
-	sub	x1, x1, x2			// get offset between VA and PA
-	add	x3, x3, x1			// convert VA to PA
+	adr_l	x3, cpu_table
 1:
 	ldp	w5, w6, [x3]			// load cpu_id_val and cpu_id_mask
 	cbz	w5, 2f				// end of list?
@@ -732,10 +726,3 @@ ENTRY(lookup_processor_type)
 	mov	x0, x3
 	ret
 ENDPROC(lookup_processor_type)
-
-	.align	3
-	.type	__lookup_processor_type_data, %object
-__lookup_processor_type_data:
-	.quad	.
-	.quad	cpu_table
-	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
-- 
1.8.3.2
