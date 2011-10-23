From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:40 +0200
Subject: [RFC PATCH 10/15] ARM: uncompress.h: Convert machines to use the new
	ucuart driver
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-10-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally convert the machine-specific uncompress.h files
to use the ucuart driver. This gets rid dozens of
re-implementations for handling an UART.

Samsung stuff needs re-thinking.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-at91/include/mach/uncompress.h       |   24 ++-----
 arch/arm/mach-bcmring/include/mach/uncompress.h    |   29 ++------
 arch/arm/mach-clps711x/include/mach/uncompress.h   |   24 ++------
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |   35 +---------
 arch/arm/mach-davinci/include/mach/uncompress.h    |   24 +------
 arch/arm/mach-dove/include/mach/uncompress.h       |   21 +-----
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |   30 +--------
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |   48 +-------------
 arch/arm/mach-footbridge/include/mach/uncompress.h |   20 ++----
 arch/arm/mach-gemini/include/mach/uncompress.h     |   18 +----
 arch/arm/mach-h720x/include/mach/uncompress.h      |   21 ++----
 arch/arm/mach-integrator/include/mach/uncompress.h |   24 +------
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |   15 +----
 arch/arm/mach-iop32x/include/mach/uncompress.h     |   30 ++-------
 arch/arm/mach-iop33x/include/mach/uncompress.h     |   26 +------
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |   28 +-------
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |   19 +-----
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |   31 +--------
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |   32 +--------
 arch/arm/mach-ks8695/include/mach/uncompress.h     |   16 ++---
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |   31 +--------
 arch/arm/mach-mmp/include/mach/uncompress.h        |   30 +--------
 arch/arm/mach-msm/include/mach/uncompress.h        |   17 ++---
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |   30 +--------
 arch/arm/mach-mxs/include/mach/uncompress.h        |   42 +-----------
 arch/arm/mach-netx/include/mach/uncompress.h       |   42 +-----------
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   32 +--------
 arch/arm/mach-orion5x/include/mach/uncompress.h    |   32 +--------
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |   18 +----
 arch/arm/mach-prima2/include/mach/uncompress.h     |   22 ++-----
 arch/arm/mach-pxa/include/mach/uncompress.h        |   69 +++++---------------
 arch/arm/mach-realview/include/mach/uncompress.h   |   47 +++----------
 arch/arm/mach-sa1100/include/mach/uncompress.h     |   41 ++++++------
 arch/arm/mach-shark/include/mach/uncompress.h      |   36 +---------
 arch/arm/mach-tegra/include/mach/uncompress.h      |   34 ++-------
 arch/arm/mach-u300/include/mach/uncompress.h       |   21 +-----
 arch/arm/mach-ux500/include/mach/uncompress.h      |   31 +--------
 arch/arm/mach-versatile/include/mach/uncompress.h  |   21 +-----
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   27 +-------
 arch/arm/mach-vt8500/include/mach/uncompress.h     |   15 +----
 arch/arm/mach-w90x900/include/mach/uncompress.h    |   21 +------
 arch/arm/mach-zynq/include/mach/uncompress.h       |   25 ++------
 arch/arm/plat-mxc/include/mach/uncompress.h        |   34 +++-------
 arch/arm/plat-omap/include/plat/uncompress.h       |   43 +++---------
 arch/arm/plat-spear/include/plat/uncompress.h      |   19 +-----
 arch/arm/plat-tcc/include/mach/uncompress.h        |   21 +-----
 46 files changed, 227 insertions(+), 1089 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index c644b13..46acdd5 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -47,26 +47,14 @@
  *
  * This does not append a newline
  */
-static void putc(int c)
-{
 #ifdef UART_OFFSET
-	void __iomem *sys = (void __iomem *) UART_OFFSET;	/* physical address */
-
-	while (!(__raw_readl(sys + ATMEL_US_CSR) & ATMEL_US_TXRDY))
-		barrier();
-	__raw_writel(c, sys + ATMEL_US_THR);
-#endif
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-#ifdef UART_OFFSET
-	void __iomem *sys = (void __iomem *) UART_OFFSET;	/* physical address */
-
-	/* wait for transmission to complete */
-	while (!(__raw_readl(sys + ATMEL_US_CSR) & ATMEL_US_TXEMPTY))
-		barrier();
-#endif
+	ucuart_init(UART_OFFSET, 0, UCUART_IO_MEM32, ATMEL_US_THR,
+			ATMEL_US_CSR, ATMEL_US_TXRDY, ATMEL_US_TXRDY,
+			ATMEL_US_CSR, ATMEL_US_TXEMPTY, ATMEL_US_TXEMPTY);
 }
 
-#endif
+#endif /* UART_OFFSET */
diff --git a/arch/arm/mach-bcmring/include/mach/uncompress.h b/arch/arm/mach-bcmring/include/mach/uncompress.h
index 7a365aa..7e44ad3 100644
--- a/arch/arm/mach-bcmring/include/mach/uncompress.h
+++ b/arch/arm/mach-bcmring/include/mach/uncompress.h
@@ -13,28 +13,13 @@
 *****************************************************************************/
 #include <mach/csp/mm_addr.h>
 
-#define BCMRING_UART_0_DR (*(volatile unsigned int *)MM_ADDR_IO_UARTA)
-#define BCMRING_UART_0_FR (*(volatile unsigned int *)(MM_ADDR_IO_UARTA + 0x18))
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	/* Send out UARTA */
-	while (BCMRING_UART_0_FR & (1 << 5))
-		;
-
-	BCMRING_UART_0_DR = c;
-}
+#define BCMRING_UART_0_DR	MM_ADDR_IO_UARTA
+#define BCMRING_UART_0_FR	0x18
 
-
-static inline void flush(void)
+#define ARCH_HAVE_UCUART_GENERIC
+static inline void arch_decomp_setup(void)
 {
-	/* Wait for the tx fifo to be empty */
-	while ((BCMRING_UART_0_FR & (1 << 7)) == 0)
-		;
-
-	/* Wait for the final character to be sent on the txd line */
-	while (BCMRING_UART_0_FR & (1 << 3))
-		;
+	ucuart_init(MM_ADDR_IO_UARTA, 0, UCUART_IO_MEM32, BCMRING_UART_0_DR,
+			BCMRING_UART_0_FR, (1 << 5), 0,
+			BCMRING_UART_0_FR, (1 << 7) | (1 << 3), (1 << 7));
 }
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 3090a43..ba17cc6 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -17,16 +17,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <mach/io.h>
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-#undef CLPS7111_BASE
-#define CLPS7111_BASE CLPS7111_PHYS_BASE
-
-#define __raw_readl(p)		(*(unsigned long *)(p))
-#define __raw_writel(v,p)	(*(unsigned long *)(p) = (v))
-
 #ifdef CONFIG_DEBUG_CLPS711X_UART2
 #define SYSFLGx	SYSFLG2
 #define UARTDRx	UARTDR2
