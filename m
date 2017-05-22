From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 22 May 2017 19:55:56 +0200
Subject: [linux-sunxi] Re: [RFC PATCH 07/11] drm: sun4i: add support for
 the TV encoder in H3 SoC
In-Reply-To: <CAGb2v66aD=G+V75N-_nYo=dGqhxpKhadM84h9G-B34=dnDwCbg@mail.gmail.com>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <1958057.WDKm0nQKgW@jernej-laptop>
 <CAGb2v66aD=G+V75N-_nYo=dGqhxpKhadM84h9G-B34=dnDwCbg@mail.gmail.com>
Message-ID: <3164416.5xR36OcyjH@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne sobota, 20. maj 2017 ob 03:37:53 CEST je Chen-Yu Tsai napisal(a):
> On Sat, May 20, 2017 at 2:23 AM, Jernej ?krabec <jernej.skrabec@siol.net> 
wrote:
> > Hi,
> > 
> > Dne petek, 19. maj 2017 ob 20:08:18 CEST je Icenowy Zheng napisal(a):
> >> ? 2017?5?20? GMT+08:00 ??2:03:30, Maxime Ripard <maxime.ripard@free-
> > 
> > electrons.com> ??:
> >> >On Thu, May 18, 2017 at 12:43:50AM +0800, Icenowy Zheng wrote:
> >> >> Allwinner H3 features a TV encoder similar to the one in earlier
> >> >
> >> >SoCs,
> >> >
> >> >> but with some different points about clocks:
> >> >> - It has a mod clock and a bus clock.
> >> >> - The mod clock must be at a fixed rate to generate signal.
> >> >
> >> >Why?
> >> 
> >> It's experiment result by Jernej.
> >> 
> >> The clock rates in BSP kernel is also specially designed
> >> (PLL_DE at 432MHz) in order to be able to feed the TVE.
> > 
> > My experiments and search through BSP code showed that TVE seems to have
> > additional fixed predivider 8. So if you want to generate 27 MHz clock,
> > unit has to be feed with 216 MHz.
> > 
> > TVE has only one PLL source PLL_DE. And since 216 MHz is a bit low for
> > DE2,
> > BSP defaults to 432 MHz for PLL_DE and use divider 2 to generate 216 MHz.
> > This clock is then divided by 8 internaly to get final 27 MHz.
> > 
> > Please note that I don't have any hard evidence to support that, only
> > experimental data. However, only that explanation make sense to me.
> > 
> > BTW, BSP H3/H5 TV driver supports only PAL and NTSC which both use 27 MHz
> > base clock. Further experiments are needed to check if there is any
> > possibility to have other resolutions by manipulating clocks and give
> > other proper settings. I plan to do that, but not in very near future.
> 
> You only have composite video output, and those are the only 2 standard
> resolutions that make any sense.

Right, other resolutions are for VGA.

Anyway, I did some more digging in A10 and R40 datasheets. I think that H3 TVE 
unit is something in between. R40 TVE has a setting to select "up sample". 
Possible settings are 27 MHz, 54 MHz, 108 MHz and 216 MHz. BSP driver on R40 
has this setting enabled only for PAL and NTSC and it is always 216 MHz. I 
think that H3 may have this hardwired to 216 MHz and this would be the reason 
why 216 MHz is needed.

Has anyone else any better explanation?

Best regards,
Jernej
