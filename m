From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 15 May 2018 15:35:11 +0200
Subject: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
In-Reply-To: <abeac1ee792b8f063001c4c280ca7f0167ac59be.camel@paulk.fr>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180509071226.ivh4s3wtczg2u7zw@flea>
 <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
 <20180511085938.wjmdsdjfvdxd4shk@flea>
 <abeac1ee792b8f063001c4c280ca7f0167ac59be.camel@paulk.fr>
Message-ID: <20180515133511.ufsoctkhx5fah7q7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:40:15PM +0200, Paul Kocialkowski wrote:
> Le vendredi 11 mai 2018 ? 10:59 +0200, Maxime Ripard a ?crit :
> > On Wed, May 09, 2018 at 01:31:23PM +0200, Paul Kocialkowski wrote:
> > > On Wed, 2018-05-09 at 09:12 +0200, Maxime Ripard wrote:
> > > > On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> > > > > This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
> > > > > as found on the Ainol AW1 tablet.
> > > > > 
> > > > > The panel also supports RGB888 output. When RGB666 mode is used instead,
> > > > > the two extra lanes per component are grounded.
> > > > > 
> > > > > In the future, it might become necessary to introduce a dedicated
> > > > > device-tree property to specify the bus format to use instead of the
> > > > > default one for the panel. This will allow supporting different bus
> > > > > formats for the same panel modes.
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> > > > >  1 file changed, 26 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > > > > index cbf1ab404ee7..32e30d5a8f08 100644
> > > > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > > > @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn24 = {
> > > > >  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
> > > > >  };
> > > > >  
> > > > > +static const struct drm_display_mode innolux_at070tn90_mode = {
> > > > > +	.clock = 40000,
> > > > > +	.hdisplay = 800,
> > > > > +	.hsync_start = 800 + 112,
> > > > > +	.hsync_end = 800 + 112 + 1,
> > > > > +	.htotal = 800 + 112 + 1 + 87,
> > > > > +	.vdisplay = 480,
> > > > > +	.vsync_start = 480 + 141,
> > > > > +	.vsync_end = 480 + 141 + 1,
> > > > > +	.vtotal = 480 + 141 + 1 + 38,
> > > > > +	.vrefresh = 60,
> > > > > +};
> > > > > +
> > > > > +static const struct panel_desc innolux_at070tn90 = {
> > > > > +	.modes = &innolux_at070tn90_mode,
> > > > > +	.num_modes = 1,
> > > > > +	.size = {
> > > > > +		.width = 154,
> > > > > +		.height = 86,
> > > > > +	},
> > > > > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > > > > +};
> > > > > +
> > > > 
> > > > I'm not really convinced this is the right approach. You said it
> > > > yourself, the panel is using a 24-bits interface, and you just happen
> > > > to have a tablet that routed it using a 18-bits interface instead.
> > > > 
> > > > That doesn't belong in the driver, especially associated to the
> > > > compatible, but where the routing is described: in the device
> > > > tree. And given that the panel interface is a 24 bits panel, if we
> > > > were to have a default, we should have this one, and not the one
> > > > fitting your use case.
> > > 
> > > I fully agree, this is why I suggested introducing a dedicated dt
> > > property for selecting the bus format (in the commit message). I still
> > > proposed this patch as a temporary solution, but I'm definitely willing
> > > to craft a proper solution as well.
> > > 
> > > Here is an initial proposition:
> > > 1. Making bus_format an array in struct panel_desc and listing all the
> > > relevant bus formats that the panel can support there;
> > 
> > I'm not sure this is needed, the input format is always the same in
> > your case, the panel will always take a 24 bits RGB value. What you
> > want to change is the encoder output format (and I guess you want that
> > to be meaningful to enable or not the dithering).
> 
> Isn't the panel format supposed to match what the encoder's output
> should be aiming for? In my case, that would be RGB666, so the idea
> would be specifying both MEDIA_BUS_FMT_RGB666_1X18 and
> MEDIA_BUS_FMT_RGB888_1X24 in a list of supported bus formats for the
> panel.

The width your panel has in input is in 24 bits. The width the encoder
outputs in is 16 bits. This is the panel driver, you should expose the
panel capabilities.

> This way, both my setup and RGB888 setups can be supported.

I don't see what prevents you to do that with my suggestion either.

> > > 2. Introducing an optional "bus-format" dt property that indicates which
> > > bus format to use, and using the first index of the bus formats array if
> > > the property is not present;
> > 
> > I guess the width would be enough, and that way we can take the
> > bus-width format that is already defined (but used in the v4l2
> > framework, not in DRM yet).
> 
> Well, we already have bus-format defines on the DRM side and it feels
> like mapping these directly in device-tree would be more useful as a
> description of the hardware than just having the bus width.

Having the format in the DT doesn't make much sense. A given panel can
support multiple formats, just like a given encoder can.

If you're in that situation, the DT would describe a policy over what
happens in the OS, which isn't what should be stored in the DT. The
bus width, on the other end, is a property of the hardware.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/4d8de971/attachment.sig>