@@ -35,18 +28,11 @@
 #define UARTDRx	UARTDR1
 #endif
 
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (clps_readl(SYSFLGx) & SYSFLG_UTXFF)
-		barrier();
-	clps_writel(c, UARTDRx);
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	while (clps_readl(SYSFLGx) & SYSFLG_UBUSY)
-		barrier();
+	ucuart_init(CLPS7111_PHYS_BASE, 0, UCUART_IO_MEM32, UARTDRx,
+			SYSFLGx, SYSFLG_UTXOFF, 0,
+			SYSFLGx, SYSFLG_UBUSY, 0);
 }
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index 255a167..93cdbd6 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -10,39 +10,10 @@
 #include <asm/mach-types.h>
 #include <mach/cns3xxx.h>
 
-#define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-#define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-#define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
-#define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
+#define ARCH_HAVE_UCUART_GENERIC
 
-/*
- * Return the UART base address
- */
-static inline unsigned long get_uart_base(void)
+static inline void arch_decomp_setup(void)
 {
 	if (machine_is_cns3420vb())
-		return CNS3XXX_UART0_BASE;
-	else
-		return 0;
-}
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR(base) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 3))
-		barrier();
+		ucuart_init_amba01x(CNS3XXX_UART0_BASE);
 }
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 1947ff9..daa318d 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -19,27 +19,12 @@
  */
 
 #include <linux/types.h>
-#include <linux/serial_reg.h>
 
 #include <asm/mach-types.h>
 
 #include <mach/serial.h>
 
-u32 *uart;
-
-/* PORT_16C550A, in polled non-fifo mode */
-static void putc(char c)
-{
-	while (!(uart[UART_LSR] & UART_LSR_THRE))
-		barrier();
-	uart[UART_TX] = c;
-}
-
-static inline void flush(void)
-{
-	while (!(uart[UART_LSR] & UART_LSR_THRE))
-		barrier();
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
 static inline void set_uart_info(u32 phys, void * __iomem virt)
 {
@@ -53,6 +38,8 @@ static inline void set_uart_info(u32 phys, void * __iomem virt)
 	uart = (u32 *)phys;
 	uart_info[0] = phys;
 	uart_info[1] = (u32)virt;
+
+	ucuart_init_8250(phys, 2, UCUART_IO_MEM32);
 }
 
 #define _DEBUG_LL_ENTRY(machine, phys, virt)			\
@@ -73,7 +60,7 @@ static inline void set_uart_info(u32 phys, void * __iomem virt)
 	_DEBUG_LL_ENTRY(machine, TNETV107X_UART##port##_BASE,	\
 			TNETV107X_UART##port##_VIRT)
 
-static inline void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	/*
 	 * Initialize the port based on the machine ID from the bootloader.
@@ -101,6 +88,3 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_TNETV107X(tnetv107x,		1);
 	} while (0);
 }
-
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 3bc22a1..0062a56 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -8,24 +8,9 @@
 
 #include <mach/dove.h>
 
-#define UART_THR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x0))
-#define UART_LSR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x14))
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define LSR_THRE	0x20
-
-static void putc(const char c)
-{
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		/* Transmit fifo not full? */
-		if (*UART_LSR & LSR_THRE)
-			break;
-	}
-
-	*UART_THR = c;
-}
-
-static void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(DOVE_UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-ebsa110/include/mach/uncompress.h b/arch/arm/mach-ebsa110/include/mach/uncompress.h
index 507ec2a..56a569f 100644
--- a/arch/arm/mach-ebsa110/include/mach/uncompress.h
+++ b/arch/arm/mach-ebsa110/include/mach/uncompress.h
@@ -7,33 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define ARCH_HAVE_UCUART_GENERIC
 
-#include <linux/serial_reg.h>
-
-#define SERIAL_BASE	((unsigned char *)0xf0000be0)
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	unsigned char v, *base = SERIAL_BASE;
-
-	do {
-		v = base[UART_LSR << 2];
-		barrier();
-	} while (!(v & UART_LSR_THRE));
-
-	base[UART_TX << 2] = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	unsigned char v, *base = SERIAL_BASE;
-
-	do {
-		v = base[UART_LSR << 2];
-		barrier();
-	} while ((v & (UART_LSR_TEMT|UART_LSR_THRE)) !=
-		 (UART_LSR_TEMT|UART_LSR_THRE));
+	ucuart_init_8250(0xf0000be0, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index f1cd638..1b36813 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -11,26 +11,6 @@
 
 #include <mach/ep93xx-regs.h>
 
-static unsigned char __raw_readb(unsigned int ptr)
-{
-	return *((volatile unsigned char *)ptr);
-}
-
-static unsigned int __raw_readl(unsigned int ptr)
-{
-	return *((volatile unsigned int *)ptr);
-}
-
-static void __raw_writeb(unsigned char value, unsigned int ptr)
-{
-	*((volatile unsigned char *)ptr) = value;
-}
-
-static void __raw_writel(unsigned int value, unsigned int ptr)
-{
-	*((volatile unsigned int *)ptr) = value;
-}
-
 #if defined(CONFIG_EP93XX_EARLY_UART1)
 #define UART_BASE		EP93XX_UART1_PHYS_BASE
 #elif defined(CONFIG_EP93XX_EARLY_UART2)
@@ -41,28 +21,6 @@ static void __raw_writel(unsigned int value, unsigned int ptr)
 #define UART_BASE		EP93XX_UART1_PHYS_BASE
 #endif
 
-#define PHYS_UART_DATA		(UART_BASE + 0x00)
-#define PHYS_UART_FLAG		(UART_BASE + 0x18)
-#define UART_FLAG_TXFF		0x20
-
-static inline void putc(int c)
-{
-	int i;
-
-	for (i = 0; i < 1000; i++) {
-		/* Transmit fifo not full?  */
-		if (!(__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF))
-			break;
-	}
-
-	__raw_writeb(c, PHYS_UART_DATA);
-}
-
-static inline void flush(void)
-{
-}
-
-
 /*
  * Some bootloaders don't turn off DMA from the ethernet MAC before
  * jumping to linux, which means that we might end up with bits of RX
@@ -85,9 +43,11 @@ static void ethernet_reset(void)
 		;
 }
 
-#define ARCH_HAVE_DECOMP_SETUP
+#define ARCH_HAVE_UCUART_GENERIC
 
-static void arch_decomp_setup(void)
+static inline void arch_decomp_setup(void)
 {
 	ethernet_reset();
+
+	ucuart_init_amba01x(UART_BASE);
 }
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
index 36313de..32e9654 100644
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ b/arch/arm/mach-footbridge/include/mach/uncompress.h
@@ -15,18 +15,14 @@
 #define DC21285_BASE ((volatile unsigned int *)0x42000160)
 #define SER0_BASE    ((volatile unsigned char *)0x7c0003f8)
 
-static inline void putc(char c)
-{
-	if (machine_is_netwinder()) {
-		while ((SER0_BASE[5] & 0x60) != 0x60)
-			barrier();
-		SER0_BASE[0] = c;
-	} else {
-		while (DC21285_BASE[6] & 8);
-		DC21285_BASE[0] = c;
-	}
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	if (machine_is_netwinder())
+		ucuart_init_8250(SER0_BASE, 0, UCUART_IO_MEM8);
+	else
+		ucuart_init(DC21285_BASE, 2, UCUART_IO_MEM32, 0,
+				6, 8, 0,
+				0, 0, 0);
 }
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index 1828862..855eb5b 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -13,25 +13,13 @@
 #ifndef __MACH_UNCOMPRESS_H
 #define __MACH_UNCOMPRESS_H
 
-#include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-static volatile unsigned long * const UART = (unsigned long *)GEMINI_UART_BASE;
+#define ARCH_HAVE_UCUART_GENERIC
 
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- */
-static inline void putc(char c)
-{
-	while (!(UART[UART_LSR] & UART_LSR_THRE))
-		barrier();
-	UART[UART_TX] = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(GEMINI_UART_BASE, 2, UCUART_IO_MEM32);
 }
 
 #endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-h720x/include/mach/uncompress.h b/arch/arm/mach-h720x/include/mach/uncompress.h
index 46c8d5a..be44fd1 100644
--- a/arch/arm/mach-h720x/include/mach/uncompress.h
+++ b/arch/arm/mach-h720x/include/mach/uncompress.h
@@ -9,23 +9,14 @@
 
 #include <mach/hardware.h>
 
-#define LSR 	0x14
-#define TEMPTY 	0x40
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void putc(int c)
-{
-	volatile unsigned char *p = (volatile unsigned char *)(IO_PHYS+0x20000);
-
-	/* wait until transmit buffer is empty */
-	while((p[LSR] & TEMPTY) == 0x0)
-		barrier();
-
-	/* write next character */
-	*p = c;
-}
-
-static inline void flush(void)
+/* debug-macro.S treats this port as an AMBA01x, but according to the
+ * datasheet, this should be a 8250
+ */
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(SERIAL0_BASE, 2, UCUART_IO_MEM8);
 }
 
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
index 9f61543..19f2eb3 100644
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ b/arch/arm/mach-integrator/include/mach/uncompress.h
@@ -17,27 +17,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define AMBA_UART_DR	(*(volatile unsigned char *)0x16000000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0x16000008)
-#define AMBA_UART_LCRM	(*(volatile unsigned char *)0x1600000c)
-#define AMBA_UART_LCRL	(*(volatile unsigned char *)0x16000010)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0x16000014)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0x16000018)
-
-/*
- * This does not append a newline
- */
-static void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
+	ucuart_init_amba01x(0x16000000);
 }
