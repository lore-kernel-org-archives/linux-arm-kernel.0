From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jan 2010 15:10:44 -0800
Subject: [PATCH 1/4] omap: Clean the serial port defines
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030070F290@dbde02.ent.ti.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013510.10065.59461.stgit@baageli.muru.com>
	<FCCFB4CDC6E5564B9182F639FC356087030070F290@dbde02.ent.ti.com>
Message-ID: <20100120231044.GE23467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Pandita, Vikram <vikram.pandita@ti.com> [100118 16:37]:

<snip>

> Is it possible to use the same approach as mach-omap2/ for physical address assignments?
> I like that approach.
> Refer this part from mach-omap2:
> 	+	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
> 	+	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
> 	+	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;	
> 
> > 		.irq		= INT_UART1,
> > 		.flags		= UPF_BOOT_AUTOCONF,
> > 		.iotype		= UPIO_MEM,

It would be possible if we had omap1_globals. But we don't have it as
the address space is so similar across all omap1 processors.

> > 		.macro	busyuart,rd,rx
> >-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
> >-		and	\rd, \rd, #0x60
> >-		teq	\rd, #0x60
> >-		beq	1002f
> >-		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
> >-		and	\rd, \rd, #0x60
> >-		teq	\rd, #0x60
> >+1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
> 
> Zoom2/3 kind of boards have external debug Serial port.
> For those boards and maybe others, the shift value is 1 and not OMAP_PORT_SHIFT(2).

OK, thanks for pointing that out. Let's add the shift as a variable
in debug-macro.S, see the next patch in the series.
 
> This solution is not extensible to zoom2/3 boards with external debug board uarts.
> How do we address that? 
 
It should be doable, we need to initialize zoom external uart physical
and virtual address in uncompress.h, and also initialize the shift for
it.
 
> >diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> <snip>
> >@@ -269,11 +278,15 @@ static struct omap_globals omap343x_globals = {
> > 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
> > 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
> >+	.uart1_phys	= OMAP3_UART1_BASE,
> >+	.uart2_phys	= OMAP3_UART2_BASE,
> >+	.uart3_phys	= OMAP3_UART3_BASE,
> 
> OMAP3630 also has 4 UARTS and this same global is getting used for both 34xx and 36xx.
> This is not right.
> 
> For 3630 uart4_phys = 0x49042000

OK, updated.

> >+#define OMAP3_UART1_BASE	0x4806a000
> >+#define OMAP3_UART2_BASE	0x4806c000
> >+#define OMAP3_UART3_BASE	0x49020000
> 
> Need to add 0x4904 2000 for 3630 UART4

OK, added now. Care to look and ack the attached updated patch?

Regards,

Tony
