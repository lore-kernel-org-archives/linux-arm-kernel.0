From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 19 May 2017 20:23:32 +0200
Subject: [linux-sunxi] Re: [RFC PATCH 07/11] drm: sun4i: add support for
 the TV encoder in H3 SoC
In-Reply-To: <3FCDBC05-20A1-460C-A21B-8C3E9C776768@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170519180330.7hpfkdqk3r2x3kn5@flea.home>
 <3FCDBC05-20A1-460C-A21B-8C3E9C776768@aosc.io>
Message-ID: <1958057.WDKm0nQKgW@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne petek, 19. maj 2017 ob 20:08:18 CEST je Icenowy Zheng napisal(a):
> ? 2017?5?20? GMT+08:00 ??2:03:30, Maxime Ripard <maxime.ripard@free-
electrons.com> ??:
> >On Thu, May 18, 2017 at 12:43:50AM +0800, Icenowy Zheng wrote:
> >> Allwinner H3 features a TV encoder similar to the one in earlier
> >
> >SoCs,
> >
> >> but with some different points about clocks:
> >> - It has a mod clock and a bus clock.
> >> - The mod clock must be at a fixed rate to generate signal.
> >
> >Why?
> 
> It's experiment result by Jernej.
> 
> The clock rates in BSP kernel is also specially designed
> (PLL_DE at 432MHz) in order to be able to feed the TVE.

My experiments and search through BSP code showed that TVE seems to have 
additional fixed predivider 8. So if you want to generate 27 MHz clock, unit 
has to be feed with 216 MHz. 

TVE has only one PLL source PLL_DE. And since 216 MHz is a bit low for DE2, 
BSP defaults to 432 MHz for PLL_DE and use divider 2 to generate 216 MHz. This 
clock is then divided by 8 internaly to get final 27 MHz.

Please note that I don't have any hard evidence to support that, only 
experimental data. However, only that explanation make sense to me.

BTW, BSP H3/H5 TV driver supports only PAL and NTSC which both use 27 MHz base 
clock. Further experiments are needed to check if there is any possibility to 
have other resolutions by manipulating clocks and give other proper settings. 
I plan to do that, but not in very near future.

Best regards,
Jernej