diff --git a/arch/arm/mach-iop13xx/include/mach/uncompress.h b/arch/arm/mach-iop13xx/include/mach/uncompress.h
index bfa8eac..ac09a33 100644
--- a/arch/arm/mach-iop13xx/include/mach/uncompress.h
+++ b/arch/arm/mach-iop13xx/include/mach/uncompress.h
@@ -1,17 +1,8 @@
-#include <asm/types.h>
-#include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-#define UART_BASE ((volatile u32 *)IOP13XX_UART1_PHYS)
-#define TX_DONE (UART_LSR_TEMT | UART_LSR_THRE)
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void putc(char c)
-{
-	while ((UART_BASE[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-	UART_BASE[UART_TX] = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(IOP13XX_UART1_PHYS, 2, UCUART_IO_MEM32);
 }
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index c1ff29a..97fb970 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -1,36 +1,16 @@
 /*
  * arch/arm/mach-iop32x/include/mach/uncompress.h
  */
-
-#include <asm/types.h>
-#include <asm/mach-types.h>
-#include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-volatile u8 *uart_base;
-
-#define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
-
-static inline void putc(char c)
-{
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-	uart_base[UART_TX] = c;
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
-{
-}
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	if (machine_is_iq80321())
-		uart_base = (volatile u8 *)IQ80321_UART;
+		ucuart_init_8250(IQ80321_UART, 0, UCUART_IO_MEM8);
 	else if (machine_is_iq31244() || machine_is_em7210())
-		uart_base = (volatile u8 *)IQ31244_UART;
+		ucuart_init_8250(IQ31244_UART, 0, UCUART_IO_MEM8);
 	else
-		uart_base = (volatile u8 *)0xfe800000;
+		ucuart_init_8250(0xfe800000, 0, UCUART_IO_MEM8);
 }
-
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index 9537d4b..294c444 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -2,33 +2,15 @@
  * arch/arm/mach-iop33x/include/mach/uncompress.h
  */
 
-#include <asm/types.h>
 #include <asm/mach-types.h>
-#include <linux/serial_reg.h>
 #include <mach/hardware.h>
 
-volatile u32 *uart_base;
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
-
-static inline void putc(char c)
-{
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-	uart_base[UART_TX] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	if (machine_is_iq80331() || machine_is_iq80332())
-		uart_base = (volatile u32 *)IOP33X_UART0_PHYS;
+		ucuart_init_8250(IOP33X_UART0_PHYS, 2, UCUART_IO_MEM32);
 	else
-		uart_base = (volatile u32 *)0xfe800000;
+		ucuart_init_8250(0xfe800000, 2, UCUART_IO_MEM32);
 }
-
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-ixp2000/include/mach/uncompress.h b/arch/arm/mach-ixp2000/include/mach/uncompress.h
index 519ba97..dc24c65 100644
--- a/arch/arm/mach-ixp2000/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp2000/include/mach/uncompress.h
@@ -14,31 +14,9 @@
  *
  */
 
-#include <linux/serial_reg.h>
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define UART_BASE	0xc0030000
-
-#define PHYS(x)          ((volatile unsigned long *)(UART_BASE + x))
-
-#define UARTDR          PHYS(0x00)      /* Transmit reg dlab=0 */
-#define UARTDLL         PHYS(0x00)      /* Divisor Latch reg dlab=1*/
-#define UARTDLM         PHYS(0x04)      /* Divisor Latch reg dlab=1*/
-#define UARTIER         PHYS(0x04)      /* Interrupt enable reg */
-#define UARTFCR         PHYS(0x08)      /* FIFO control reg dlab =0*/
-#define UARTLCR         PHYS(0x0c)      /* Control reg */
-#define UARTSR          PHYS(0x14)      /* Status reg */
-
-
-static inline void putc(int c)
-{
-	int j = 0x1000;
-
-	while (--j && !(*UARTSR & UART_LSR_THRE))
-		barrier();
-
-	*UARTDR = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(0xc0030000, 2, UCUART_IO_MEM32);
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/uncompress.h b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
index ab23cbb..e986753 100644
--- a/arch/arm/mach-ixp23xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
@@ -12,25 +12,12 @@
 #define __ASM_ARCH_UNCOMPRESS_H
 
 #include <mach/ixp23xx.h>
-#include <linux/serial_reg.h>
 
-#define UART_BASE	((volatile u32 *)IXP23XX_UART1_PHYS)
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void putc(char c)
-{
-	int j;
-
-	for (j = 0; j < 0x1000; j++) {
-		if (UART_BASE[UART_LSR] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
-
-	UART_BASE[UART_TX] = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(IXP23XX_UART1_PHYS, 2, UCUART_IO_MEM32);
 }
 
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 0a0102c..17b430a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -15,27 +15,10 @@
 
 #include "ixp4xx-regs.h"
 #include <asm/mach-types.h>
-#include <linux/serial_reg.h>
 
-#define TX_DONE (UART_LSR_TEMT|UART_LSR_THRE)
+#define ARCH_HAVE_UCUART_GENERIC
 
-volatile u32* uart_base;
-
-static inline void putc(int c)
-{
-	/* Check THRE and TEMT bits before we transmit the character.
-	 */
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-
-	*uart_base = c;
-}
-
-static void flush(void)
-{
-}
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	/*
 	 * Some boards are using UART2 as console
@@ -43,15 +26,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
 	    machine_is_gateway7001() || machine_is_wg302v2() ||
 	    machine_is_devixp() || machine_is_miccpt() || machine_is_mic256())
-		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
+		ucuart_init_8250(IXP4XX_UART2_BASE_PHYS, 2, UCUART_IO_MEM32);
 	else
-		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
+		ucuart_init_8250(IXP4XX_UART1_BASE_PHYS, 2, UCUART_IO_MEM32);
 }
 
-/*
- * arch_id is a variable in decompress_kernel()
- */
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
index 1fc91eb..e46c96c 100644
--- a/arch/arm/mach-kirkwood/include/mach/uncompress.h
+++ b/arch/arm/mach-kirkwood/include/mach/uncompress.h
@@ -5,37 +5,11 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/serial_reg.h>
 #include <mach/kirkwood.h>
 
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
-
-static void putc(const char c)
-{
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
+#define ARCH_HAVE_UCUART_GENERIC
 
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
+	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index 548c43b..9e6ba4e 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -14,21 +14,15 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-#include <linux/io.h>
 #include <mach/regs-uart.h>
 
-static void putc(char c)
-{
-	while (!(__raw_readl(KS8695_UART_PA + KS8695_URLS) & URLS_URTHRE))
-		barrier();
-
-	__raw_writel(c, KS8695_UART_PA + KS8695_URTH);
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	while (!(__raw_readl(KS8695_UART_PA + KS8695_URLS) & URLS_URTE))
-		barrier();
+	ucuart_init(KS8695_UART_PA, 0, UCUART_MEM32, KS8695_URTH,
+			KS8695_URLS, URLS_URTHRE, URLS_URTHRE,
+			KS8695_URLS, URLS_URTE, URLS_URTE);
 }
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index 36176e2..61a16eb 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -19,38 +19,13 @@
 #ifndef __ASM_ARM_ARCH_UNCOMPRESS_H
 #define __ASM_ARM_ARCH_UNCOMPRESS_H
 
-#include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <mach/platform.h>
 
-/*
- * Uncompress output is hardcoded to standard UART 5
- */
-
-#define UART_FIFO_CTL_TX_RESET	(1 << 2)
-#define UART_STATUS_TX_MT	(1 << 6)
-
-#define _UARTREG(x)		(void __iomem *)(LPC32XX_UART5_BASE + (x))
-
-#define LPC32XX_UART_DLLFIFO_O	0x00
-#define LPC32XX_UART_IIRFCR_O	0x08
-#define LPC32XX_UART_LSR_O	0x14
-
-static inline void putc(int ch)
-{
-	/* Wait for transmit FIFO to empty */
-	while ((__raw_readl(_UARTREG(LPC32XX_UART_LSR_O)) &
-		UART_STATUS_TX_MT) == 0)
-		;
-
-	__raw_writel((u32) ch, _UARTREG(LPC32XX_UART_DLLFIFO_O));
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	__raw_writel(__raw_readl(_UARTREG(LPC32XX_UART_IIRFCR_O)) |
-		UART_FIFO_CTL_TX_RESET, _UARTREG(LPC32XX_UART_IIRFCR_O));
+	ucuart_init_8250(LPC32XX_UART5_BASE, 2, UCUART_IO_MEM32);
 }
 
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index 8c58b57..4cafe10 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -5,8 +5,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#include <linux/serial_reg.h>
 #include <mach/addr-map.h>
 #include <asm/mach-types.h>
 
@@ -14,34 +12,12 @@
 #define UART2_BASE	(APB_PHYS_BASE + 0x17000)
 #define UART3_BASE	(APB_PHYS_BASE + 0x18000)
 
-volatile unsigned long *UART;
-
-static inline void putc(char c)
-{
-	/* UART enabled? */
-	if (!(UART[UART_IER] & UART_IER_UUE))
-		return;
-
-	while (!(UART[UART_LSR] & UART_LSR_THRE))
-		barrier();
-
-	UART[UART_TX] = c;
-}
-
-/*
- * This does not append a newline
- */
-static inline void flush(void)
-{
-}
-
 #define ARCH_HAVE_DECOMP_SETUP
 
 static inline void arch_decomp_setup(void)
 {
-	/* default to UART2 */
-	UART = (unsigned long *)UART2_BASE;
-
 	if (machine_is_avengers_lite())
-		UART = (unsigned long *)UART3_BASE;
+		ucuart_init_8250(UART3_BASE, 2, UCUART_IO_MEM32);
+	else
+		ucuart_init_8250(UART2_BASE, 2, UCUART_IO_MEM32);
 }
diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index 7fa472d..d427ce8 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -19,17 +19,14 @@
 #include "linux/io.h"
 #include "mach/msm_iomap.h"
 
-static void putc(int c)
-{
-#if defined(MSM_DEBUG_UART_PHYS)
-	unsigned base = MSM_DEBUG_UART_PHYS;
-	while (!(readl(base + 0x08) & 0x04)) ;
-	writel(c, base + 0x0c);
-#endif
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+#if defined(MSM_DEBUG_UART_PHYS)
+	ucuart_init(MSM_DEBUG_UART_PHYS, 2, UCUART_IO_MEM32, 0x0c,
+			0x08, 0x04, 0x04,
+			0, 0, 0);
+#endif /* MSM_DEBUG_UART_PHYS */
 }
-
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index d26eb30..720340e 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -9,33 +9,9 @@
 #include <linux/serial_reg.h>
 #include <mach/mv78xx0.h>
 
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
+#define ARCH_HAVE_UCUART_GENERIC
 
-static void putc(const char c)
+static inline void arch_decomp_setup(void)
 {
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
-
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
-{
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
+	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index eded40b..c9587ce 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -20,58 +20,22 @@
 
 #include <asm/mach-types.h>
 
-unsigned long mxs_duart_base;
-
-#define MXS_DUART(x)	(*(volatile unsigned long *)(mxs_duart_base + (x)))
-
-#define MXS_DUART_DR		0x00
-#define MXS_DUART_FR		0x18
-#define MXS_DUART_FR_TXFE	(1 << 7)
-#define MXS_DUART_CR		0x30
-#define MXS_DUART_CR_UARTEN	(1 << 0)
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader. If it's not, the output is
- * simply discarded.
- */
-
-static void putc(int ch)
-{
-	if (!mxs_duart_base)
-		return;
-	if (!(MXS_DUART(MXS_DUART_CR) & MXS_DUART_CR_UARTEN))
-		return;
-
-	while (!(MXS_DUART(MXS_DUART_FR) & MXS_DUART_FR_TXFE))
-		barrier();
-
-	MXS_DUART(MXS_DUART_DR) = ch;
-}
-
-static inline void flush(void)
-{
-}
-
 #define MX23_DUART_BASE_ADDR	0x80070000
 #define MX28_DUART_BASE_ADDR	0x80074000
 
-static inline void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	switch (arch_id) {
 	case MACH_TYPE_MX23EVK:
-		mxs_duart_base = MX23_DUART_BASE_ADDR;
+		ucuart_init_amba01x(MX23_DUART_BASE_ADDR);
 		break;
 	case MACH_TYPE_MX28EVK:
 	case MACH_TYPE_TX28:
-		mxs_duart_base = MX28_DUART_BASE_ADDR;
+		ucuart_init_amba01x(MX28_DUART_BASE_ADDR);
 		break;
 	default:
 		break;
 	}
 }
 
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
 #endif /* __MACH_MXS_UNCOMPRESS_H__ */
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index 0e011ee..f61e22b 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -22,49 +22,15 @@
  * initialized by the bootloader.  We search for the first enabled
  * port in the most probable order.  If you didn't setup a port in
  * your bootloader then nothing will appear (which might be desired).
- *
- * This does not append a newline
  */
 
-#define REG(x) (*(volatile unsigned long *)(x))
-
 #define UART1_BASE 0x100a00
 #define UART2_BASE 0x100a80
 
-#define UART_DR 0x0
-
-#define UART_CR 0x14
-#define CR_UART_EN (1<<0)
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define UART_FR 0x18
-#define FR_BUSY (1<<3)
-#define FR_TXFF (1<<5)
-
-static void putc(char c)
+static inline void arch_decomp_setup(void)
 {
-	unsigned long base;
-
-	if (REG(UART1_BASE + UART_CR) & CR_UART_EN)
-		base = UART1_BASE;
-	else if (REG(UART2_BASE + UART_CR) & CR_UART_EN)
-		base = UART2_BASE;
-	else
-		return;
-
-	while (REG(base + UART_FR) & FR_TXFF);
-	REG(base + UART_DR) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base;
-
-	if (REG(UART1_BASE + UART_CR) & CR_UART_EN)
-		base = UART1_BASE;
-	else if (REG(UART2_BASE + UART_CR) & CR_UART_EN)
-		base = UART2_BASE;
-	else
-		return;
-
-	while (REG(base + UART_FR) & FR_BUSY);
+	ucuart_init_amba01x(UART1_BASE);
+	ucuart_init_amba01x(UART2_BASE);
 }
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index 08f6615..1eb4ae6 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -19,39 +19,13 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-#include <asm/setup.h>
-#include <asm/io.h>
 #include <mach/hardware.h>
 
-/* we need the constants in amba/serial.h, but it refers to amba_device */
-struct amba_device;
-#include <linux/amba/serial.h>
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define NOMADIK_UART_DR		0x101FB000
-#define NOMADIK_UART_LCRH	0x101FB02c
-#define NOMADIK_UART_CR		0x101FB030
-#define NOMADIK_UART_FR		0x101FB018
-
-static void putc(const char c)
-{
-	/* Do nothing if the UART is not enabled. */
-	if (!(readb(NOMADIK_UART_CR) & UART01x_CR_UARTEN))
-		return;
-
-	if (c == '\n')
-		putc('\r');
-
-	while (readb(NOMADIK_UART_FR) & UART01x_FR_TXFF)
-		barrier();
-	writeb(c, NOMADIK_UART_DR);
-}
-
-static void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	if (!(readb(NOMADIK_UART_CR) & UART01x_CR_UARTEN))
-		return;
-	while (readb(NOMADIK_UART_FR) & UART01x_FR_BUSY)
-		barrier();
+	ucuart_init_amba01x(NOMADIK_UART1_BASE);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index a4dca1c..1ac83f5 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -7,37 +7,11 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/serial_reg.h>
 #include <mach/orion5x.h>
 
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
-
-static void putc(const char c)
-{
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
+#define ARCH_HAVE_UCUART_GENERIC
 
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
+	ucuart_init_8250(UART0_PHYS_BASE, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-pnx4008/include/mach/uncompress.h b/arch/arm/mach-pnx4008/include/mach/uncompress.h
index add0c75..dee85ef 100644
--- a/arch/arm/mach-pnx4008/include/mach/uncompress.h
+++ b/arch/arm/mach-pnx4008/include/mach/uncompress.h
@@ -20,21 +20,9 @@
  */
 
 #define UART5_BASE 0x40090000
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define UART5_DR    (*(volatile unsigned char *) (UART5_BASE))
-#define UART5_FR    (*(volatile unsigned char *) (UART5_BASE + 18))
-
-static __inline__ void putc(char c)
-{
-	while (UART5_FR & (1 << 5))
-		barrier();
-
-	UART5_DR = c;
-}
-
-/*
- * This does not append a newline
- */
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_amba01x(UART5_BASE);
 }
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 9ee022f..14effdc 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -9,26 +9,14 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
 #include <mach/uart.h>
 
-static __inline__ void putc(char c)
-{
-	/*
-	 * during kernel decompression, all mappings are flat:
-	 *  virt_addr == phys_addr
-	 */
-	while (__raw_readl(SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
-		& SIRFSOC_UART1_TXFIFO_FULL)
-		barrier();
-
-	__raw_writel(c, SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_DATA);
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init(SIRFSOC_UART1_PA_BASE, 0, UCUART_IO_MEM32,
+			SIRFSOC_UART_TXFIFO_DATA, SIRFSOC_UART_TXFIFO_STATUS,
+			SIRFSOC_UART1_TXFIFO_FULL, 0, 0, 0, 0);
 }
-
 #endif
-
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 28acded..57f1755 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -16,61 +16,24 @@
 #define BTUART_BASE	(0x40200000)
 #define STUART_BASE	(0x40700000)
 
-unsigned long uart_base;
-unsigned int uart_shift;
-unsigned int uart_is_pxa;
-
-static inline unsigned char uart_read(int offset)
-{
-	return *(volatile unsigned char *)(uart_base + (offset << uart_shift));
-}
-
-static inline void uart_write(unsigned char val, int offset)
-{
-	*(volatile unsigned char *)(uart_base + (offset << uart_shift)) = val;
-}
-
-static inline int uart_is_enabled(void)
-{
-	/* assume enabled by default for non-PXA uarts */
-	return uart_is_pxa ? uart_read(UART_IER) & UART_IER_UUE : 1;
-}
-
-static inline void putc(char c)
-{
-	if (!uart_is_enabled())
-		return;
-
-	while (!(uart_read(UART_LSR) & UART_LSR_THRE))
-		barrier();
-
-	uart_write(c, UART_TX);
-}
-
-/*
- * This does not append a newline
- */
-static inline void flush(void)
-{
-}
-
-#define ARCH_HAVE_DECOMP_SETUP
+#define ARCH_HAVE_UCUART_GENERIC
 
 static inline void arch_decomp_setup(void)
 {
-	/* initialize to default */
-	uart_base = FFUART_BASE;
-	uart_shift = 2;
-	uart_is_pxa = 1;
-
-	if (machine_is_littleton() || machine_is_intelmote2()
-	    || machine_is_csb726() || machine_is_stargate2()
-	    || machine_is_cm_x300() || machine_is_balloon3())
-		uart_base = STUART_BASE;
+	unsigned long uart_base;
+
+	if (machine_is_arcom_zeus())
+		ucuart_init_8250(0x10000000, 1, UCUART_IO_MEM8); /* nCS4 */
+	else if (machine_is_littleton() || machine_is_intelmote2()
+			|| machine_is_csb726() || machine_is_stargate2()
+			|| machine_is_cm_x300() || machine_is_balloon3())
+			uart_base = STUART_BASE;
+	else
+		uart_base = FFUART_BASE;
+
+	/* Don't do anything if UART is not enabled */
+	if (!__raw_readl(uart_base + UART_IER) & UART_IER_UUE)
+		return;
 
-	if (machine_is_arcom_zeus()) {
-		uart_base = 0x10000000;	/* nCS4 */
-		uart_shift = 1;
-		uart_is_pxa = 0;
-	}
+	ucuart_init_8250(uart_base, 2, UCUART_IO_MEM8);
 }
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/include/mach/uncompress.h
index 9ba06e9..899aef7 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/include/mach/uncompress.h
@@ -17,7 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 
 #include <mach/board-eb.h>
@@ -26,47 +25,23 @@
 #include <mach/board-pba8.h>
 #include <mach/board-pbx.h>
 
-#define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-#define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-#define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
-#define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
-
-/*
- * Return the UART base address
- */
-static inline unsigned long get_uart_base(void)
+#define ARCH_HAVE_UCUART_GENERIC
+static inline void arch_decomp_setup(void)
 {
+	int uart_base;
+
 	if (machine_is_realview_eb())
-		return REALVIEW_EB_UART0_BASE;
+		uart_base = REALVIEW_EB_UART0_BASE;
 	else if (machine_is_realview_pb11mp())
-		return REALVIEW_PB11MP_UART0_BASE;
+		uart_base = REALVIEW_PB11MP_UART0_BASE;
 	else if (machine_is_realview_pb1176())
-		return REALVIEW_PB1176_UART0_BASE;
+		uart_base = REALVIEW_PB1176_UART0_BASE;
 	else if (machine_is_realview_pba8())
-		return REALVIEW_PBA8_UART0_BASE;
+		uart_base = REALVIEW_PBA8_UART0_BASE;
 	else if (machine_is_realview_pbx())
-		return REALVIEW_PBX_UART0_BASE;
+		uart_base = REALVIEW_PBX_UART0_BASE;
 	else
-		return 0;
-}
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR(base) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base = get_uart_base();
+		return;
 
-	while (AMBA_UART_FR(base) & (1 << 3))
-		barrier();
+	ucuart_init_amba01x(uart_base);
 }
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index 55c9e59..dc0c8b7 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -14,31 +14,30 @@
  * port in the most probable order.  If you didn't setup a port in
  * your bootloader then nothing will appear (which might be desired).
  */
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define UART(x)		(*(volatile unsigned long *)(serial_port + (x)))
-
-static void putc(int c)
+static inline int uart_enabled(int base)
 {
-	unsigned long serial_port;
-
-	do {
-		serial_port = _Ser3UTCR0;
-		if (UART(UTCR3) & UTCR3_TXE) break;
-		serial_port = _Ser1UTCR0;
-		if (UART(UTCR3) & UTCR3_TXE) break;
-		serial_port = _Ser2UTCR0;
-		if (UART(UTCR3) & UTCR3_TXE) break;
-		return;
-	} while (0);
+	if (__raw_readl((void __iomem *)(base + UTCR3)) & UTCR3_TXE)
+		return 1;
 
-	/* wait for space in the UART's transmitter */
-	while (!(UART(UTSR1) & UTSR1_TNF))
-		barrier();
-
-	/* send the character out. */
-	UART(UTDR) = c;
+	return 0;
 }
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	int uart_base;
+
+	if (uart_enabled(_Ser3UTCR0))
+		uart_base = _Ser3UTCR0;
+	else if (uart_enabled(_Ser1UTCR0))
+		uart_base = _Ser1UTCR0;
+	else if (uart_enabled(_Ser2UTCR0))
+		uart_base = _Ser2UTCR0;
+	else
+		return;
+
+	ucuart_init(uart_base, 0, UCUART_IO_MEM32, UTDR,
+			UTSR1, UTSR1_TNF, UTSR1_TNF,
+			0, 0, 0);
 }
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
index 40f4b68..9900826 100644
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ b/arch/arm/mach-shark/include/mach/uncompress.h
@@ -7,39 +7,9 @@
  * Copyright (C) 1996,1997,1998 Russell King
  */
 
-#define SERIAL_BASE ((volatile unsigned char *)0x400003f8)
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void putc(int c)
+static inline void arch_decomp_setup(void)
 {
-	volatile int t;
-
-	SERIAL_BASE[0] = c;
-	t=0x10000;
-	while (t--);
-}
-
-static inline void flush(void)
-{
-}
-
-#ifdef DEBUG
-static void putn(unsigned long z)
-{
-	int i;
-	char x;
-
-	putc('0');
-	putc('x');
-	for (i=0;i<8;i++) {
-		x='0'+((z>>((7-i)*4))&0xf);
-		if (x>'9') x=x-'0'+'A'-10;
-		putc(x);
-	}
-}
-
-static void putr()
-{
-	putc('\n');
-	putc('\r');
+	ucuart_init_8250(0x400003f8, 0, UCUART_IO_MEM8);
 }
-#endif
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 1b07047..61dfd6b 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -26,37 +26,19 @@
 
 #include <mach/iomap.h>
 
-static void putc(int c)
-{
-	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
-	int shift = 2;
-
-	if (uart == NULL)
-		return;
-
-	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
-		barrier();
-	uart[UART_TX << shift] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-#define ARCH_HAVE_DECOMP_SETUP
+#define ARCH_HAVE_UCUART_GENERIC
 
 static inline void arch_decomp_setup(void)
 {
-	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
-	int shift = 2;
+	void __iomem *uart_base = (void*)TEGRA_DEBUG_UART_BASE;
 
-	if (uart == NULL)
-		return;
+	__raw_writel(__raw_readl(uart_base + UART_LCR << 2) | UART_LCR_DLAB,
+			uart_base + UART_LCR << 2);
+	__raw_writel(0x75, uart_base + UART_DLL << 2);
+	__raw_writel(0, uart_base + UART_DLM << 2);
+	__raw_writel(3, uart_base + UART_LCR << 2);
 
-	uart[UART_LCR << shift] |= UART_LCR_DLAB;
-	uart[UART_DLL << shift] = 0x75;
-	uart[UART_DLM << shift] = 0x0;
-	uart[UART_LCR << shift] = 3;
+	ucuart_init_8250(TEGRA_DEBUG_UART_BASE, 2, UCUART_IO_MEM8);
 }
 
 #endif
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
index 68d0298..8bc389a 100644
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ b/arch/arm/mach-u300/include/mach/uncompress.h
@@ -17,24 +17,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define AMBA_UART_DR	(*(volatile unsigned char *)0xc0013000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0xc001302C)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0xc0013030)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0xc0013018)
+#define ARCH_HAVE_UCUART_GENERIC
 
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
+	ucuart_init_amba01x(0xc0013000);
 }
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index d096c99..7e3b48a 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -18,45 +18,18 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-#include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <linux/io.h>
-#include <linux/amba/serial.h>
 #include <mach/hardware.h>
 
-u32 ux500_uart_base;
-
-static void putc(const char c)
-{
-	/* Do nothing if the UART is not enabled. */
-	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
-		return;
-
-	if (c == '\n')
-		putc('\r');
-
-	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 5))
-		barrier();
-	__raw_writeb(c, ux500_uart_base + UART01x_DR);
-}
-
-static void flush(void)
-{
-	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
-		return;
-	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 3))
-		barrier();
-}
-
 #define ARCH_HAVE_DECOMP_SETUP
 
 static inline void arch_decomp_setup(void)
 {
 	/* Check in run time if we run on an U8500 or U5500 */
 	if (machine_is_u5500())
-		ux500_uart_base = U5500_UART0_BASE;
+		ucuart_init_amba01x(U5500_UART0_BASE);
 	else
-		ux500_uart_base = U8500_UART2_BASE;
+		ucuart_init_amba01x(U8500_UART2_BASE);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
index 164b9b5..14294ef 100644
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ b/arch/arm/mach-versatile/include/mach/uncompress.h
@@ -17,24 +17,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define AMBA_UART_DR	(*(volatile unsigned char *)0x101F1000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0x101F102C)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0x101F1030)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0x101F1018)
+#define ARCH_HAVE_UCUART_GENERIC
 
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
+	ucuart_init_amba01x(0x101F1000);
 }
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 0f85a648..00c45e5 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -17,30 +17,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-#define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-#define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
-#define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define get_uart_base()	(0x10000000 + 0x00009000)
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
+static inline void arch_decomp_setup(void)
 {
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR(base) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 3))
-		barrier();
+	ucuart_init_amba01x(0x10009000);
 }
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index 6b93a01..3f7e315 100644
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -14,18 +14,9 @@
  * GNU General Public License for more details.
  *
  */
