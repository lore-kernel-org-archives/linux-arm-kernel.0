From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 00:15:03 -0400
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value for decompress_kernel() is no longer used.  Furthermore,
this was obtained and stored in a variable called output_ptr which is
a complete misnomer for what is actually the size of the decompressed
kernel image.  Let's get rid of it.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---

BTW, I've yet to understand why, but this patch makes CONFIG_KERNEL_LZMA
work for me.
 
 arch/arm/boot/compressed/misc.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 2df3826..a565853 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -26,8 +26,6 @@ unsigned int __machine_arch_type;
 #include <linux/linkage.h>
 #include <asm/string.h>
 
-#include <asm/unaligned.h>
-
 
 static void putstr(const char *ptr);
 extern void error(char *x);
@@ -139,13 +137,12 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
 }
 
 /*
- * gzip delarations
+ * gzip declarations
  */
 extern char input_data[];
 extern char input_data_end[];
 
 unsigned char *output_data;
-unsigned long output_ptr;
 
 unsigned long free_mem_ptr;
 unsigned long free_mem_end_ptr;
@@ -173,13 +170,11 @@ asmlinkage void __div0(void)
 extern void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
 
 
-unsigned long
+void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p,
 		int arch_id)
 {
-	unsigned char *tmp;
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
@@ -187,12 +182,8 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 
 	arch_decomp_setup();
 
-	tmp = (unsigned char *) (((unsigned long)input_data_end) - 4);
-	output_ptr = get_unaligned_le32(tmp);
-
 	putstr("Uncompressing Linux...");
 	do_decompress(input_data, input_data_end - input_data,
 			output_data, error);
 	putstr(" done, booting the kernel.\n");
-	return output_ptr;
 }
-- 
1.7.4
