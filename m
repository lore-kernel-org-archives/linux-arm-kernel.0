From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 15:56:28 +0000
Subject: [PATCH v2 1/8] drm/bridge: rgb-to-vga: Support an enable GPIO
In-Reply-To: <20161026221724.55yufeql6s5nd5gq@lukather>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-2-wens@csie.org>
 <20161026221346.tdpmbrwca4jehch2@rob-hp-laptop>
 <20161026221724.55yufeql6s5nd5gq@lukather>
Message-ID: <20161031155628.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 12:17:24AM +0200, Maxime Ripard wrote:
> Hi Rob,
> 
> On Wed, Oct 26, 2016 at 05:13:46PM -0500, Rob Herring wrote:
> > On Thu, Oct 20, 2016 at 11:43:37AM +0800, Chen-Yu Tsai wrote:
> > > Some rgb-to-vga bridges have an enable GPIO, either directly tied to
> > > an enable pin on the bridge IC, or indirectly controlling a power
> > > switch.
> > > 
> > > Add support for it.
> > > 
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  .../bindings/display/bridge/dumb-vga-dac.txt       |  2 ++
> > >  drivers/gpu/drm/bridge/dumb-vga-dac.c              | 28 ++++++++++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > > index 003bc246a270..d3484822bf77 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > > +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> > > @@ -16,6 +16,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> > >  - Video port 0 for RGB input
> > >  - Video port 1 for VGA output
> > >  
> > > +Optional properties:
> > > +- enable-gpios: GPIO pin to enable or disable the bridge
> > 
> > This should also define the active state.
> > 
> > > +static void dumb_vga_enable(struct drm_bridge *bridge)
> > > +{
> > > +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> > > +
> > > +	if (vga->enable_gpio)
> > > +		gpiod_set_value_cansleep(vga->enable_gpio, 1);
> > 
> > So the driver should allow either active high or low.
> 
> You mean like having a enable-active-high property? Isn't that
> redundant with the GPIO flags?

Correct - the gpiod APIs remove the need for drivers to know the
polarity of the signal, handling it inside the GPIO subsystem
instead, controlled either from the gpiod lookup tables in legacy
board files, or the DT specification for the GPIO.

So, in drivers, gpiod_set_value*(, 1) means "set gpio to active
level" and gpiod_set_value*(, 0) means "set gpio to inactive level".

Far nicer than all the bugs we've had with the legacy GPIO interfaces
with random different drivers implementing random different ways to
invert the signal, with all the pain that brings with it when a
platform comes along with a different inversion state.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