+#define ARCH_HAVE_UCUART_GENERIC
 
-#define UART0_PHYS 0xd8200000
-#include <asm/io.h>
-
-static void putc(const char c)
-{
-	while (readb(UART0_PHYS + 0x1c) & 0x2)
-		/* Tx busy, wait and poll */;
-
-	writeb(c, UART0_PHYS);
-}
-
-static void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init(0xd8200000, 0, UCUART_IO_MEM8, 0, 0x1C, 0x2, 0, 0, 0, 0);
 }
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 935d950..f082f83 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -18,27 +18,10 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H
 
-/* Defines for UART registers */
-
-#include <mach/regs-serial.h>
 #include <mach/map.h>
-#include <linux/serial_reg.h>
-
-#define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
-static volatile u32 * const uart_base = (u32 *)UART0_PA;
 
-static void putc(int ch)
+static inline void arch_decomp_setup(void)
 {
-	/* Check THRE and TEMT bits before we transmit the character.
-	 */
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-
-	*uart_base = ch;
+	ucuart_init_8250(W90X900_PA_UART, 2, UCUART_IO_MEM32);
 }
-
-static inline void flush(void)
-{
-}
-
 #endif/* __ASM_W90X900_UNCOMPRESS_H */
diff --git a/arch/arm/mach-zynq/include/mach/uncompress.h b/arch/arm/mach-zynq/include/mach/uncompress.h
index 623cebe..c968774 100644
--- a/arch/arm/mach-zynq/include/mach/uncompress.h
+++ b/arch/arm/mach-zynq/include/mach/uncompress.h
@@ -15,31 +15,16 @@
 #ifndef __MACH_UNCOMPRESS_H__
 #define __MACH_UNCOMPRESS_H__
 
