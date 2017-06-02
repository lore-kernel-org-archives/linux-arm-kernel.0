From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 3 Jun 2017 00:21:38 +0200
Subject: [linux-sunxi] Re: [RFC PATCH 07/11] drm: sun4i: add support for
 the TV encoder in H3 SoC
In-Reply-To: <715e6ab52d8aa0032c9759393ace20dc@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <1958057.WDKm0nQKgW@jernej-laptop>
 <CAGb2v66aD=G+V75N-_nYo=dGqhxpKhadM84h9G-B34=dnDwCbg@mail.gmail.com>
 <3164416.5xR36OcyjH@jernej-laptop>
 <20170523125321.t7y7yfrrfokpkzgd@flea.home>
 <98c3572beee0a81755994b4bdc508b18@aosc.io>
 <20170524073019.bl6rojc2srrigalp@flea.home>
 <98558BA2-BC99-4D0A-A045-571C643875C5@aosc.io>
 <20170531184306.hzu2em35vr4qi4un@flea.lan>
 <715e6ab52d8aa0032c9759393ace20dc@aosc.io>
Message-ID: <20170602222138.2sra42yjkbwms53d@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 10:11:14PM +0800, icenowy at aosc.io wrote:
> ? 2017-06-01 02:43?Maxime Ripard ???
> > On Wed, May 24, 2017 at 04:25:46PM +0800, Icenowy Zheng wrote:
> > > 
> > > 
> > > ? 2017?5?24? GMT+08:00 ??3:30:19, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> ??:
> > > >On Tue, May 23, 2017 at 09:00:59PM +0800, icenowy at aosc.io wrote:
> > > >> ? 2017-05-23 20:53?Maxime Ripard ???
> > > >> > On Mon, May 22, 2017 at 07:55:56PM +0200, Jernej ?krabec wrote:
> > > >> > > Hi,
> > > >> > >
> > > >> > > Dne sobota, 20. maj 2017 ob 03:37:53 CEST je Chen-Yu Tsai
> > > >napisal(a):
> > > >> > > > On Sat, May 20, 2017 at 2:23 AM, Jernej ?krabec
> > > ><jernej.skrabec@siol.net>
> > > >> > > wrote:
> > > >> > > > > Hi,
> > > >> > > > >
> > > >> > > > > Dne petek, 19. maj 2017 ob 20:08:18 CEST je Icenowy Zheng
> > > >napisal(a):
> > > >> > > > >> ? 2017?5?20? GMT+08:00 ??2:03:30, Maxime Ripard
> > > ><maxime.ripard@free-
> > > >> > > > >
> > > >> > > > > electrons.com> ??:
> > > >> > > > >> >On Thu, May 18, 2017 at 12:43:50AM +0800, Icenowy Zheng
> > > >wrote:
> > > >> > > > >> >> Allwinner H3 features a TV encoder similar to the one in
> > > >earlier
> > > >> > > > >> >
> > > >> > > > >> >SoCs,
> > > >> > > > >> >
> > > >> > > > >> >> but with some different points about clocks:
> > > >> > > > >> >> - It has a mod clock and a bus clock.
> > > >> > > > >> >> - The mod clock must be at a fixed rate to generate
> > > >signal.
> > > >> > > > >> >
> > > >> > > > >> >Why?
> > > >> > > > >>
> > > >> > > > >> It's experiment result by Jernej.
> > > >> > > > >>
> > > >> > > > >> The clock rates in BSP kernel is also specially designed
> > > >> > > > >> (PLL_DE at 432MHz) in order to be able to feed the TVE.
> > > >> > > > >
> > > >> > > > > My experiments and search through BSP code showed that TVE
> > > >seems to have
> > > >> > > > > additional fixed predivider 8. So if you want to generate 27
> > > >MHz clock,
> > > >> > > > > unit has to be feed with 216 MHz.
> > > >> > > > >
> > > >> > > > > TVE has only one PLL source PLL_DE. And since 216 MHz is a
> > > >bit low for
> > > >> > > > > DE2,
> > > >> > > > > BSP defaults to 432 MHz for PLL_DE and use divider 2 to
> > > >generate 216 MHz.
> > > >> > > > > This clock is then divided by 8 internaly to get final 27
> > > >MHz.
> > > >> > > > >
> > > >> > > > > Please note that I don't have any hard evidence to support
> > > >that, only
> > > >> > > > > experimental data. However, only that explanation make sense
> > > >to me.
> > > >> > > > >
> > > >> > > > > BTW, BSP H3/H5 TV driver supports only PAL and NTSC which
> > > >both use 27 MHz
> > > >> > > > > base clock. Further experiments are needed to check if there
> > > >is any
> > > >> > > > > possibility to have other resolutions by manipulating clocks
> > > >and give
> > > >> > > > > other proper settings. I plan to do that, but not in very
> > > >near future.
> > > >> > > >
> > > >> > > > You only have composite video output, and those are the only 2
> > > >standard
> > > >> > > > resolutions that make any sense.
> > > >> > >
> > > >> > > Right, other resolutions are for VGA.
> > > >> > >
> > > >> > > Anyway, I did some more digging in A10 and R40 datasheets. I
> > > >think
> > > >> > > that H3 TVE
> > > >> > > unit is something in between. R40 TVE has a setting to select "up
> > > >> > > sample".
> > > >> >
> > > >> > That might be just another translation of oversampling :)
> > > >> >
> > > >> > I didn't know it could be applied to composite signals though, but
> > > >I
> > > >> > guess this is just another analog signal after all.
> > > >> >
> > > >> > > Possible settings are 27 MHz, 54 MHz, 108 MHz and 216 MHz. BSP
> > > >> > > driver on R40
> > > >> > > has this setting enabled only for PAL and NTSC and it is always
> > > >216
> > > >> > > MHz. I
> > > >> > > think that H3 may have this hardwired to 216 MHz and this would
> > > >be
> > > >> > > the reason
> > > >> > > why 216 MHz is needed.
> > > >> > >
> > > >> > > Has anyone else any better explanation?
> > > >> >
> > > >> > That's already a pretty good one.
> > > >> >
> > > >> > Either way, wether this is upsampling, oversampling or just a
> > > >> > pre-divider, this can and should be dealt with in the mode_set
> > > >> > callback, and not in the probe.
> > > >>
> > > >> I got a better idea -- let TVE driver have the CLK_TVE as an
> > > >> input and create a subclock output with divider 16, and feed this
> > > >> subclock to TCON lcd-ch1.
> > > >>
> > > >> This is a model of the real hardware -- the clock divider is in
> > > >> TVE, not TCON.
> > > >
> > > >That's definitely not a good representation of the hardware. There's
> > > >one clock, it goes to the TCON, period.
> > > 
> > > No, I still think it goes to the TVE as:
> > > 
> > > 1. it's named TVE in datasheet.
> > 
> > Feel free to come up with a better, more sensible explanation?
> > 
> > > 2. Generating signal with such a low resolution but such
> > > a high dotclock is not a good situation.
> > 
> > What? What do you mean? The pixel clock is 27MHz, I'm pretty sure we
> > agree on that.
> 
> Yes, so I don't think the TCON code should set the clock to any value
> rather than 27MHz.

The pixel clock that matters is what is output on the TV
connector. The intermediate pixel clock don't matter, and in this
case, it seems to be clearly the case that the TCON needs a higher
clock, then let's give it a higher clock.

> So we should create a clock with divider in TVE, and feed it to TCON.

I'm sorry, but this still doesn't make much sense. The clock is
provided by the TCON, and there's a divider in the TVE, it's as simple
as that, unless you can provide some other meaningful explanation.

That the TV encoder feeds a clock that would drive the TCON is already
suspicious, and all the precedent designs indicate that this is not
what is going on. Both the explanation and the design is much simpler
that way.

Sometimes the Occam's razor is a better justification than a label on
a datasheet.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/addc1010/attachment.sig>
