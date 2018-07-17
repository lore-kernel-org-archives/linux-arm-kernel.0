From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Jul 2018 16:48:54 -0400 (EDT)
Subject: [PATCH] ARM: early_printk: respect keep parameter
In-Reply-To: <20180717203153.GC3211@piout.net>
References: <20180711183239.21023-1-alexandre.belloni@bootlin.com>
 <nycvar.YSQ.7.76.1807171603240.20892@knanqh.ubzr>
 <20180717203153.GC3211@piout.net>
Message-ID: <nycvar.YSQ.7.76.1807171641470.20892@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jul 2018, Alexandre Belloni wrote:

> On 17/07/2018 16:16:44-0400, Nicolas Pitre wrote:
> > On Wed, 11 Jul 2018, Alexandre Belloni wrote:
> > 
> > > Parse and use the keep parameter of earlyprintk to avoid having the kernel
> > > output stop with:
> > > 
> > > Console: colour dummy device 80x30
> > > console [tty0] enabled
> > > bootconsole [earlycon0] disabled
> > > 
> > > This happens because once tty0, the virtual terminal console is registered,
> > > it is selected as the default console, disregarding an existing stdout-path
> > > DT property and the early console is shutdown before the console driver is
> > > probed.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > Why can't you have a real console driver that takes over at that point 
> > which respects whatever DT property you give it?
> > 
> 
> See Russell's analysis here:
> 
> https://www.spinics.net/lists/linux-serial/msg25363.html

That is a good analysis, but not necessarily a good argument for this 
particular patch.

> > The early_printk code is very raw and inefficient, and it shouldn't be 
> > used for anything but the debugging of early boot hangs.
> > 
> 
> The issue I had is that he pinctrl driver wasn't probing so the real
> console driver could never probe. I think this fits the use case.

Yes, that certainly fits.  This is not what your commit log message is 
saying though.

> Also, atmel_serial doesn't yet have earlycon support.

Fair enough, and probably something you should mention too.

> > > ---
> > >  arch/arm/kernel/early_printk.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> > > index 9257736ec9fa..bbb10150b11a 100644
> > > --- a/arch/arm/kernel/early_printk.c
> > > +++ b/arch/arm/kernel/early_printk.c
> > > @@ -42,6 +42,9 @@ static struct console early_console_dev = {
> > >  
> > >  static int __init setup_early_printk(char *buf)
> > >  {
> > > +	if (buf && strstr(buf, "keep"))
> > > +		early_console_dev.flags &= ~CON_BOOT;
> > > +
> > >  	early_console = &early_console_dev;
> > >  	register_console(&early_console_dev);
> > >  	return 0;
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > 
> 
> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
