From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 22:59:09 -0400
Subject: [PATCH 2/6] ARM: plat-omap: make OMAP_UART_INFO into a relative offset
In-Reply-To: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
Message-ID: <1314932353-24813-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first step to remove PLAT_PHYS_OFFSET usage from the debug
UART code.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |    8 +++-----
 arch/arm/mach-omap2/include/mach/debug-macro.S |    9 ++++-----
 arch/arm/plat-omap/include/plat/serial.h       |    6 +++---
 arch/arm/plat-omap/include/plat/uncompress.h   |    8 +++++++-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index f944ae8..6a17118 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -46,11 +46,9 @@ omap_uart_virt:	.word	0x0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
-		ldr	\rp, [\rp, #0]
+		and	\rp, pc, #0xff000000
+		ldr	\rv, =OMAP_UART_INFO_OFS
+		ldr	\rp, [\rp, \rv]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 10:		cmp	\rp, #0			@ no port configured?
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index fbd23ec..745e2ff 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -49,11 +49,10 @@ omap_uart_lsr:	.word	0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
-		ldr	\rp, [\rp, #0]
+		mov	\rp, pc
+		ldr	\rv, =OMAP_UART_INFO_OFS
+		and	\rp, \rp, #0xff000000
+		ldr	\rp, [\rp, \rv]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 		cmp	\rp, #0			@ no port configured?
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..1ab9fd6 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -16,8 +16,8 @@
 #include <linux/init.h>
 
 /*
- * Memory entry used for the DEBUG_LL UART configuration. See also
- * uncompress.h and debug-macro.S.
+ * Memory entry used for the DEBUG_LL UART configuration, relative to
+ * start of RAM. See also uncompress.h and debug-macro.S.
  *
  * Note that using a memory location for storing the UART configuration
  * has at least two limitations:
@@ -27,7 +27,7 @@
  * 2. We assume printascii is called at least once before paging_init,
  *    and addruart has a chance to read OMAP_UART_INFO
  */
-#define OMAP_UART_INFO		(PLAT_PHYS_OFFSET + 0x3ffc)
+#define OMAP_UART_INFO_OFS	0x3ffc
 
 /* OMAP1 serial ports */
 #define OMAP1_UART1_BASE	0xfffb0000
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index a067484..71763db 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -36,7 +36,13 @@ int uart_shift;
  */
 static void set_omap_uart_info(unsigned char port)
 {
-	*(volatile u32 *)OMAP_UART_INFO = port;
+	/* 
+	 * Get address of some.bss variable and round it down 
+	 * a la CONFIG_AUTO_ZRELADDR.
+	 */
+	u32 ram_start = (u32)&uart_shift & 0xf8000000;
+	u32 *uart_info = (u32 *)(ram_start + OMAP_UART_INFO_OFS);
+	*uart_info = port;
 }
 
 static void putc(int c)
-- 
1.7.4
