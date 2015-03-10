From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 20:49:18 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <20150310173550.GT5264@atomide.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <CAB3XZEdK2O7tSSTchvRQtaefzCECjjQ-biQmOBHGdzJaBknSFQ@mail.gmail.com>
 <20150310173550.GT5264@atomide.com>
Message-ID: <3817307.UNCtDNMakZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 10:35:50 Tony Lindgren wrote:
> * Eliad Peller <eliad@wizery.com> [150310 10:01]:
> > i'm really not familiar with the common clock framework, but there
> > still doesn't seem to be a way to determine whether a clock is XTAL or
> > not (which is what Luca's patch was about). should we use compatible
> > flag in such case? i'm not sure it sounds right.
> > 
> > anyway, i'd really prefer, if possible, starting with the wl18xx
> > bindings, and defer the wl12xx complications to later on.
> > (i also need to find some wl12xx card in order to actually test the
> > patches once i'll have them...)
> > 
> > we do have to make sure these wl18xx bindings are future-compatible
> > with the wl12xx ones, but i think the current bindings are pretty much
> > standard (and are actually a subset of the bindings needed by wl12xx),
> > so it should be fine.
> 
> Well how about add just the parsing of the clock and assume it's always
> WL12XX_REFCLOCK_38 for now as that's the only thing we're currently
> using. Then we can add a property or compatible value if using something
> else as needed.
> 

We have two exceptions:

static void __init omap3_zoom_legacy_init(void)
{
        legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
}

static void __init omap4_sdp_legacy_init(void)
{
        legacy_init_wl12xx(WL12XX_REFCLOCK_26,
                           WL12XX_TCXOCLOCK_26, 53);
}

Where do those clocks come from? If these are always fixed-rate
clocks coming from an external clock provider, using a separate
compatible string in the clock provider would seem reasonable to
me, but we can do that once we have to: none of the machines
we support use an XTAL clock input.

	Arnd
