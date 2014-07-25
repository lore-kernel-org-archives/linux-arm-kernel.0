From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jul 2014 16:50:10 +0100
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <20140725152401.GA21830@leverpostej>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
 <20140725152401.GA21830@leverpostej>
Message-ID: <20140725155010.GP21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 04:24:02PM +0100, Mark Rutland wrote:
> Hi Linus,
> 
> On Fri, Jul 25, 2014 at 02:23:48PM +0100, Linus Walleij wrote:
> > +static void __init realview_dt_init_machine(void)
> > +{
> > +       int ret;
> > +
> > +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> > +       if (of_machine_is_compatible("arm,realview-eb"))
> > +               /*
> > +                * 1MB (128KB/way), 8-way associativity,
> > +                * evmon/parity/share enabled
> > +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> > +                */
> > +               l2x0_of_init(0x00790000, 0xfe000fff);
> > +       else if (of_machine_is_compatible("arm,realview-pb1176"))
> > +               /*
> > +                * 128Kb (16Kb/way) 8-way associativity.
> > +                * evmon/parity/share enabled.
> > +                */
> > +               l2x0_of_init(0x00730000, 0xfe000fff);
> > +       else if (of_machine_is_compatible("arm,realview-pb11mp"))
> > +               /*
> > +                * 1MB (128KB/way), 8-way associativity,
> > +                * evmon/parity/share enabled
> > +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> > +                */
> > +               l2x0_of_init(0x00730000, 0xfe000fff);
> > +       else if (of_machine_is_compatible("arm,realview-pbx"))
> > +               /*
> > +                * 16KB way size, 8-way associativity, parity disabled
> > +                * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
> > +                */
> > +               l2x0_of_init(0x02520000, 0xc0000fff);
> > +#endif
> 
> Are these just copied form what we already have for non-DT?
> 
> Do we know that these are all necessary?

It is necessary to provide the cache sizes on Realview because the
older L2C210/L2C220 do not have a method of encoding that information
in the register - and given that ARM doesn't seem to like shipping
Linux compatible boot loaders on their eval hardware, we can't really
say that it should be dealt with there.

I toyed with the idea of adding the standard cache size specifications
to the L2C code, it sounds like there's a reason to do that now.

Let's not mess around with adding stuff like the above to work around
the L2 code not parsing the appropriate specs from DT, let's do the
right thing and add bindings to allow DT to provide the cache geometry.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
