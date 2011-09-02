From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 22:59:12 -0400
Subject: [PATCH 5/6] ARM: mach-davinci: make DAVINCI_UART_INFO into a relative
	offset
In-Reply-To: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
Message-ID: <1314932353-24813-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first step to remove PLAT_PHYS_OFFSET usage from the debug
UART code.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/include/mach/debug-macro.S |   21 ++++++++++-----------
 arch/arm/mach-davinci/include/mach/serial.h      |    3 ++-
 arch/arm/mach-davinci/include/mach/uncompress.h  |    7 ++++++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 3cf4c1b..45fff2c 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -50,21 +50,20 @@ davinci_uart_virt:	.word	0
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 
-		/* Copy uart phys address from decompressor uart info */
+		and	\rp, pc, #0xff000000
+		ldr	\rv, =DAVINCI_UART_INFO_OFS
+		add	\rp, \rp, \rv
+
 		ldreq	\rv, =davinci_uart_v2p(davinci_uart_phys)
 		ldrne	\rv, =davinci_uart_phys
-		ldreq	\rp, =DAVINCI_UART_INFO
-		ldrne	\rp, =davinci_uart_p2v(DAVINCI_UART_INFO)
-		ldr	\rp, [\rp, #0]
-		str	\rp, [\rv]
+
+		/* Copy uart phys address from decompressor uart info */
+		ldr	\tmp, [\rp, #0]
+		str	\tmp, [\rv, #0]
 
 		/* Copy uart virt address from decompressor uart info */
-		ldreq	\rv, =davinci_uart_v2p(davinci_uart_virt)
-		ldrne	\rv, =davinci_uart_virt
-		ldreq	\rp, =DAVINCI_UART_INFO
-		ldrne	\rp, =davinci_uart_p2v(DAVINCI_UART_INFO)
-		ldr	\rp, [\rp, #4]
-		str	\rp, [\rv]
+		ldr	\tmp, [\rp, #4]
+		str	\tmp, [\rv, #4]
 
 		b	10b
 99:
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index c9e6ce1..e347d88 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -21,8 +21,9 @@
  * macros in debug-macro.S.
  *
  * This area sits just below the page tables (see arch/arm/kernel/head.S).
+ * We define it as a relative offset from start of usable RAM.
  */
-#define DAVINCI_UART_INFO	(PLAT_PHYS_OFFSET + 0x3ff8)
+#define DAVINCI_UART_INFO_OFS	0x3ff8
 
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 78d8068..9dc7cf9 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -43,7 +43,12 @@ static inline void flush(void)
 
 static inline void set_uart_info(u32 phys, void * __iomem virt)
 {
-	u32 *uart_info = (u32 *)(DAVINCI_UART_INFO);
+	/*
+	 * Get address of some.bss variable and round it down
+	 * a la CONFIG_AUTO_ZRELADDR.
+	 */
+	u32 ram_start = (u32)&uart & 0xf8000000;
+	u32 *uart_info = (u32 *)(ram_start + DAVINCI_UART_INFO_OFS);
 
 	uart = (u32 *)phys;
 	uart_info[0] = phys;
-- 
1.7.4
