From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Tue, 19 Jan 2010 06:56:22 +0530
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <20100116013515.10065.30649.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030070F293@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Friday, January 15, 2010 7:35 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: linux-omap at vger.kernel.org
>Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic

UART_SCR 		-> this is the scratchpad register 
UART_OMAP_SCR	-> This is TI-only Supplementary control register

You probably confused the two (as rightly so since SCR is same name).
So there is no need to save/restore the UART_SCR register as you have done, see inlined -- 

>
>Define arch_decomp_setup() the same way as some other
>architectures do. Use arch_id to configure the debug uart
>based on the machine_is by storing it into the uart
>scratchpad register for DEBUG_LL code to use.
>
>Signed-off-by: Tony Lindgren <tony@atomide.com>
<snip>
>--- a/arch/arm/mach-omap2/serial.c
>+++ b/arch/arm/mach-omap2/serial.c
>@@ -161,11 +161,22 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
> static inline void __init omap_uart_reset(struct omap_uart_state *uart)
> {
> 	struct plat_serial8250_port *p = uart->p;
>+	u8 scratchpad = 0;
>+
>+	/*
>+	 * Save UART1 scratchpad register value for UART1 for DEBUG_LL.
>+	 * See also include/plat/uncompress.h and include/mach/debug-macro.S.
>+	 */
>+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
>+		scratchpad = serial_read_reg(p, UART_SCR);

No need to save and restore the UART_SCR register. 
This never gets used in this function.

What gets used is UART_OMAP_SCR which is OMAP specific supplimantry control register 
and not scratchpad.

>
> 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
> 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
> 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
> 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>+
>+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
>+		serial_write_reg(p, UART_SCR, scratchpad);

Remove this as well. No need. 


<snip>
>diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-
>omap/include/plat/uncompress.h
>index 13c305d..479bac8 100644
>--- a/arch/arm/plat-omap/include/plat/uncompress.h
>+++ b/arch/arm/plat-omap/include/plat/uncompress.h
>@@ -19,62 +19,36 @@
>
> #include <linux/types.h>
> #include <linux/serial_reg.h>
>+
>+#include <asm/mach-types.h>
>+
> #include <plat/serial.h>
>
>-unsigned int system_rev;
>+static volatile u8 *uart1_base;
>+static volatile u8 *uart_base;
>+static volatile int uart_shift;

Just like uart_base is stored in scratchpad,
Somehow the uart_shift also needs to be stored so that boards with different uart_shift requirements can be addressed. Where can we store this another variable? 

<snip>

> /*
>+ * Macros to configure UART1 and debug UART
>+ */
>+#define _DEBUG_LL_ENTRY(mach, uart1, dbg_uart, shift, dbg_id, reset_fn)	\
>+	if (machine_is_##mach()) {					\
>+		uart1_base = (volatile u8 *)(uart1);			\
>+		uart_base = (volatile u8 *)(dbg_uart);			\
>+		uart_shift = (shift);					\
>+		port = (dbg_id);					\
>+		reset_fn;						\
>+		break;							\
>+	}

Nice Idea... you are the man !!

<snip>
