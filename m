From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Oct 2016 00:17:24 +0200
Subject: [PATCH v2 1/8] drm/bridge: rgb-to-vga: Support an enable GPIO
In-Reply-To: <20161026221346.tdpmbrwca4jehch2@rob-hp-laptop>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-2-wens@csie.org>
 <20161026221346.tdpmbrwca4jehch2@rob-hp-laptop>
Message-ID: <20161026221724.55yufeql6s5nd5gq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Oct 26, 2016 at 05:13:46PM -0500, Rob Herring wrote:
> On Thu, Oct 20, 2016 at 11:43:37AM +0800, Chen-Yu Tsai wrote:
> > Some rgb-to-vga bridges have an enable GPIO, either directly tied to
> > an enable pin on the bridge IC, or indirectly controlling a power
> > switch.
> > 
> > Add support for it.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  .../bindings/display/bridge/dumb-vga-dac.txt       |  2 ++
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c              | 28 ++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > index 003bc246a270..d3484822bf77 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > @@ -16,6 +16,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> >  - Video port 0 for RGB input
> >  - Video port 1 for VGA output
> >  
> > +Optional properties:
> > +- enable-gpios: GPIO pin to enable or disable the bridge
> 
> This should also define the active state.
> 
> > +static void dumb_vga_enable(struct drm_bridge *bridge)
> > +{
> > +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> > +
> > +	if (vga->enable_gpio)
> > +		gpiod_set_value_cansleep(vga->enable_gpio, 1);
> 
> So the driver should allow either active high or low.

You mean like having a enable-active-high property? Isn't that
redundant with the GPIO flags?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/b9eb1a24/attachment.sig>