-#include <linux/io.h>
-#include <asm/processor.h>
 #include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
-static inline void flush(void)
-{
-	/*
-	 * Wait while the FIFO is not empty
-	 */
-	while (!(__raw_readl(IOMEM(LL_UART_PADDR + UART_SR_OFFSET)) &
-		UART_SR_TXEMPTY))
-		cpu_relax();
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static void putc(char ch)
+static inline void arch_decomp_setup(void)
 {
-	/*
-	 * Wait for room in the FIFO, then write the char into the FIFO
-	 */
-	while (__raw_readl(IOMEM(LL_UART_PADDR + UART_SR_OFFSET)) &
-		UART_SR_TXFULL)
-		cpu_relax();
-
-	__raw_writel(ch, IOMEM(LL_UART_PADDR + UART_FIFO_OFFSET));
+	ucuart_init(LL_UART_PADDR, 0, UCUART_IO_MEM32, UART_FIFO_OFFSET,
+			UART_SR_OFFSET, UART_SR_TXFULL, 0,
+			UART_SR_OFFSET, UART_SR_TXEMPTY, UART_SR_TXEMPTY);
 }
 
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 6e43f5e..b7023be 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -21,10 +21,6 @@
 
 #include <asm/mach-types.h>
 
-unsigned long uart_base;
-
-#define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
-
 #define USR2 0x98
 #define USR2_TXFE (1<<14)
 #define TXR  0x40
@@ -40,23 +36,6 @@ unsigned long uart_base;
  * This does not append a newline
  */
 
-static void putc(int ch)
-{
-	if (!uart_base)
-		return;
-	if (!(UART(UCR1) & UCR1_UARTEN))
-		return;
-
-	while (!(UART(USR2) & USR2_TXFE))
-		barrier();
-
-	UART(TXR) = ch;
-}
-
-static inline void flush(void)
-{
-}
-
 #define MX1_UART1_BASE_ADDR	0x00206000
 #define MX25_UART1_BASE_ADDR	0x43f90000
 #define MX2X_UART1_BASE_ADDR	0x1000a000
@@ -67,8 +46,10 @@ static inline void flush(void)
 #define MX50_UART1_BASE_ADDR	0x53fbc000
 #define MX53_UART1_BASE_ADDR	0x53fbc000
 
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
+	int uart_base;
+
 	switch (arch_id) {
 	case MACH_TYPE_MX1ADS:
 	case MACH_TYPE_SCB9328:
@@ -123,9 +104,12 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	default:
 		break;
 	}
-}
 
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
+	if (!__raw_readl((void __iomem *)uart_base + UCR1) & UCR1_UARTEN)
+		return;
+
+	ucuart_init(uart_base, 0, UCUART_IO_MEM32, TXR,
+			USR2, USR2_TXFE, USR2_TXFE, 0, 0, 0);
+}
 
 #endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 860c02b..8f87c24 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -16,20 +16,11 @@
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <asm/memory.h>
 #include <asm/mach-types.h>
