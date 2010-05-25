From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 25 May 2010 18:45:47 +0200
Subject: [PATCH] ARM: TCM memory bug on newer compilers
Message-ID: <1274805947-414-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently newer compilers don't like you to refer to linker
symbols as extern char *foo, we must use char foo and refer to
the address of the char instead.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/init.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1ba6cf5..f6a9994 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -678,10 +678,10 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 #ifdef CONFIG_HAVE_TCM
-	extern char *__tcm_start, *__tcm_end;
+	extern char __tcm_start, __tcm_end;
 
-	totalram_pages += free_area(__phys_to_pfn(__pa(__tcm_start)),
-				    __phys_to_pfn(__pa(__tcm_end)),
+	totalram_pages += free_area(__phys_to_pfn(__pa(&__tcm_start)),
+				    __phys_to_pfn(__pa(&__tcm_end)),
 				    "TCM link");
 #endif
 
-- 
1.6.3.3
