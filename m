From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:14:58 +0200
Subject: [RFC v3 PATCH 2/7] ARM: port NEON version of xor_blocks() to new
 kmode NEON api
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now permissible to use the NEON in non-process context, so
update the XOR code so it uses the NEON version even in non-process
context.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/xor.h | 48 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index 4ffb26d..1bda8b5 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -151,52 +151,44 @@ extern struct xor_block_template const xor_block_neon_inner;
 static void
 xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_2(bytes, p1, p2);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_2(bytes, p1, p2);
-		kernel_neon_end();
-	}
+	DEFINE_NEON_REGSTACK(s);
+
+	kernel_neon_begin(s);
+	xor_block_neon_inner.do_2(bytes, p1, p2);
+	kernel_neon_end(s);
 }
 
 static void
 xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 		unsigned long *p3)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_3(bytes, p1, p2, p3);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_3(bytes, p1, p2, p3);
-		kernel_neon_end();
-	}
+	DEFINE_NEON_REGSTACK(s);
+
+	kernel_neon_begin(s);
+	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
+	kernel_neon_end(s);
 }
 
 static void
 xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 		unsigned long *p3, unsigned long *p4)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_4(bytes, p1, p2, p3, p4);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
-		kernel_neon_end();
-	}
+	DEFINE_NEON_REGSTACK(s);
+
+	kernel_neon_begin(s);
+	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end(s);
 }
 
 static void
 xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 		unsigned long *p3, unsigned long *p4, unsigned long *p5)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_5(bytes, p1, p2, p3, p4, p5);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
-		kernel_neon_end();
-	}
+	DEFINE_NEON_REGSTACK(s);
+
+	kernel_neon_begin(s);
+	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end(s);
 }
 
 static struct xor_block_template xor_block_neon = {
-- 
1.8.1.2