-
 #include <plat/serial.h>
 
 #define MDR1_MODE_MASK			0x07
 
-volatile u8 *uart_base;
-int uart_shift;
-
 /*
  * Store the DEBUG_LL uart number into memory.
  * See also debug-macro.S, and serial.c for related code.
@@ -45,30 +36,12 @@ static void set_omap_uart_info(unsigned char port)
 	*uart_info = port;
 }
 
-static void putc(int c)
-{
-	if (!uart_base)
-		return;
-
-	/* Check for UART 16x mode */
-	if ((uart_base[UART_OMAP_MDR1 << uart_shift] & MDR1_MODE_MASK) != 0)
-		return;
-
-	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
-		barrier();
-	uart_base[UART_TX << uart_shift] = c;
-}
-
-static inline void flush(void)
-{
-}
-
 /*
  * Macros to configure UART1 and debug UART
  */
 #define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
 	if (machine_is_##mach()) {					\
-		uart_base = (volatile u8 *)(dbg_uart);			\
+		uart_base = (dbg_uart);					\
 		uart_shift = (dbg_shft);				\
 		port = (dbg_id);					\
 		set_omap_uart_info(port);				\
@@ -103,8 +76,10 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		TI816XUART##p)
 
-static inline void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
+	int uart_base;
+	int uart_shift;
 	int port = 0;
 
 	/*
@@ -180,7 +155,11 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_TI816X(3, ti8168evm);
 
 	} while (0);
-}
 
-#define ARCH_HAVE_DECOMP_SETUP
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
+	/* Check for UART 16x mode */
+	if (__raw_readl((void __iomem *)uart_base +
+			UART_OMAP_MDR1 << uart_shift) & MDR1_MODE_MASK)
+		return;
+
+	ucuart_init_8250(uart_base, uart_shift, UCUART_IO_MEM8);
+}
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 317cfe4..1eb0d82 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -10,28 +10,15 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/io.h>
-#include <linux/amba/serial.h>
 #include <mach/hardware.h>
 
 #ifndef __PLAT_UNCOMPRESS_H
 #define __PLAT_UNCOMPRESS_H
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
 
