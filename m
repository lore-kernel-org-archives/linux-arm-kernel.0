From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:23 -0400
Subject: [PATCH 8/9] ARM: zImage: remove the static qualifier from global data
	variables
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-9-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

To be able to relocate the .bss section at run time independently from
the rest of the code, we must make sure that no GOTOFF relocations are
used with .bss symbols.  This usually means that no global variables can
be marked static unless they're also const.

Let's remove the static qualifier from current offenders, or turn them
into const variables when possible.  Next commit will ensure the build
fails if one of those is reintroduced due to otherwise enforced coding
standards for the kernel.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/include/mach/uncompress.h |    5 +++--
 arch/arm/mach-gemini/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-iop32x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-iop33x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-ixp4xx/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-mmp/include/mach/uncompress.h     |    2 +-
 arch/arm/mach-mxs/include/mach/uncompress.h     |    2 +-
 arch/arm/mach-ns9xxx/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-nuc93x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-pxa/include/mach/uncompress.h     |    6 +++---
 arch/arm/mach-rpc/include/mach/uncompress.h     |   12 ++++++------
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |    6 +++---
 arch/arm/mach-ux500/include/mach/uncompress.h   |    2 +-
 arch/arm/mach-w90x900/include/mach/uncompress.h |    2 +-
 arch/arm/plat-mxc/include/mach/uncompress.h     |    2 +-
 arch/arm/plat-omap/include/plat/uncompress.h    |    4 ++--
 arch/arm/plat-samsung/include/plat/uncompress.h |    4 ++--
 17 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 47723e8..78d8068 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -25,8 +25,7 @@
 
 #include <mach/serial.h>
 
-static u32 *uart;
-static u32 *uart_info = (u32 *)(DAVINCI_UART_INFO);
+u32 *uart;
 
 /* PORT_16C550A, in polled non-fifo mode */
 static void putc(char c)
@@ -44,6 +43,8 @@ static inline void flush(void)
 
 static inline void set_uart_info(u32 phys, void * __iomem virt)
 {
+	u32 *uart_info = (u32 *)(DAVINCI_UART_INFO);
+
 	uart = (u32 *)phys;
 	uart_info[0] = phys;
 	uart_info[1] = (u32)virt;
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index 5483f61..0efa262 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -16,7 +16,7 @@
 #include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-static volatile unsigned long *UART = (unsigned long *)GEMINI_UART_BASE;
+static volatile unsigned long * const UART = (unsigned long *)GEMINI_UART_BASE;
 
 /*
  * The following code assumes the serial port has already been
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index b247551..4fd7154 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -7,7 +7,7 @@
 #include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-static volatile u8 *uart_base;
+volatile u8 *uart_base;
 
 #define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
 
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index b42423f..f99bb84 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -7,7 +7,7 @@
 #include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-static volatile u32 *uart_base;
+volatile u32 *uart_base;
 
 #define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 2db0078..219d7c1 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -19,7 +19,7 @@
 
 #define TX_DONE (UART_LSR_TEMT|UART_LSR_THRE)
 
-static volatile u32* uart_base;
+volatile u32* uart_base;
 
 static inline void putc(int c)
 {
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index 85bd8a2..d6daeb7 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -14,7 +14,7 @@
 #define UART2_BASE	(APB_PHYS_BASE + 0x17000)
 #define UART3_BASE	(APB_PHYS_BASE + 0x18000)
 
-static volatile unsigned long *UART;
+volatile unsigned long *UART;
 
 static inline void putc(char c)
 {
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index f12a173..7f8bf65 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -20,7 +20,7 @@
 
 #include <asm/mach-types.h>
 
-static unsigned long mxs_duart_base;
+unsigned long mxs_duart_base;
 
 #define MXS_DUART(x)	(*(volatile unsigned long *)(mxs_duart_base + (x)))
 
diff --git a/arch/arm/mach-ns9xxx/include/mach/uncompress.h b/arch/arm/mach-ns9xxx/include/mach/uncompress.h
index 770a68c..00ef4a6 100644
--- a/arch/arm/mach-ns9xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-ns9xxx/include/mach/uncompress.h
@@ -20,7 +20,7 @@ static void putc_dummy(char c, void __iomem *base)
 	/* nothing */
 }
 
