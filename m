From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 06 Nov 2009 12:22:10 +0000
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <20091105181501.GA7221@pengutronix.de>
References: <20091105181501.GA7221@pengutronix.de>
Message-ID: <1257510130.13580.38.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, 2009-11-05 at 18:15 +0000, Uwe Kleine-K?nig wrote:
> On Thu, Nov 05, 2009 at 12:35:12PM +0000, Catalin Marinas wrote:
> > diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> > new file mode 100644
> > index 0000000..85aa2b2
> > --- /dev/null
> > +++ b/arch/arm/kernel/early_printk.c
> > @@ -0,0 +1,57 @@
> > +/*
> > + *  linux/arch/arm/kernel/early_printk.c
> > + *
> > + *  Copyright (C) 2009 Sascha Hauer <s.hauer@pengutronix.de>
> 
> <nitpick>
> remove one space before "linux" and "Copyright"
> </nitpick>

That's how many other files with Russell's copyright were written (e.g.
drivers/serial/serial_core.c, mmu.c etc.), so we just follow the
tradition :-).

> > +static void early_write(const char *s, unsigned n)
> > +{
> > +     while (n-- > 0) {
> > +             if (*s == '\n')
> > +                     printch('\r');
> > +             printch(*s);
> > +             s++;
> > +     }
> > +}
> 
> Can you better use uart_console_write here?  (If yes, don't forget to
> select CONFIG_SERIAL_CORE.)

This early console should work with ICE DCC as well, so adding the
uart_* calls may be a bit confusing (plus one more indirection of calls
to drop the first argument passed to printch by uart_console_write). The
x86 variant doesn't do this either.

-- 
Catalin
