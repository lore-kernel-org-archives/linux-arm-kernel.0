From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:42 +0200
Subject: [RFC PATCH 12/15] ARM: uncompress.h: make the ucuart driver the
	default implementation
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-12-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As most of the machines now use the ucuart driver, let's make
this the default implementation, and mark those which do not
conform with ARCH_UCUART_NONGENERIC.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/print.c                   |    2 +-
 arch/arm/mach-at91/include/mach/uncompress.h       |    9 +++------
 arch/arm/mach-bcmring/include/mach/uncompress.h    |    1 -
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    2 --
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    2 --
 arch/arm/mach-davinci/include/mach/uncompress.h    |    2 --
 arch/arm/mach-dove/include/mach/uncompress.h       |    2 --
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-footbridge/include/mach/uncompress.h |    2 --
 arch/arm/mach-gemini/include/mach/uncompress.h     |    2 --
 arch/arm/mach-h720x/include/mach/uncompress.h      |    2 --
 arch/arm/mach-integrator/include/mach/uncompress.h |    2 --
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    2 --
 arch/arm/mach-iop32x/include/mach/uncompress.h     |    2 --
 arch/arm/mach-iop33x/include/mach/uncompress.h     |    2 --
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |    3 ---
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |    2 --
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    2 --
 arch/arm/mach-ks8695/include/mach/uncompress.h     |    2 --
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    2 --
 arch/arm/mach-msm/include/mach/uncompress.h        |    2 --
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    4 ----
 arch/arm/mach-netx/include/mach/uncompress.h       |    2 --
 arch/arm/mach-nomadik/include/mach/uncompress.h    |    2 --
 arch/arm/mach-orion5x/include/mach/uncompress.h    |    2 --
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |    1 +
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |    1 -
 arch/arm/mach-prima2/include/mach/uncompress.h     |    2 --
 arch/arm/mach-pxa/include/mach/uncompress.h        |    2 --
 arch/arm/mach-realview/include/mach/uncompress.h   |    1 -
 arch/arm/mach-rpc/include/mach/uncompress.h        |    4 +++-
 arch/arm/mach-s3c2410/include/mach/uncompress.h    |    2 ++
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |    2 ++
 arch/arm/mach-s5pc100/include/mach/uncompress.h    |    2 ++
 arch/arm/mach-s5pv210/include/mach/uncompress.h    |    1 +
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    8 --------
 arch/arm/mach-shark/include/mach/uncompress.h      |    3 ---
 arch/arm/mach-shmobile/include/mach/uncompress.h   |    2 ++
 arch/arm/mach-tegra/include/mach/uncompress.h      |    2 --
 arch/arm/mach-u300/include/mach/uncompress.h       |    2 --
 arch/arm/mach-versatile/include/mach/uncompress.h  |    2 --
 arch/arm/mach-vexpress/include/mach/uncompress.h   |    2 --
 arch/arm/mach-vt8500/include/mach/uncompress.h     |    2 --
 arch/arm/mach-zynq/include/mach/uncompress.h       |    2 --
 arch/arm/plat-samsung/include/plat/uncompress.h    |    2 ++
 arch/arm/plat-spear/include/plat/uncompress.h      |    2 --
 arch/arm/plat-tcc/include/mach/uncompress.h        |    2 --
 49 files changed, 19 insertions(+), 92 deletions(-)

diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
index 24a08d4..1529d15 100644
--- a/arch/arm/boot/compressed/print.c
+++ b/arch/arm/boot/compressed/print.c
@@ -54,7 +54,7 @@ struct uncompress_uart ucuart;
 
 #include <mach/uncompress.h>
 
-#ifdef ARCH_HAVE_UCUART_GENERIC
+#ifndef ARCH_UCUART_NONGENERIC
 
 #include <linux/io.h>
 #include <linux/serial_reg.h>
diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 46acdd5..59c1c68 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -21,7 +21,6 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-#include <linux/io.h>
 #include <linux/atmel_serial.h>
 
 #if defined(CONFIG_AT91_EARLY_DBGU)
@@ -38,7 +37,8 @@
 #define UART_OFFSET AT91_USART4
 #elif defined(CONFIG_AT91_EARLY_USART5)
 #define UART_OFFSET AT91_USART5
