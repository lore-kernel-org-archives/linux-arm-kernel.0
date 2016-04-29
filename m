From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 29 Apr 2016 14:31:59 +0200
Subject: [RFC PATCH 1/1] clk: imx7d: move clk setting out of
 imx7d_clocks_init
In-Reply-To: <20160429095500.GC28427@shlinux2.ap.freescale.net>
References: <alpine.DEB.2.11.1604271212290.3941@nanos>
 <1461923115-16563-1-git-send-email-aisheng.dong@nxp.com>
 <20160429095500.GC28427@shlinux2.ap.freescale.net>
Message-ID: <1461933119.3482.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 29.04.2016, 17:55 +0800 schrieb Dong Aisheng:
> On Fri, Apr 29, 2016 at 05:45:15PM +0800, Dong Aisheng wrote:
> > During kernel early booting(e.g. in time_init()), there's only one
> > init idle task running, and the idle sched class indicates that it's
> > not valid to schedule for idle task. If it happens the kernel
> > will complain with a error message as follows:
> > [    0.000000] bad: scheduling from the idle thread!
> > 
> > We can observe this warning on an i.MX7D SDB board. See full log below.
> > It is caused by imx7d_clocks_init function called in time_init
> > invokes a lot clk_prepare_enable to enable many clocks and it happens
> > that the Audio/Video PLLs need large delay causes a sleep.
> > 
> > Since we should not sleep during time_init, this patch fundamentally
> > moves all clk_prepare_enable and clk_set_parent out of imx7d_clocks_init
> > and use a postcore init function imx7d_clocks_setup to do it later instead.
> > Then we simply reply on the bootloader settings to do early boot.
> > 
> 
> Hi Shawn,
> 
> This is a draft RFC patch. Pls help check if you can accept
> this way. If yes, i can also convert other platforms.
> 
> BTW, one know issue is we may need check if need extra fix
> for imx_register_uart_clocks(uart_clks) separately in case
> the uart clocks are not enabled in bootloader.

The sole purpose of imx_register_uart_clocks() is to keep earlycon
clocks enabled. Earlycon already operates under the assumption that the
relevant clocks are enabled by the bootloader as earlycon must work
before the clock driver is initialized. So there is no problem here to
fix here.

Regards,
Lucas
