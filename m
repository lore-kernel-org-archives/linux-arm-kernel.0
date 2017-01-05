From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Jan 2017 11:20:06 +0900
Subject: [PATCH v2 1/4] m68k: rename UL() to TO_UL()
In-Reply-To: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1483582810-7046-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM, ARM64 and UniCore32 define UL(x) like follows:

  #define UL(x) _AC(x, UL)

While, M68K defines it differently:
  #define UL(x) ((unsigned long) (x))

I am moving the former to a common header in the next commit.
Beforehand, this commit renames the latter to avoid name conflict.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---

Changes in v2:
  - Split out as a prerequisite patch

 arch/m68k/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 9c1e656..a625144 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -121,9 +121,9 @@ void free_initmem(void)
 
 void __init print_memmap(void)
 {
-#define UL(x) ((unsigned long) (x))
-#define MLK(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 10
-#define MLM(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 20
+#define TO_UL(x) ((unsigned long) (x))
+#define MLK(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 10
+#define MLM(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 20
 #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), 1024)
 
 	pr_notice("Virtual kernel memory layout:\n"
-- 
2.7.4