-#endif
+#elif
+#define UART_OFFSET 0
 
 /*
  * The following code assumes the serial port has already been
@@ -47,9 +47,6 @@
  *
  * This does not append a newline
  */
-#ifdef UART_OFFSET
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(UART_OFFSET, 0, UCUART_IO_MEM32, ATMEL_US_THR,
@@ -57,4 +54,4 @@ static inline void arch_decomp_setup(void)
 			ATMEL_US_CSR, ATMEL_US_TXEMPTY, ATMEL_US_TXEMPTY);
 }
 
-#endif /* UART_OFFSET */
+#endif
\ No newline at end of file
diff --git a/arch/arm/mach-bcmring/include/mach/uncompress.h b/arch/arm/mach-bcmring/include/mach/uncompress.h
index 7e44ad3..125f7b4 100644
--- a/arch/arm/mach-bcmring/include/mach/uncompress.h
+++ b/arch/arm/mach-bcmring/include/mach/uncompress.h
@@ -16,7 +16,6 @@
 #define BCMRING_UART_0_DR	MM_ADDR_IO_UARTA
 #define BCMRING_UART_0_FR	0x18
 
-#define ARCH_HAVE_UCUART_GENERIC
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(MM_ADDR_IO_UARTA, 0, UCUART_IO_MEM32, BCMRING_UART_0_DR,
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index ba17cc6..c0fadf2 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -28,8 +28,6 @@
 #define UARTDRx	UARTDR1
 #endif
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(CLPS7111_PHYS_BASE, 0, UCUART_IO_MEM32, UARTDRx,
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index 93cdbd6..35be756 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -10,8 +10,6 @@
 #include <asm/mach-types.h>
 #include <mach/cns3xxx.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	if (machine_is_cns3420vb())
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index daa318d..ca9308a 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -24,8 +24,6 @@
 
 #include <mach/serial.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void set_uart_info(u32 phys, void * __iomem virt)
 {
 	/*
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 0062a56..97a00eb 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -8,8 +8,6 @@
 
 #include <mach/dove.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(DOVE_UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-ebsa110/include/mach/uncompress.h b/arch/arm/mach-ebsa110/include/mach/uncompress.h
index 56a569f..38c0f7f 100644
--- a/arch/arm/mach-ebsa110/include/mach/uncompress.h
+++ b/arch/arm/mach-ebsa110/include/mach/uncompress.h
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define ARCH_HAVE_UCUART_GENERIC
 
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index 1b36813..b5693c9 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -43,8 +43,6 @@ static void ethernet_reset(void)
 		;
 }
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ethernet_reset();
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
index 32e9654..5f41698 100644
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ b/arch/arm/mach-footbridge/include/mach/uncompress.h
@@ -15,8 +15,6 @@
 #define DC21285_BASE ((volatile unsigned int *)0x42000160)
 #define SER0_BASE    ((volatile unsigned char *)0x7c0003f8)
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	if (machine_is_netwinder())
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index 855eb5b..dd81586 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -15,8 +15,6 @@
 
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(GEMINI_UART_BASE, 2, UCUART_IO_MEM32);
diff --git a/arch/arm/mach-h720x/include/mach/uncompress.h b/arch/arm/mach-h720x/include/mach/uncompress.h
index be44fd1..6f727ba 100644
--- a/arch/arm/mach-h720x/include/mach/uncompress.h
+++ b/arch/arm/mach-h720x/include/mach/uncompress.h
@@ -9,8 +9,6 @@
 
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 /* debug-macro.S treats this port as an AMBA01x, but according to the
  * datasheet, this should be a 8250
  */
diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
index 19f2eb3..57cc838 100644
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ b/arch/arm/mach-integrator/include/mach/uncompress.h
@@ -17,8 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(0x16000000);
diff --git a/arch/arm/mach-iop13xx/include/mach/uncompress.h b/arch/arm/mach-iop13xx/include/mach/uncompress.h
index ac09a33..6c1c385 100644
--- a/arch/arm/mach-iop13xx/include/mach/uncompress.h
+++ b/arch/arm/mach-iop13xx/include/mach/uncompress.h
@@ -1,7 +1,5 @@
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(IOP13XX_UART1_PHYS, 2, UCUART_IO_MEM32);
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index 97fb970..3d970a9 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -3,8 +3,6 @@
  */
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	if (machine_is_iq80321())
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index 294c444..9ee4b3b 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -5,8 +5,6 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	if (machine_is_iq80331() || machine_is_iq80332())
diff --git a/arch/arm/mach-ixp2000/include/mach/uncompress.h b/arch/arm/mach-ixp2000/include/mach/uncompress.h
index dc24c65..e9911fb 100644
--- a/arch/arm/mach-ixp2000/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp2000/include/mach/uncompress.h
@@ -13,9 +13,6 @@
  *  option) any later version.
  *
  */
-
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(0xc0030000, 2, UCUART_IO_MEM32);
diff --git a/arch/arm/mach-ixp23xx/include/mach/uncompress.h b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
index e986753..22cc9f5 100644
--- a/arch/arm/mach-ixp23xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
@@ -13,8 +13,6 @@
 
 #include <mach/ixp23xx.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(IXP23XX_UART1_PHYS, 2, UCUART_IO_MEM32);
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 17b430a..a8d075c 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -16,8 +16,6 @@
 #include "ixp4xx-regs.h"
 #include <asm/mach-types.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	/*
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
index e46c96c..da9f19f 100644
--- a/arch/arm/mach-kirkwood/include/mach/uncompress.h
+++ b/arch/arm/mach-kirkwood/include/mach/uncompress.h
@@ -7,8 +7,6 @@
  */
 #include <mach/kirkwood.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index 9e6ba4e..99cac67 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -16,8 +16,6 @@
 
 #include <mach/regs-uart.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(KS8695_UART_PA, 0, UCUART_MEM32, KS8695_URTH,
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index 61a16eb..0e119c4 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -21,8 +21,6 @@
 
 #include <mach/platform.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(LPC32XX_UART5_BASE, 2, UCUART_IO_MEM32);
diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index d427ce8..0fa9795 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -19,8 +19,6 @@
 #include "linux/io.h"
 #include "mach/msm_iomap.h"
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 #if defined(MSM_DEBUG_UART_PHYS)
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index 720340e..064bb96 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -5,12 +5,8 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/serial_reg.h>
 #include <mach/mv78xx0.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index f61e22b..5a32b87 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -27,8 +27,6 @@
 #define UART1_BASE 0x100a00
 #define UART2_BASE 0x100a80
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(UART1_BASE);
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index 1eb4ae6..f5da290 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -21,8 +21,6 @@
 
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(NOMADIK_UART1_BASE);
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index 1ac83f5..4d7c1ba 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -9,8 +9,6 @@
  */
 #include <mach/orion5x.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
index db46249..9464c63 100644
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -15,6 +15,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#define ARCH_UCUART_NONGENERIC
 #define putc(c)
 #define flush()
 #define arch_decomp_setup()
diff --git a/arch/arm/mach-pnx4008/include/mach/uncompress.h b/arch/arm/mach-pnx4008/include/mach/uncompress.h
index dee85ef..1a18501 100644
--- a/arch/arm/mach-pnx4008/include/mach/uncompress.h
+++ b/arch/arm/mach-pnx4008/include/mach/uncompress.h
@@ -20,7 +20,6 @@
  */
 
 #define UART5_BASE 0x40090000
-#define ARCH_HAVE_UCUART_GENERIC
 
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 14effdc..29ee15e 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -11,8 +11,6 @@
 
 #include <mach/uart.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(SIRFSOC_UART1_PA_BASE, 0, UCUART_IO_MEM32,
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 57f1755..7d24bf1 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -16,8 +16,6 @@
 #define BTUART_BASE	(0x40200000)
 #define STUART_BASE	(0x40700000)
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	unsigned long uart_base;
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/include/mach/uncompress.h
index 899aef7..f69b003 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/include/mach/uncompress.h
@@ -25,7 +25,6 @@
 #include <mach/board-pba8.h>
 #include <mach/board-pbx.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
 static inline void arch_decomp_setup(void)
 {
 	int uart_base;
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 0fd4b0b..4583bd1 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -7,8 +7,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define ARCH_UCUART_NONGENERIC
+
 #define VIDMEM ((char *)SCREEN_START)
- 
+
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-s3c2410/include/mach/uncompress.h b/arch/arm/mach-s3c2410/include/mach/uncompress.h
index 8b283f8..7c98c81 100644
--- a/arch/arm/mach-s3c2410/include/mach/uncompress.h
+++ b/arch/arm/mach-s3c2410/include/mach/uncompress.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
+
 #include <mach/regs-gpio.h>
 #include <mach/map.h>
 
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 00b70b8..0b896fc 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -13,6 +13,8 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
+
 #include <mach/map.h>
 
 /*
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/mach-s5pc100/include/mach/uncompress.h
index 01ccf53..3d67981 100644
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pc100/include/mach/uncompress.h
@@ -15,6 +15,8 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
+
 #include <mach/map.h>
 #include <plat/uncompress.h>
 
diff --git a/arch/arm/mach-s5pv210/include/mach/uncompress.h b/arch/arm/mach-s5pv210/include/mach/uncompress.h
index 08ff2fd..f5454f3 100644
--- a/arch/arm/mach-s5pv210/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pv210/include/mach/uncompress.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
 #include <mach/map.h>
 #include <plat/uncompress.h>
 
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index dc0c8b7..714f957 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -8,14 +8,6 @@
 
 #include "hardware.h"
 
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  We search for the first enabled
- * port in the most probable order.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline int uart_enabled(int base)
 {
 	if (__raw_readl((void __iomem *)(base + UTCR3)) & UTCR3_TXE)
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
index 9900826..cc1ce9b 100644
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ b/arch/arm/mach-shark/include/mach/uncompress.h
@@ -6,9 +6,6 @@
  * arch/arm/mach-footbridge/include/mach/uncompress.h
  * Copyright (C) 1996,1997,1998 Russell King
  */
-
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(0x400003f8, 0, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
index 462e84e..9df3a71 100644
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ b/arch/arm/mach-shmobile/include/mach/uncompress.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_UNCOMPRESS_H
 #define __ASM_MACH_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
+
 /*
  * This does not append a newline
  */
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 61dfd6b..5c3ec5e 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -26,8 +26,6 @@
 
 #include <mach/iomap.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	void __iomem *uart_base = (void*)TEGRA_DEBUG_UART_BASE;
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
index 8bc389a..7f09047 100644
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ b/arch/arm/mach-u300/include/mach/uncompress.h
@@ -17,8 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(0xc0013000);
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
index 14294ef..01390bd 100644
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ b/arch/arm/mach-versatile/include/mach/uncompress.h
@@ -17,8 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(0x101F1000);
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 00c45e5..970eba5 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -17,8 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(0x10009000);
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index 3f7e315..7fb6603 100644
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -14,8 +14,6 @@
  * GNU General Public License for more details.
  *
  */
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(0xd8200000, 0, UCUART_IO_MEM8, 0, 0x1C, 0x2, 0, 0, 0, 0);
diff --git a/arch/arm/mach-zynq/include/mach/uncompress.h b/arch/arm/mach-zynq/include/mach/uncompress.h
index c968774..5eaf93b 100644
--- a/arch/arm/mach-zynq/include/mach/uncompress.h
+++ b/arch/arm/mach-zynq/include/mach/uncompress.h
@@ -18,8 +18,6 @@
 #include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(LL_UART_PADDR, 0, UCUART_IO_MEM32, UART_FIFO_OFFSET,
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 94fecf9..114c6e5 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_PLAT_UNCOMPRESS_H
 #define __ASM_PLAT_UNCOMPRESS_H
 
+#define ARCH_UCUART_NONGENERIC
+
 typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
 
 /* uart setup */
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 1eb0d82..b9d8f6e 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -15,8 +15,6 @@
 #ifndef __PLAT_UNCOMPRESS_H
 #define __PLAT_UNCOMPRESS_H
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(SPEAR_DBG_UART_BASE);
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
index b71a605..23b2b77 100644
--- a/arch/arm/plat-tcc/include/mach/uncompress.h
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -5,8 +5,6 @@
  */
 #include <mach/tcc8k-regs.h>
 
-#define ARCH_HAVE_UCUART_GENERIC
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(UART_BASE_PHYS, 2, UCUART_IO_MEM32);
-- 
1.7.4.1
