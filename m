From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Sat, 5 Nov 2011 10:29:33 +0000
Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
In-Reply-To: <79CD15C6BA57404B839C016229A409A8021196@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	<79CD15C6BA57404B839C016229A409A8021196@DBDE01.ent.ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A80211D1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Saturday, November 05, 2011 3:11 PM
> To: Hiremath, Vaibhav; linux-omap at vger.kernel.org
> Cc: Hilman, Kevin; paul at pwsan.com; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org; Mohammed, Afzal
> Subject: RE: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
> specific sources
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Tuesday, September 20, 2011 8:02 PM
> > To: linux-omap at vger.kernel.org
> > Cc: Hilman, Kevin; paul at pwsan.com; tony at atomide.com; linux-arm-
> > kernel at lists.infradead.org; Mohammed, Afzal; Hiremath, Vaibhav
> > Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
> > specific sources
> >
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > This patch updates the common machine specific source files for
> > support for AM33XX/AM335x with cpu type, macros for identification of
> > AM33XX/AM335X device.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock3xxx_data.c       |    6 +++++-
> >  arch/arm/mach-omap2/common.c               |   16 ++++++++++++++++
> >  arch/arm/mach-omap2/id.c                   |   10 ++++++++--
> >  arch/arm/mach-omap2/io.c                   |   25
> > +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/serial.c               |    6 +++---
> >  arch/arm/plat-omap/include/plat/am33xx.h   |   25
> > +++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/common.h   |    1 +
> >  arch/arm/plat-omap/include/plat/hardware.h |    1 +
> >  arch/arm/plat-omap/include/plat/io.h       |   20 ++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/omap34xx.h |    2 ++
> >  arch/arm/plat-omap/io.c                    |    5 +++++
> >  11 files changed, 111 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h
> >
<snip>
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 466fc72..b7782ee 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -486,7 +486,7 @@ static void omap_uart_idle_init(struct
> omap_uart_state
> > *uart)
> >  		mod_timer(&uart->timer, jiffies + uart->timeout);
> >  	omap_uart_smart_idle_enable(uart, 0);
> >
> > -	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
> > +	if (cpu_is_omap34xx() && !(cpu_is_ti816x() || cpu_is_am33xx())) {
> >  		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
> >  		u32 wk_mask = 0;
> >  		u32 padconf = 0;
> > @@ -768,7 +768,7 @@ void __init omap_serial_init_port(struct
> > omap_board_data *bdata)
> >  	 */
> >  	uart->regshift = p->regshift;
> >  	uart->membase = p->membase;
> > -	if (cpu_is_omap44xx() || cpu_is_ti816x())
> > +	if (cpu_is_omap44xx() || cpu_is_ti816x() || cpu_is_am33xx())
> >  		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
> >  	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
> >  			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> > @@ -851,7 +851,7 @@ void __init omap_serial_init_port(struct
> > omap_board_data *bdata)
> >  	}
> 
> Can I get rid of this if condition as well here with below change -
> 
> -        * omap44xx, ti816x: Never read empty UART fifo
> +        * all >omap3 family of devices: Never read empty UART fifo
>          * omap3xxx: Never read empty UART fifo on UARTs
>          * with IP rev >=0x52
>          */
>         uart->regshift = p->regshift;
>         uart->membase = p->membase;
> -       if (cpu_is_omap44xx() || cpu_is_ti816x() || cpu_is_am33xx())
> -               uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
> -       else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
> -                       >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +
> +       if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
> +                       < UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +               uart->errata &= ~UART_ERRATA_FIFO_FULL_ABORT;
> +       else
>                 uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
> 
>         if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
> 

Hit send button bit early, realized that, on all other devices (like AM33xx) the rev id is not incremental order, it has been reseted again, sp right condition here would be - 

-       if (cpu_is_omap44xx() || cpu_is_ti816x() || cpu_is_am33xx())
-               uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
-       else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
-                       >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+
+       if (cpu_is_omap34xx() && (serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
+                       < UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+               uart->errata &= ~UART_ERRATA_FIFO_FULL_ABORT;
+       else
                 uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;

Thanks,
Vaibhav

> 
> Thanks,
> Vaibhav
