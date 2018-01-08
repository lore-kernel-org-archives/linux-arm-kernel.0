From: james.morse@arm.com (James Morse)
Date: Mon,  8 Jan 2018 15:38:17 +0000
Subject: [PATCH v6 15/16] arm64: mmu: add the entry trampolines start/end
 section markers into sections.h
In-Reply-To: <20180108153818.22743-1-james.morse@arm.com>
References: <20180108153818.22743-1-james.morse@arm.com>
Message-ID: <20180108153818.22743-16-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDEI needs to calculate an offset in the trampoline page too. Move
the extern char[] to sections.h.

This patch just moves code around.

Signed-off-by: James Morse <james.morse@arm.com>
---
(fixed typo in commit message)

 arch/arm64/include/asm/sections.h | 1 +
 arch/arm64/mm/mmu.c               | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 941267caa39c..caab039d6305 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -28,5 +28,6 @@ extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
+extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 916d9ced1c3f..9d21835c99d9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -528,8 +528,6 @@ early_param("rodata", parse_rodata);
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __init map_entry_trampoline(void)
 {
-	extern char __entry_tramp_text_start[];
-
 	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
 
-- 
2.15.0
