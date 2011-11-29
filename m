From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 16:04:55 +0000
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <CAN1soZwe03c485uYTps5ixBrx_4q=JrcTA7VwkcqrT99hZCJzA@mail.gmail.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <201111291446.41815.arnd@arndb.de>
 <CAN1soZwe03c485uYTps5ixBrx_4q=JrcTA7VwkcqrT99hZCJzA@mail.gmail.com>
Message-ID: <201111291604.55273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2011, Haojian Zhuang wrote:
> > static struct platform_device_id pxa3xx_pinmux_ids = {
> >        { .name = "pxa300-pinmux", .id = (unsigned long)&pxa300_pinmux, },
> >        { .name = "pxa310-pinmux", .id = (unsigned long)&pxa310_pinmux, },
> >        { .name = "pxa320-pinmux", .id = (unsigned long)&pxa320_pinmux, },
> >        { .name = "pxa910-pinmux", .id = (unsigned long)&pxa910_pinmux, },
> > };
> It's cleaner. And I'm considering to extend pxa3xx_pinmux_info. I'll
> also add pointers to pads[] and mfpr[]. Since pads[] and mfpr[] are
> large, more silicons are supported and more memory space is occupied.
> So I'll define pads[] and mfpr[] as __initdata and copy them into
> pxa3xx_pinmux_info structure. So I'll use both your solution and
> memcopy in probe().

Ok. However, I think it needs to be __devinitdata if the platform
device might be added after the pinmux driver is added.

> > static struct platform_driver pxa3xx_pinmux_driver = {
> >       .driver = {
> >               .owner = THIS_MODULE,
> >       },
> >       .id_entry = pxa3xx_pinmux_ids,
> >       .probe = pxa3xx_pinmux_probe,
> >       .remove = __devexit_p(pxa3xx_pinmux_remove),
> > };
> >
> > Then you can look at the pxa3xx_pinmux_info pointer in the probe function
> > and do whatever else is necessary.
> >
> > Another entirely different approach would be to split the driver into
> > multiple files, one for each soc plus one for the common parts, so you
> > just build the parts you need for the configuration.
> >
> Is it OK to define pinmux-pxa3xx.c, pinmux-pxa300.c, ...? I'll append
> 8 files since I have 7 silicons.

I think it's ok, but it's your decision if you think it's too much.
You could also end up with fewer than 8 files if you group a few
socs together in case they are almost identical, but keep them
apart from the somewhat more different ones.

I would not recommend having one file per soc if that ends up duplicating
a lot of code that would otherwise be shared, but I think separate
modules would be preferred if you can make all the shared code end
up in the shared file and each individual driver get linked in only
when the configuration for that soc is enabled.

One more clarification: The idea here was to have each file as a separate
module with its own platform driver registration and one private
pinmux_info structure calling functions from the common module, but
never have common code call out to the individual drivers.

	Arnd
