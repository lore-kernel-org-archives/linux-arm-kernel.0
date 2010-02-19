From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 19 Feb 2010 14:17:52 +0800
Subject: [PATCH 1/5] pxa/zeus: Allow usage of 8250-compatible UART in
	uncompress
In-Reply-To: <20100218202612.6d6385e6@taxman.wild-wind.fr.eu.org>
References: <20100218202612.6d6385e6@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d71002182217n439da3c0n8b8dcee4e8318008@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2010 at 4:26 AM, Marc Zyngier <maz@misterjones.org> wrote:
> Zeus console port is wired to a 8250-compatible device
> (pxa UARTs are reserved to other uses). This patch
> allows such a configuration in the uncompress sequence.
>
> It has been regression-tested on a Viper using FFUART.
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>

Hi Marc,

I would like to modify the patch a little bit as follows (and into two),
please let me know if you are OK (better to go with your Ack):

    [ARM] pxa: refactor uncompress.h for non-PXA uarts

    The original patch came from Marc Zyngier where support of 8250-compatible
    UART is required to show the uncompress information. Modified a little bit
    here, including changes below:

    1. #include <mach/regs-uart.h> is actually not necessary
    2. introduced uart_{read,write}() for different base and shift
    3. introduced uart_is_enabled() and assumed enabled always for
       non-PXA uarts

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h
b/arch/arm/mach-pxa/include/mach/uncompress.h
index 237734b..4888a21 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -10,20 +10,41 @@
  */

 #include <linux/serial_reg.h>
-#include <mach/regs-uart.h>
 #include <asm/mach-types.h>

-#define __REG(x)       ((volatile unsigned long *)x)
+#define FFUART_BASE	(0x40100000)
+#define BTUART_BASE	(0x40200000)
+#define STUART_BASE	(0x40700000)

-static volatile unsigned long *UART = FFUART;
+static unsigned long uart_base = FFUART_BASE;
+static unsigned int uart_shift = 2;
+static unsigned int uart_is_pxa = 1;
+
+static inline unsigned char uart_read(int offset)
+{
+	return *(volatile unsigned char *)(uart_base + (offset << uart_shift));
+}
+
+static inline void uart_write(unsigned char val, int offset)
+{
+	*(volatile unsigned char *)(uart_base + (offset << uart_shift)) = val;
+}
+
+static inline int uart_is_enabled(void)
+{
+	/* assume enabled by default for non-PXA uarts */
+	return uart_is_pxa ? uart_read(UART_IER) & UART_IER_UUE : 1;
+}

 static inline void putc(char c)
 {
-	if (!(UART[UART_IER] & IER_UUE))
+	if (!uart_is_enabled())
 		return;
-	while (!(UART[UART_LSR] & LSR_TDRQ))
+
+	while (!(uart_read(UART_LSR) & UART_LSR_THRE))
 		barrier();
-	UART[UART_TX] = c;
+
+	uart_write(c, UART_TX);
 }

 /*
@@ -38,7 +59,7 @@ static inline void arch_decomp_setup(void)
 	if (machine_is_littleton() || machine_is_intelmote2()
 	    || machine_is_csb726() || machine_is_stargate2()
 	    || machine_is_cm_x300() || machine_is_balloon3())
-		UART = STUART;
+		uart_base = STUART_BASE;
 }

 /*


And

    [ARM] pxa/zeus: allow usage of 8250-compatible UART in uncompress

    Zeus console port is wired to a 8250-compatible device (pxa UARTs are
    reserved to other uses). This patch allows such a configuration in the
    uncompress sequence.

    Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h
b/arch/arm/mach-pxa/include/mach/uncompress.h
index 4888a21..5ef91d9 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -60,6 +60,12 @@ static inline void arch_decomp_setup(void)
 	    || machine_is_csb726() || machine_is_stargate2()
 	    || machine_is_cm_x300() || machine_is_balloon3())
 		uart_base = STUART_BASE;
+
+	if (machine_is_arcom_zeus()) {
+		uart_base = 0x10000000;	/* nCS4 */
+		uart_shift = 1;
+		uart_is_pxa = 0;
+	}
 }

 /*
