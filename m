From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:28:52 +0200
Subject: [PATCH 1/7 v5] Introduce plat-tcc
In-Reply-To: <20100422111007.GD20008@n2100.arm.linux.org.uk>
References: <20100421123814.GC1995@bluebox.local>
	<20100421124046.GD1995@bluebox.local>
	<20100422111007.GD20008@n2100.arm.linux.org.uk>
Message-ID: <20100526172851.GA2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 12:10:07PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 02:40:48PM +0200, Hans J. Koch wrote:
> > +#define UART_RBR_OFFS		0x00
> > +#define UART_THR_OFFS		0x00
> > +#define UART_DLL_OFFS		0x00
> > +#define UART_IER_OFFS		0x04
> > +#define UART_DLM_OFFS		0x04
> > +#define UART_IIR_OFFS		0x08
> > +#define UART_FCR_OFFS		0x08
> > +#define UART_LCR_OFFS		0x0c
> > +#define UART_MCR_OFFS		0x10
> > +#define UART_LSR_OFFS		0x14
> > +#define UART_MSR_OFFS		0x18
> > +#define UART_SCR_OFFS		0x1c
> 
> These look like a duplication (n << 2) of the standard 8250 definitions
> in serial_reg.h

Yep. Meanwhile I've got confirmation from Telechips that this is actually
supposed to be a 8250-compatible thing. I will use that driver in the
future, so for the moment, I threw away all UART-related stuff.
Thanks for that hint!

> 
> > +/* Bits in UART_LCR */
> > +#define UART_LCR_DLAB	(1 << 7)
> > +#define UART_LCR_SB	(1 << 6)
> > +#define UART_LCR_SP	(1 << 5)
> > +#define UART_LCR_EPS	(1 << 4)
> > +#define UART_LCR_PEN	(1 << 3)
> > +#define UART_LCR_STB	(1 << 2)
> > +#define UART_LCR_WLS_5	(0 << 0)
> > +#define UART_LCR_WLS_6	(1 << 0)
> > +#define UART_LCR_WLS_7	(2 << 0)
> > +#define UART_LCR_WLS_8	(3 << 0)
> 
> #define UART_LCR_DLAB           0x80 /* Divisor latch access bit */
> #define UART_LCR_SBC            0x40 /* Set break control */
> #define UART_LCR_SPAR           0x20 /* Stick parity (?) */
> #define UART_LCR_EPAR           0x10 /* Even parity select */
> #define UART_LCR_PARITY         0x08 /* Parity Enable */
> #define UART_LCR_STOP           0x04 /* Stop bits: 0=1 bit, 1=2 bits */
> #define UART_LCR_WLEN5          0x00 /* Wordlength: 5 bits */
> #define UART_LCR_WLEN6          0x01 /* Wordlength: 6 bits */
> #define UART_LCR_WLEN7          0x02 /* Wordlength: 7 bits */
> #define UART_LCR_WLEN8          0x03 /* Wordlength: 8 bits */
> 
> etc.  Please use the already established definitions from linux/serial_reg.h

I've done so in uncompress.h (the only remaining user).

> 
> > diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
> > new file mode 100644
> > index 0000000..79b6ecd
> > --- /dev/null
> > +++ b/arch/arm/plat-tcc/system.c
> > @@ -0,0 +1,25 @@
> > +/*
> > + * System functions for Telechips TCCxxxx SoCs
> > + *
> > + * Copyright (C) Hans J. Koch <hjk@linutronix.de>
> > + *
> > + * Licensed under the terms of the GPL v2.
> > + *
> > + */
> > +
> > +#include <linux/io.h>
> > +
> > +#include <mach/tcc8k-regs.h>
> > +
> > +/* System reboot */
> > +void plat_tcc_reboot(void)
> > +{
> > +	/* Make sure clocks are on */
> > +	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
> > +
> > +	/* Enable watchdog reset */
> > +	__raw_writel(0x49, TIMER_BASE + TWDCFG_OFFS);
> > +	/* Wait for reset */
> > +	unreachable();
> 
> I don't think that's true; what you're saying is that the CPU will never
> execute any instructions after the __raw_writel - what if the write is
> buffered and doesn't take effect immediately - are you happy for the CPU
> to start executing data?

Grmbl... The meaning of unreachable() has changed. OK, I replaced it with
a while(1);

New patch series will follow.

Thanks,
Hans