-	while (readl_relaxed(base + UART01x_FR) & UART01x_FR_TXFF)
-		barrier();
+#define ARCH_HAVE_UCUART_GENERIC
 
-	writel_relaxed(c, base + UART01x_DR);
-}
-
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_amba01x(SPEAR_DBG_UART_BASE);
 }
-
 #endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
index 35a924e..b71a605 100644
--- a/arch/arm/plat-tcc/include/mach/uncompress.h
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -3,26 +3,11 @@
  *
  * This file is licensed under the terms of the GPL version 2.
  */
-
-#include <linux/serial_reg.h>
-#include <linux/types.h>
-
 #include <mach/tcc8k-regs.h>
 
-unsigned int system_rev;
-
-#define ID_MASK			0x7fff
-
-static void putc(int c)
-{
-	u32 *uart_lsr = (u32 *)(UART_BASE_PHYS + (UART_LSR << 2));
-	u32 *uart_tx = (u32 *)(UART_BASE_PHYS + (UART_TX << 2));
-
-	while (!(*uart_lsr & UART_LSR_THRE))
-		barrier();
-	*uart_tx = c;
-}
+#define ARCH_HAVE_UCUART_GENERIC
 
-static inline void flush(void)
+static inline void arch_decomp_setup(void)
 {
+	ucuart_init_8250(UART_BASE_PHYS, 2, UCUART_IO_MEM32);
 }
-- 
1.7.4.1
