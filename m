From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Oct 2013 18:31:32 -0700
Subject: [RFC PATCH 5/5] arm: Don't free init text if CONFIG_STRICT_MEMORY_RWX
 is enabled
In-Reply-To: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1381282292-25251-6-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_STRICT_MEMORY_RWX makes the text section be RX only. This
is incompatible with freeing the text back to general memory.
Skip the text free when freeing initmem. This does result in
less memory freed back into the system but we cannot easily
change the protections on the text section back to RWNX.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
---
 arch/arm/mm/init.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15225d8..a23c99c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -681,6 +681,9 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	unsigned long reclaimed_initmem;
+#endif
 #ifdef CONFIG_HAVE_TCM
 	extern char __tcm_start, __tcm_end;
 
@@ -688,9 +691,18 @@ void free_initmem(void)
 	free_reserved_area(&__tcm_start, &__tcm_end, -1, "TCM link");
 #endif
 
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	poison_init_mem((char *)__arch_info_begin,
+		__init_end - (char *)__arch_info_begin);
+	reclaimed_initmem = free_reserved_area(__arch_info_begin,
+					__init_end, -1,
+				    "init");
+	totalram_pages += reclaimed_initmem;
+#else
 	poison_init_mem(__init_begin, __init_end - __init_begin);
 	if (!machine_is_integrator() && !machine_is_cintegrator())
 		free_initmem_default(-1);
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
