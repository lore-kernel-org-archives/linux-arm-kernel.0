From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 28 Nov 2017 23:33:44 +0100
Subject: [PATCH v2 11/18] drm/sun4i: Add A83T support
In-Reply-To: <20171128220014.w35rcliusubfdvoe@flea.home>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <2908242.WKit1ZIWoJ@jernej-laptop>
 <20171128220014.w35rcliusubfdvoe@flea.home>
Message-ID: <1722782.9j9JEoLEfc@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne torek, 28. november 2017 ob 23:00:14 CET je Maxime Ripard napisal(a):
> On Tue, Nov 28, 2017 at 04:48:55PM +0100, Jernej ?krabec wrote:
> > > On Mon, Nov 27, 2017 at 05:01:49PM +0100, Jernej ?krabec wrote:
> > > > Dne ponedeljek, 27. november 2017 ob 16:41:35 CET je Maxime Ripard
> > 
> > napisal(a):
> > > > > Add support for the A83T display pipeline.
> > > > > 
> > > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > ---
> > > > > 
> > > > >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3
> > > > >  +++
> > > > >  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 2
> > > > >  ++
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 5
> > > > >  +++++
> > > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c                           | 4
> > > > >  ++++
> > > > >  4 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > index
> > > > > d4259a4f5171..d6b52e5c48c0 100644
> > > > > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > 
> > > > > @@ -93,6 +93,7 @@ Required properties:
> > > > >     * allwinner,sun6i-a31s-tcon
> > > > >     * allwinner,sun7i-a20-tcon
> > > > >     * allwinner,sun8i-a33-tcon
> > > > > 
> > > > > +   * allwinner,sun8i-a83t-tcon-lcd
> > > > > 
> > > > >     * allwinner,sun8i-v3s-tcon
> > > > >   
> > > > >   - reg: base address and size of memory-mapped region
> > > > >   - interrupts: interrupt associated to this IP
> > > > > 
> > > > > @@ -224,6 +225,7 @@ supported.
> > > > > 
> > > > >  Required properties:
> > > > >    - compatible: value must be one of:
> > > > > +    * allwinner,sun8i-a83t-de2-mixer
> > > > 
> > > > What will be the name of the second mixer, once support for HDMI is
> > > > added?
> > > > Should we start directly with 0 and 1 postfix ?
> > > 
> > > What are the differences exactly without the two mixers?
> > 
> > Mixer properties:
> > - mixer index (0 or 1), important for determining CCSC base (see my
> > patches)
> Is that the only thing we need to determine?

For now, mixer index is important only for determining CCSC base in conjuction 
with VEP capability. Obviously, I can't exclude that there is some other case 
where that mixer index is needed.

Can't we just add reg property for that?

> 
> > - number of VI planes (usually 1)
> 
> Usually or always?

V3s mixer has 2 VI channels and others have 1.

(Channel is better term, since is used throughout BSP code)

> 
> > - number of UI planes (usually 1 or 3)
> 
> Same question.

For now, most SoCs (I didn't check all) have 3 UI channels on first mixer and 1 
UI channel on second mixer. Except V3s, which have only one mixer with 1 UI 
channel.

> 
> > - writeback support (yes/no)
> > - scale line buffer length (2048 or 4096)
> > - smart backligth support (yes/no)
> > 
> > channel properties (for both, VI and UI):
> > - scaler support (yes/no, usually yes)

Again, V3s is exception here. Scaler is not supported on UI channel, but other 
SoCs have scalers on all channels.

Disclaimer: I didn't check DE2 capabilities of all SoCs, only few populars.

Best regards,
Jernej

> > - overlay count (seems to be always 4)
> > - VEP support (yes/no)
> > 
> > Those are properties found in BSP de_feat.c, so I guess that's enough to
> > make any kind of decision in the code.
> > 
> > Usually, but we can't count on that, first mixer has 1 VI and 3 UI planes
> > and second mixer has 1 VI and 1 UI plane.
> 
> Right. So that would be easy to support using a property as well. The
> only difference would be the CSC base.
> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
