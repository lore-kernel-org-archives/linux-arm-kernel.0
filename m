From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed,  2 Sep 2009 19:11:53 +0300
Subject: [PATCH 2/2] ARM: copy_page.S: take into account the size of the cache
	line
In-Reply-To: <1251907913-16261-1-git-send-email-kirill@shutemov.name>
References: <1251907913-16261-1-git-send-email-kirill@shutemov.name>
Message-ID: <1251907913-16261-2-git-send-email-kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimized version of copy_page() was written with assumption that cache
line size is 32 bytes. On Cortex-A8 cache line size is 64 bytes.

This patch tries to generalize copy_page() to work with any cache line
size if cache line size is multiple of 16 and page size is multiple of
two cache line size.

After this optimization we've got ~25% speedup on OMAP3(tested in
userspace).

There is test for kernelspace which trigger copy-on-write after fork():

 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>

 #define BUF_SIZE (10000*4096)
 #define NFORK 200

 int main(int argc, char **argv)
 {
         char *buf = malloc(BUF_SIZE);
         int i;

         memset(buf, 0, BUF_SIZE);

         for(i = 0; i < NFORK; i++) {
                 if (fork()) {
                         wait(NULL);
                 } else {
                         int j;

                         for(j = 0; j < BUF_SIZE; j+= 4096)
                                 buf[j] = (j & 0xFF) + 1;
                         break;
                 }
         }

         free(buf);
         return 0;
 }

Before optimization this test takes ~66 seconds, after optimization
takes ~56 seconds.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/lib/copy_page.S |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/copy_page.S b/arch/arm/lib/copy_page.S
index 6ae04db..2107b4a 100644
--- a/arch/arm/lib/copy_page.S
+++ b/arch/arm/lib/copy_page.S
@@ -13,7 +13,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 
-#define COPY_COUNT (PAGE_SZ/64 PLD( -1 ))
+#define COPY_COUNT (PAGE_SZ/(2 * L1_CACHE_BYTES) PLD( -1 ))
 
 		.text
 		.align	5
@@ -26,17 +26,16 @@
 ENTRY(copy_page)
 		stmfd	sp!, {r4, lr}			@	2
 	PLD(	pld	[r1, #0]		)
-	PLD(	pld	[r1, #32]		)
+	PLD(	pld	[r1, #L1_CACHE_BYTES]		)
 		mov	r2, #COPY_COUNT			@	1
 		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
-1:	PLD(	pld	[r1, #64]		)
-	PLD(	pld	[r1, #96]		)
-2:		stmia	r0!, {r3, r4, ip, lr}		@	4
-		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
-		stmia	r0!, {r3, r4, ip, lr}		@	4
-		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
+1:	PLD(	pld	[r1, #(2*L1_CACHE_BYTES)])
+	PLD(	pld	[r1, #(3*L1_CACHE_BYTES)])
+2:
+	.rept	(2 * (L1_CACHE_BYTES) / 16 - 1)
 		stmia	r0!, {r3, r4, ip, lr}		@	4
 		ldmia	r1!, {r3, r4, ip, lr}		@	4
+	.endr
 		subs	r2, r2, #1			@	1
 		stmia	r0!, {r3, r4, ip, lr}		@	4
 		ldmgtia	r1!, {r3, r4, ip, lr}		@	4
-- 
1.6.3.4
