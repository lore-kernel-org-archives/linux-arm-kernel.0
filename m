From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:21 -0400
Subject: [PATCH 6/9] ARM: zImage: simplify decompress_kernel()
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The return value for decompress_kernel() is no longer used.  Furthermore,
this was obtained and stored in a variable called output_ptr which is
a complete misnomer for what is actually the size of the decompressed
kernel image.  Let's get rid of it.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/misc.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 4657e87..51b87b5 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -26,8 +26,6 @@ unsigned int __machine_arch_type;
 #include <linux/linkage.h>
 #include <asm/string.h>
 
-#include <asm/unaligned.h>
-
 
 static void putstr(const char *ptr);
 extern void error(char *x);
@@ -149,13 +147,12 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
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
@@ -183,13 +180,11 @@ asmlinkage void __div0(void)
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
@@ -197,12 +192,8 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 
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