-static int timeout;
+int timeout;
 
 static void putc_ns9360(char c, void __iomem *base)
 {
diff --git a/arch/arm/mach-nuc93x/include/mach/uncompress.h b/arch/arm/mach-nuc93x/include/mach/uncompress.h
index 73082cd..381cb9b 100644
--- a/arch/arm/mach-nuc93x/include/mach/uncompress.h
+++ b/arch/arm/mach-nuc93x/include/mach/uncompress.h
@@ -27,7 +27,7 @@
 #define arch_decomp_wdog()
 
 #define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
-static u32 * uart_base = (u32 *)UART0_PA;
+static u32 * const uart_base = (u32 *)UART0_PA;
 
 static void putc(int ch)
 {
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 759b851..5519a34 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -16,9 +16,9 @@
 #define BTUART_BASE	(0x40200000)
 #define STUART_BASE	(0x40700000)
 
-static unsigned long uart_base;
-static unsigned int uart_shift;
-static unsigned int uart_is_pxa;
+unsigned long uart_base;
+unsigned int uart_shift;
+unsigned int uart_is_pxa;
 
 static inline unsigned char uart_read(int offset)
 {
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 8c9e2c7..9cd9bcd 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -66,12 +66,12 @@ extern __attribute__((pure)) struct param_struct *params(void);
 #define params (params())
 
 #ifndef STANDALONE_DEBUG 
-static unsigned long video_num_cols;
-static unsigned long video_num_rows;
-static unsigned long video_x;
-static unsigned long video_y;
-static unsigned char bytes_per_char_v;
-static int white;
+unsigned long video_num_cols;
+unsigned long video_num_rows;
+unsigned long video_x;
+unsigned long video_y;
+unsigned char bytes_per_char_v;
+int white;
 
 /*
  * This does not append a newline
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index c65b229..1608faf 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -24,8 +24,8 @@ typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
 
 /* uart setup */
 
-static unsigned int fifo_mask;
-static unsigned int fifo_max;
+unsigned int fifo_mask;
+unsigned int fifo_max;
 
 /* forward declerations */
 
@@ -43,7 +43,7 @@ static void arch_detect_cpu(void);
 /* how many bytes we allow into the FIFO at a time in FIFO mode */
 #define FIFO_MAX	 (14)
 
-static unsigned long uart_base;
+unsigned long uart_base;
 
 static __inline__ void get_uart_base(void)
 {
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index ab0fe14..088b550 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -24,7 +24,7 @@
 #include <linux/amba/serial.h>
 #include <mach/hardware.h>
 
-static u32 ux500_uart_base;
+u32 ux500_uart_base;
 
 static void putc(const char c)
 {
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 56f1a74..0313021 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -27,7 +27,7 @@
 #define arch_decomp_wdog()
 
 #define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
-static volatile u32 * uart_base = (u32 *)UART0_PA;
+static volatile u32 * const uart_base = (u32 *)UART0_PA;
 
 static void putc(int ch)
 {
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 4864b0a..d85e2d1 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -21,7 +21,7 @@
 
 #include <asm/mach-types.h>
 
-static unsigned long uart_base;
+unsigned long uart_base;
 
 #define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
 
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 30b891c..565d266 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -27,8 +27,8 @@
 
 #define MDR1_MODE_MASK			0x07
 
-static volatile u8 *uart_base;
-static int uart_shift;
+volatile u8 *uart_base;
+int uart_shift;
 
 /*
  * Store the DEBUG_LL uart number into memory.
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 7d6ed72..ee48e12 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -18,8 +18,8 @@ typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
 
 /* uart setup */
 
-static unsigned int fifo_mask;
-static unsigned int fifo_max;
+unsigned int fifo_mask;
+unsigned int fifo_max;
 
 /* forward declerations */
 
-- 
1.7.4
