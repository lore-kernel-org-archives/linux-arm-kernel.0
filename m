From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Apr 2016 18:48:04 +0200
Subject: [PATCH v2 2/6] arm64: ptdump: add region marker for kasan shadow
 region
In-Reply-To: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1461343688-8552-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Annotate the KASAN shadow region with boundary markers, so that its
mappings stand out in the page table dumper output.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 493461159462..8404190fe2bd 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -23,6 +23,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/fixmap.h>
+#include <asm/kasan.h>
 #include <asm/memory.h>
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
@@ -33,6 +34,10 @@ struct addr_marker {
 };
 
 static const struct addr_marker address_markers[] = {
+#ifdef CONFIG_KASAN
+	{ KASAN_SHADOW_START,		"Kasan shadow start" },
+	{ KASAN_SHADOW_END,		"Kasan shadow end" },
+#endif
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() Area" },
-- 
2.7.4
