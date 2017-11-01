From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 2 Nov 2017 03:14:55 +0800
Subject: [PATCH v1 1/3] arm64: add a macro for SError synchronization
In-Reply-To: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1509563697-6359-2-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 adds a control bit to each SCTLR_ELx to insert implicit
Error Synchronization Barrier(IESB) operations at exception handler entry
and exit. But not all hardware platform which support RAS Extension
can support IESB. So for this case, software needs to manually insert
Error Synchronization Barrier(ESB) operations.

In this macros, if system supports RAS Extensdddon instead of IESB,
it will insert an ESB instruction.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/include/asm/assembler.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d4c0adf..e6c79c4 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -517,4 +517,13 @@
 #endif
 	.endm
 
+	.macro	error_synchronize
+alternative_if ARM64_HAS_IESB
+	b	1f
+alternative_else_nop_endif
+alternative_if ARM64_HAS_RAS_EXTN
+	esb
+alternative_else_nop_endif
+1:
+	.endm
 #endif	/* __ASM_ASSEMBLER_H */
-- 
1.9.1
