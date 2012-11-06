From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 6 Nov 2012 14:38:35 -0800
Subject: [PATCH 11/16] mm: use vm_unmapped_area() on arm architecture
In-Reply-To: <1352155633-8648-12-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-12-git-send-email-walken@google.com>
Message-ID: <20121106143835.3e321da4.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Nov 2012 14:47:08 -0800
Michel Lespinasse <walken@google.com> wrote:

> Update the arm arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.

Again,

--- a/arch/arm/mm/mmap.c~mm-use-vm_unmapped_area-on-arm-architecture-fix
+++ a/arch/arm/mm/mmap.c
@@ -11,18 +11,6 @@
 #include <linux/random.h>
 #include <asm/cachetype.h>
 
-static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
-					      unsigned long pgoff)
-{
-	unsigned long base = addr & ~(SHMLBA-1);
-	unsigned long off = (pgoff << PAGE_SHIFT) & (SHMLBA-1);
-
-	if (base + off <= addr)
-		return base + off;
-
-	return base - off;
-}
-
 #define COLOUR_ALIGN(addr,pgoff)		\
 	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
 	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
_
