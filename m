From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:39 +0200
Subject: [RFC PATCH 09/15] ARM: uncompress: Introduce ucuart as low-level
	serial port driver
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-9-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the ucuart struct which should be a sufficient
description for being able to print through a serial port.

Generic versions of putc() and flush() using ucuart are also
added, along with initialization helpers, one specifically
for the 8250 family UART and one for the AMBA01X PrimeCell.

The port structure is not declared statically, but inited
through arch_decomp_setup() to have it in the .bss area,
thus in RAM.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/print.c |  128 +++++++++++++++++++++++++++++++++++--
 1 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
index 25f0fb2..fbffc99 100644
--- a/arch/arm/boot/compressed/print.c
+++ b/arch/arm/boot/compressed/print.c
@@ -25,18 +25,120 @@ void error(char *x);
 extern unsigned int __machine_arch_type;
 #define arch_id __machine_arch_type
 
+enum ucuart_iotypes {
+	UCUART_IO_MEM32 = 0,
+	UCUART_IO_MEM8,
+};
+
+struct uncompress_uart {
+	void __iomem		*base;
+	int			reg_shift;
+	enum ucuart_iotypes	iotype;
+	int			tx_regoff;
+	int			txfree_regoff;
+	int			txfree_mask;
+	int			txfree_val;
+	int			flush_regoff;
+	int			flush_mask;
+	int			flush_val;
+};
+
+void ucuart_init(int base, int regshift, enum ucuart_iotypes iotype,
+		 int tx_regoff, int txfree_regoff, int txfree_mask,
+		 int txfree_val, int flush_regoff, int flush_mask,
+		 int flush_val);
+
+void ucuart_init_8250(int base, int regshift, enum ucuart_iotypes iotype);
+
+struct uncompress_uart ucuart;
+
 #include <mach/uncompress.h>
 
-#ifdef ARCH_HAVE_DECOMP_SETUP
-void inline decomp_setup(void)
+#ifdef ARCH_HAVE_UCUART_GENERIC
+
+#define ARCH_HAVE_DECOMP_SETUP
+
+#include <linux/io.h>
+#include <linux/serial_reg.h>
+#include <linux/amba/serial.h>
+
+void ucuart_init(int base, int regshift, enum ucuart_iotypes iotype,
+		 int tx_regoff, int txfree_regoff, int txfree_mask,
+		 int txfree_val, int flush_regoff, int flush_mask,
+		 int flush_val)
 {
-	arch_decomp_setup();
+	ucuart.base = (void __iomem *)base;
+	ucuart.reg_shift = regshift;
+	ucuart.iotype = iotype;
+
+	ucuart.tx_regoff = tx_regoff;
+	ucuart.txfree_regoff = txfree_regoff;
+	ucuart.txfree_mask = txfree_mask;
+	ucuart.txfree_val = txfree_val;
+	ucuart.flush_regoff = flush_regoff;
+	ucuart.flush_mask = flush_mask;
+	ucuart.flush_val = flush_val;
 }
-#else /* ARCH_HAVE_DECOMP_SETUP */
-void inline decomp_setup(void)
+
+void inline ucuart_init_8250(int base, int regshift, enum ucuart_iotypes iotype)
 {
+	ucuart_init(base, regshift, iotype, UART_TX,
+			UART_LSR, UART_LSR_THRE, UART_LSR_THRE,
+			UART_LSR, (UART_LSR_TEMT | UART_LSR_THRE),
+			(UART_LSR_TEMT | UART_LSR_THRE));
 }
-#endif /* ARCH_HAVE_DECOMP_SETUP */
+
+void ucuart_init_amba01x(int base)
+{
+	/* Do nothing if the UART is not enabled. */
+	if (!(__raw_readl(base + UART011_CR) & UART01x_CR_UARTEN))
+		return;
+
+	ucuart_init(base, 0, UCUART_IO_MEM32, UART01x_DR,
+			UART01x_FR, UART01x_FR_TXFF, 0,
+			UART01x_FR, UART01x_FR_BUSY, 0);
+}
+
+static inline int uart_read(int regoff)
+{
+	if (ucuart.iotype == UCUART_IO_MEM32)
+		return __raw_readl(ucuart.base + (regoff << ucuart.reg_shift));
+	else
+		return __raw_readb(ucuart.base + (regoff << ucuart.reg_shift));
+}
+
+static inline void uart_write(int regoff, int value)
+{
+	if (ucuart.iotype == UCUART_IO_MEM32)
+		__raw_writel(value, ucuart.base + (regoff << ucuart.reg_shift));
+	else
+		__raw_writeb(value, ucuart.base + (regoff << ucuart.reg_shift));
+}
+
+static inline void putc(int ch)
+{
+	if (!ucuart.base)
+		return;
+
+	if (ucuart.txfree_regoff) {
+		while ((uart_read(ucuart.txfree_regoff) & ucuart.txfree_mask)
+				!= ucuart.txfree_val)
+			barrier();
+	}
+
+	uart_write(ucuart.tx_regoff, ch);
+}
+
+static inline void flush(void)
+{
+	if (ucuart.flush_regoff) {
+		while ((uart_read(ucuart.flush_regoff) & ucuart.flush_mask) !=
+				ucuart.flush_val)
+			barrier();
+	}
+}
+#endif /* ARCH_HAVE_UCUART_GENERIC */
+
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
@@ -91,7 +193,8 @@ static void icedcc_putc(int ch)
 #endif
 
 #define putc(ch)	icedcc_putc(ch)
-#endif
+#define flush()
+#endif /* CONFIG_DEBUG_ICEDCC */
 
 void putstr(const char *ptr)
 {
@@ -120,3 +223,14 @@ void error(char *x)
 
 	while(1);	/* Halt */
 }
+
+#ifdef ARCH_HAVE_DECOMP_SETUP
+void inline decomp_setup(void)
+{
+	arch_decomp_setup();
+}
+#else /* ARCH_HAVE_DECOMP_SETUP */
+void inline decomp_setup(void)
+{
+}
+#endif /* ARCH_HAVE_DECOMP_SETUP */
-- 
1.7.4.1
