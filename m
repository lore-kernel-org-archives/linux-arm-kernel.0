From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:22 -0400
Subject: [PATCH 7/9] ARM: zImage: don't ignore error returned from decompress()
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-8-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

If decompress() returns an error without calling error(), we must
not attempt to boot the resulting kernel.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/compressed/decompress.c |    4 ++--
 arch/arm/boot/compressed/misc.c       |   13 +++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 4c72a97..07be5a2 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -44,7 +44,7 @@ extern void error(char *);
 #include "../../../../lib/decompress_unlzma.c"
 #endif
 
-void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
+int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
-	decompress(input, len, NULL, NULL, output, NULL, error);
+	return decompress(input, len, NULL, NULL, output, NULL, error);
 }
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 51b87b5..65871a7 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -177,7 +177,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-extern void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
+extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
 
 
 void
@@ -185,6 +185,8 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p,
 		int arch_id)
 {
+	int ret;
+
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
@@ -193,7 +195,10 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	arch_decomp_setup();
 
 	putstr("Uncompressing Linux...");
-	do_decompress(input_data, input_data_end - input_data,
-			output_data, error);
-	putstr(" done, booting the kernel.\n");
+	ret = do_decompress(input_data, input_data_end - input_data,
+			    output_data, error);
+	if (ret)
+		error("decompressor returned an error");
+	else
+		putstr(" done, booting the kernel.\n");
 }
-- 
1.7.4
