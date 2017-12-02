From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Sat, 02 Dec 2017 22:58:36 +0100
Subject: [PATCH v2 11/18] drm/sun4i: Add A83T support
In-Reply-To: <20171130153312.plmh2wr4n5njhlvb@flea.lan>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <1722782.9j9JEoLEfc@jernej-laptop> <20171130153312.plmh2wr4n5njhlvb@flea.lan>
Message-ID: <2942946.00TBF2OOZN@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 30. november 2017 ob 16:33:12 CET je Maxime Ripard napisal(a):
> On Tue, Nov 28, 2017 at 11:33:44PM +0100, Jernej ?krabec wrote:
> > Hi!
> > 
> > Dne torek, 28. november 2017 ob 23:00:14 CET je Maxime Ripard napisal(a):
> > > On Tue, Nov 28, 2017 at 04:48:55PM +0100, Jernej ?krabec wrote:
> > > > > On Mon, Nov 27, 2017 at 05:01:49PM +0100, Jernej ?krabec wrote:
> > > > > > Dne ponedeljek, 27. november 2017 ob 16:41:35 CET je Maxime Ripard
> > > > 
> > > > napisal(a):
> > > > > > > Add support for the A83T display pipeline.
> > > > > > > 
> > > > > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |
> > > > > > >  3
> > > > > > >  +++
> > > > > > >  drivers/gpu/drm/sun4i/sun4i_drv.c                             |
> > > > > > >  2
> > > > > > >  ++
> > > > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                            |
> > > > > > >  5
> > > > > > >  +++++
> > > > > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c                           |
> > > > > > >  4
> > > > > > >  ++++
> > > > > > >  4 files changed, 14 insertions(+)
> > > > > > > 
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > > > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > > > index
> > > > > > > d4259a4f5171..d6b52e5c48c0 100644
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > > > 
> > > > > > > @@ -93,6 +93,7 @@ Required properties:
> > > > > > >     * allwinner,sun6i-a31s-tcon
> > > > > > >     * allwinner,sun7i-a20-tcon
> > > > > > >     * allwinner,sun8i-a33-tcon
> > > > > > > 
> > > > > > > +   * allwinner,sun8i-a83t-tcon-lcd
> > > > > > > 
> > > > > > >     * allwinner,sun8i-v3s-tcon
> > > > > > >   
> > > > > > >   - reg: base address and size of memory-mapped region
> > > > > > >   - interrupts: interrupt associated to this IP
> > > > > > > 
> > > > > > > @@ -224,6 +225,7 @@ supported.
> > > > > > > 
> > > > > > >  Required properties:
> > > > > > >    - compatible: value must be one of:
> > > > > > > +    * allwinner,sun8i-a83t-de2-mixer
> > > > > > 
> > > > > > What will be the name of the second mixer, once support for HDMI
> > > > > > is
> > > > > > added?
> > > > > > Should we start directly with 0 and 1 postfix ?
> > > > > 
> > > > > What are the differences exactly without the two mixers?
> > > > 
> > > > Mixer properties:
> > > > - mixer index (0 or 1), important for determining CCSC base (see my
> > > > patches)
> > > 
> > > Is that the only thing we need to determine?
> > 
> > For now, mixer index is important only for determining CCSC base in
> > conjuction with VEP capability. Obviously, I can't exclude that there is
> > some other case where that mixer index is needed.
> 
> That's unfortunate...

I take a deeper look today about that issue and it seems that mixer index is 
really needed only here. I did only regex search and not line by line check, 
so take this with grain of salt.

Additionally, it seems that this comparison is kind of a hack for V3s. Channel 
output CSC is done through VEP (video enhancement processor, maybe?) unit. 
Those units are only on VI channels. But every SoC with DE2 I checked except 
V3s have 1 VI channel and VEP enabled on first mixer. V3s on the other hand 
have 2 VI channels and no VEP, but same addresses should work for channel 
output CSC according to the code. Of course, that is only a theory, but if you 
want, we can go with quirks structure. Or better yet, with quirk property, 
since there may be some (future?) SoC with two mixers and no VEP unit 
supported.

BTW, how should be DE3 on H6 handled in the future? Registers offsets seems to 
be same within same DE2 and DE3 units, just extended. However, some base 
addresses are different, for example, those connected to VEP. I don't think 
new driver is needed, just some quirks structure which would tell DE version.

Best regards,
Jernej

> 
> > Can't we just add reg property for that?
> 
> No, reg is here specifically for the bus address, not for an index,
> and in general, indices are poorly perceived and have been subject to
> a lot of debate in the past. Hence why I'd really like to avoid any
> solution looking like this. But I guess we don't really have the
> choice either.
> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
