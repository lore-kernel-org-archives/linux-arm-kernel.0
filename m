From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 23:12:32 +0000
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <201001110923.31809.jeremy.kerr@canonical.com>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
	<201001110923.31809.jeremy.kerr@canonical.com>
Message-ID: <20100110231232.GD15812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 09:23:31AM +1100, Jeremy Kerr wrote:
> Russell,
> 
> > --- a/arch/arm/mach-bcmring/core.c
> > +++ b/arch/arm/mach-bcmring/core.c
> > @@ -142,8 +142,7 @@ void __init bcmring_amba_init(void)
> > 
> >  	chipcHw_busInterfaceClockEnable(bus_clock);
> > 
> > -	for (i = 0; i < ARRAY_SIZE(lookups); i++)
> > -		clkdev_add(&lookups[i]);
> > +	clkdev_add_table(lookups, ARRAY_SIEZ(lookups));
> 
> SIEZ -> SIZE.

Fied.

> Also, perhaps a macro to simplify this common usage?
> 
> #define clkdev_add_table(clks) __clkdev_add_table(clks, ARRAY_SIZE(clks))

I'm not a fan of that kind of clean up - it leads people into
thinking that they can pass a normal pointer instead of an array to
clkdev_add_table() - and then they'll get a surprise.

PXA has ARRAY_AND_SIZE() which I think is rather nice for this kind of
thing, but other people had other thoughts on that...
