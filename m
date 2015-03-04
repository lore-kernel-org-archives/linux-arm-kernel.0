From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Mar 2015 12:23:17 +0100
Subject: [PATCH v2 3/3] arm64: remove __lookup_processor_type_data object from
 head.S
In-Reply-To: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1425468197-22377-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes __lookup_processor_type_data, replacing the original
use with a simple PC-relative address load.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e6216b56257a..89444070f96b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -714,15 +714,10 @@ ENDPROC(__error)
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
+	adrp	x3, cpu_table
+	add	x3, x3, :lo12:cpu_table
 1:
 	ldp	w5, w6, [x3]			// load cpu_id_val and cpu_id_mask
 	cbz	w5, 2f				// end of list?
@@ -737,10 +732,3 @@ ENTRY(lookup_processor_type)
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
