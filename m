From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 23:21:59 +0800
Subject: [PATCH 2/2] ARM: use DEBUG_LL infrastructural for multiplatform
 uncompress debug
In-Reply-To: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of providing a dummy uncompress.h and losing the uncompress
debug capability completely for multiplatform build, the patch turns
the uncompress debug into part of DEBUG_LL support.  Thus, when
DEBUG_LL is turned on for a particular platform, uncompress debug works
too for that platform.

To have the uncompress debug work, what most platforms need is only
a putc() implementation.  Meanwhile, DEBUG_LL infrastructural already
has printch() there.  We direct putc() call to printch() by creating
arch/arm/boot/compressed/debug.S which simply includes
arch/arm/kernel/debug.S.

However, there is a problem with above approach.  DEBUG_LL routines
will check MMU enable bit to decide whether physical or virtual address
should be used to access debug port.  In case virtual address needs
to be used, the address returned by addruart will not work for
decompressor who uses a different mapping from what kernel uses.
Fortunately, decompressor uses a flat mapping (same physical and virtual
addresses).  So we can easily work it around by asking platform addruart
return physical address as virtual address when it runs in decompressor.
The macro UNCOMPRESS_DEBUG is defined for this use.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/compressed/Makefile   |    3 +++
 arch/arm/boot/compressed/debug.S    |    3 +++
 arch/arm/include/debug/highbank.S   |    3 +++
 arch/arm/include/debug/imx.S        |    3 +++
 arch/arm/include/debug/mvebu.S      |    3 +++
 arch/arm/include/debug/picoxcell.S  |    3 +++
 arch/arm/include/debug/socfpga.S    |    3 +++
 arch/arm/include/debug/sunxi.S      |    3 +++
 arch/arm/include/debug/tegra.S      |    3 +++
 arch/arm/include/debug/uncompress.h |    8 +++++++-
 arch/arm/include/debug/vexpress.S   |    3 +++
 arch/arm/include/debug/zynq.S       |    3 +++
 12 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/compressed/debug.S

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..c9865f6 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,9 @@ endif
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+ifeq ($(CONFIG_DEBUG_LL),y)
+OBJS	+= debug.o
+endif
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
new file mode 100644
index 0000000..7283d5c
--- /dev/null
+++ b/arch/arm/boot/compressed/debug.S
@@ -0,0 +1,3 @@
+#define UNCOMPRESS_DEBUG
+
+#include "../../kernel/debug.S"
diff --git a/arch/arm/include/debug/highbank.S b/arch/arm/include/debug/highbank.S
index 8cad432..13056cf 100644
--- a/arch/arm/include/debug/highbank.S
+++ b/arch/arm/include/debug/highbank.S
@@ -12,6 +12,9 @@
 		.macro	addruart,rp,rv,tmp
 		ldr	\rv, =0xfee36000
 		ldr	\rp, =0xfff36000
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/imx.S b/arch/arm/include/debug/imx.S
index 619d8cc..257f160 100644
--- a/arch/arm/include/debug/imx.S
+++ b/arch/arm/include/debug/imx.S
@@ -31,6 +31,9 @@
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =UART_PADDR	@ physical
 		ldr	\rv, =UART_VADDR	@ virtual
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
index 865c6d0..2024c1c 100644
--- a/arch/arm/include/debug/mvebu.S
+++ b/arch/arm/include/debug/mvebu.S
@@ -19,6 +19,9 @@
 	ldr	\rv, =ARMADA_370_XP_REGS_VIRT_BASE
 	orr	\rp, \rp, #0x00012000
 	orr	\rv, \rv, #0x00012000
+#ifdef UNCOMPRESS_DEBUG
+	mov	\rv, \rp
+#endif
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/include/debug/picoxcell.S b/arch/arm/include/debug/picoxcell.S
index bc1f07c..0869efc 100644
--- a/arch/arm/include/debug/picoxcell.S
+++ b/arch/arm/include/debug/picoxcell.S
@@ -14,6 +14,9 @@
 		.macro	addruart, rp, rv, tmp
 		ldr	\rv, =PHYS_TO_IO(PICOXCELL_UART1_BASE)
 		ldr	\rp, =PICOXCELL_UART1_BASE
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 #include "8250_32.S"
diff --git a/arch/arm/include/debug/socfpga.S b/arch/arm/include/debug/socfpga.S
index 966b2f9..0298e12 100644
--- a/arch/arm/include/debug/socfpga.S
+++ b/arch/arm/include/debug/socfpga.S
@@ -15,6 +15,9 @@
 		orr	\rp, \rp, #0x00c00000
 		orr	\rv, \rp, #0xfe000000	@ virtual base
 		orr	\rp, \rp, #0xff000000	@ physical base
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 #include "8250_32.S"
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
index 04eb56d..5c40a3a 100644
--- a/arch/arm/include/debug/sunxi.S
+++ b/arch/arm/include/debug/sunxi.S
@@ -21,6 +21,9 @@
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =SUNXI_UART_DEBUG_PHYS_BASE
 	ldr	\rv, =SUNXI_UART_DEBUG_VIRT_BASE
+#ifdef UNCOMPRESS_DEBUG
+	mov	\rv, \rp
+#endif
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/include/debug/tegra.S b/arch/arm/include/debug/tegra.S
index 883d7c2..789fcb4 100644
--- a/arch/arm/include/debug/tegra.S
+++ b/arch/arm/include/debug/tegra.S
@@ -188,6 +188,9 @@
 		/* Load previously selected UART address */
 100:		ldr	\rp, [\tmp, #4]		@ Load tegra_uart_phys
 		ldr	\rv, [\tmp, #8]		@ Load tegra_uart_virt
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 /*
diff --git a/arch/arm/include/debug/uncompress.h b/arch/arm/include/debug/uncompress.h
index e19955d..b142a84 100644
--- a/arch/arm/include/debug/uncompress.h
+++ b/arch/arm/include/debug/uncompress.h
@@ -1,3 +1,9 @@
-static inline void putc(int c) {}
+#ifdef CONFIG_DEBUG_LL
+extern void printch(int c);
+#else
+static inline void printch(int c) {}
+#endif
+
+static inline void putc(int c) { printch(c); }
 static inline void flush(void) {}
 static inline void arch_decomp_setup(void) {}
diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
index dc8e882..5015a01 100644
--- a/arch/arm/include/debug/vexpress.S
+++ b/arch/arm/include/debug/vexpress.S
@@ -43,6 +43,9 @@
 		orrne	\rv, \rp, #DEBUG_LL_VIRT_BASE
 		orrne	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
 
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index f9aa974..2795a64 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -35,6 +35,9 @@
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =LL_UART_PADDR	@ physical
 		ldr	\rv, =LL_UART_VADDR	@ virtual
+#ifdef UNCOMPRESS_DEBUG
+		mov	\rv, \rp
+#endif
 		.endm
 
 		.macro	senduart,rd,rx
-- 
1.7.9.5
