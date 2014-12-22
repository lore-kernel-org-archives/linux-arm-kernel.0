From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Mon, 22 Dec 2014 12:17:29 +0900
Subject: [PATCH v2] ARM: mm: fix size rounding-down of arm_add_memory()
 function
Message-ID: <1419218249-5744-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current rounding of "size" is wrong:

 - If "start" is sufficiently near the next page boundary, "size"
   is decremented by more than enough and the last page is lost.

 - If "size" is sufficiently small, it is wrapped around and gets
   a bogus value.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---

Changes in v2:
 - Avoid wrap around of "size"

 arch/arm/kernel/setup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f9c8639..d13f185 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -657,10 +657,13 @@ int __init arm_add_memory(u64 start, u64 size)
 
 	/*
 	 * Ensure that start/size are aligned to a page boundary.
-	 * Size is appropriately rounded down, start is rounded up.
+	 * Size is rounded down, start is rounded up.
 	 */
-	size -= start & ~PAGE_MASK;
 	aligned_start = PAGE_ALIGN(start);
+	if (aligned_start > start + size)
+		size = 0;
+	else
+		size -= aligned_start - start;
 
 #ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
 	if (aligned_start > ULONG_MAX) {
-- 
1.9.1
