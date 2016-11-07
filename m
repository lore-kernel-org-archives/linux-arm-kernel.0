From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 23:37:41 +0100
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161028193420.0f7dc67ea1042ff72b09b701@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
 <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
 <20161027220316.y7u3h4qsfftryrmp@lukather>
 <20161028193420.0f7dc67ea1042ff72b09b701@free.fr>
Message-ID: <20161107223741.gjxj4tqwuxud2iqc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 28, 2016 at 07:34:20PM +0200, Jean-Francois Moine wrote:
> On Fri, 28 Oct 2016 00:03:16 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Tue, Oct 25, 2016 at 04:14:41PM +0200, Jean-Francois Moine wrote:
> > > > > +Display controller
> > > > > +==================
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > +- compatible: value should be one of the following
> > > > > +		"allwinner,sun8i-a83t-display-engine"
> > > > > +		"allwinner,sun8i-h3-display-engine"
> > > > > +
> > > > > +- clocks: must include clock specifiers corresponding to entries in the
> > > > > +		clock-names property.
> > > > > +
> > > > > +- clock-names: must contain
> > > > > +		"gate": for DE activation
> > > > > +		"clock": DE clock
> > > > 
> > > > We've been calling them bus and mod.
> > > 
> > > I can understand "bus" (which is better than "apb"), but why "mod"?
> > 
> > Allwinner has been calling the clocks that are supposed to generate
> > the external signals (depending on where you were looking) module or
> > mod clocks (which is also why we have mod in the clock
> > compatibles). The module 1 clocks being used for the audio and the
> > module 0 for the rest (SPI, MMC, NAND, display, etc.)
> 
> I did not find any 'module' in the H3 documentation.
> So, is it really a good name?

It's true that they use it less nowadays, but they still do,
ie. https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw7.c#L513

And we have to remain consistent anyway.

> > > > > +
> > > > > +- resets: phandle to the reset of the device
> > > > > +
> > > > > +- ports: phandle's to the LCD ports
> > > > 
> > > > Please use the OF graph.
> > > 
> > > These ports are references to the graph of nodes. See
> > > 	http://www.kernelhub.org/?msg=911825&p=2
> > 
> > In an OF-graph, your phandle to the LCD controller would be replaced
> > by an output endpoint.
> 
> This is the DE controller. There is no endpoint link at this level.

The display engine definitely has an endpoint: the TCON.

> The Device Engine just handles the planes of the LCDs, but, indeed,
> the LCDs must know about the DE and the DE must know about the LCDs.
> There are 2 ways to realize this knowledge in the DT:
> 1) either the DE has one or two phandle's to the LCDs,
> 2) or the LCDs have a phandle to the DE.
> 
> I chose the 1st way, the DE ports pointing to the endpoint of the LCDs
> which is part of the video link (OF-graph LCD <-> connector).
> It would be possible to have phandles to the LCDs themselves, but this
> asks for more code.
> 
> The second way is also possible, but it also complexifies a bit the
> exchanges DE <-> LCD.

I'm still not sure how it would complexify anything, and why you can't
use the display graph to model the relation between the display engine
and the TCON (and why you want to use a generic property that refers
to the of-graph while it really isn't).

> > > > > +void de2_disable_vblank(struct drm_device *drm, unsigned crtc)
> > > > > +{
> > > > > +	struct priv *priv = drm->dev_private;
> > > > > +	struct lcd *lcd = priv->lcds[crtc];
> > > > > +
> > > > > +	tcon_write(lcd->mmio, gint0,
> > > > > +			 tcon_read(lcd->mmio, gint0) &
> > > > > +					~TCON_GINT0_TCON1_Vb_Int_En);
> > > > > +}
> > > > > +
> > > > > +/* panel functions */
> > > > 
> > > > Panel functions? In the CRTC driver?
> > > 
> > > Yes, dumb panel.
> > 
> > What do you mean by that? Using a Parallel/RGB interface?
> 
> Sorry, I though this was a well-known name. The 'dump panel' was used
> in the documentation of my previous ARM machine as the video frame sent
> to the HDMI controller. 'video_frame' is OK for you?

If it's the frame sent to the encoder, then it would be the CRTC by
DRM's nomenclature.

> > > > > +static const struct {
> > > > > +	char chan;
> > > > > +	char layer;
> > > > > +	char pipe;
> > > > > +} plane2layer[DE2_N_PLANES] = {
> > > > > +	[DE2_PRIMARY_PLANE] =	{0, 0, 0},
> > > > > +	[DE2_CURSOR_PLANE] =	{1, 0, 1},
> > > > > +	[DE2_VI_PLANE] =	{0, 1, 0},
> > > > > +};
> > > > 
> > > > Comments?
> > > 
> > > This
> > > 	primary plane is channel 0 (VI), layer 0, pipe 0
> > > 	cursor plane is channel 1 (UI), layer 0, pipe 1
> > > 	overlay plane is channel 0 (VI), layer 1, pipe 0
> > > or the full explanation:
> > >     Constraints:
> > > 	The VI channels can do RGB or YUV, while UI channels can do RGB
> > > 	only.
> > > 	The LCD 0 has 1 VI channel and 4 UI channels, while
> > > 	LCD 1 has only 1 VI channel and 1 UI channel.
> > > 	The cursor must go to a channel bigger than the primary channel,
> > > 	otherwise it is not transparent.
> > >     First try:
> > > 	Letting the primary plane (usually RGB) in the 2nd channel (UI),
> > > 	as this is done in the legacy driver, asks for the cursor to go
> > > 	to the next channel (UI), but this one does not exist in LCD1.
> > >     Retained layout:
> > > 	So, we must use only 2 channels for the same behaviour on LCD0
> > > 	(H3) and LCD1 (A83T)
> > > 	The retained combination is:
> > > 		- primary plane in the first channel (VI),
> > > 		- cursor plane inthe 2nd channel (UI), and
> > > 		- overlay plane in the 1st channel (VI).
> > > 
> > > 	Note that there could be 3 overlay planes (a channel has 4
> > > 	layers), but I am not sure that the A83T or the H3 could
> > > 	support 3 simultaneous video streams...
> > 
> > Do you know if the pipe works in the old display engine?
> > 
> > Especially about the two-steps composition that wouldn't allow you to
> > have alpha on all the planes?
> > 
> > If it is similar, I think hardcoding the pipe number is pretty bad,
> > because that would restrict the combination of planes and formats,
> > while some other might have worked.
> 
> From what I understood about the DE2, the pipes just define the priority
> of the overlay channels (one pipe for one channel).
> With the cursor constraint, there must be at least 2 channels in
> order (primary, cursor). Then, with these 2 channels/pipes, there can be
> 6 so-called overlay planes (3 RGB/YUV and 3 RGB only).
> Enabling the pipes 2 and 3 (LCD 0 only) would offer 8 more planes, but
> RGB only. Then, it might be useful to have dynamic pipes.

That's very valuable (and definitely should go into a comment),
thanks!

I still believe that's it should be into a (simple at first)
atomic_check. That would be easier to extend and quite easy to
document and get simply by looking at the code.

> > > > > +static int __init de2_drm_init(void)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +/* uncomment to activate the drm traces at startup time */
> > > > > +/*	drm_debug = DRM_UT_CORE | DRM_UT_DRIVER | DRM_UT_KMS |
> > > > > +			DRM_UT_PRIME | DRM_UT_ATOMIC; */
> > > > 
> > > > That's useless.
> > > 
> > > Right, but it seems that some people don't know how to debug a DRM
> > > driver. This is only a reminder.
> > > 
> > > > > +	DRM_DEBUG_DRIVER("\n");
> > > > > +
> > > > > +	ret = platform_driver_register(&de2_lcd_platform_driver);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = platform_driver_register(&de2_drm_platform_driver);
> > > > > +	if (ret < 0)
> > > > > +		platform_driver_unregister(&de2_lcd_platform_driver);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > 
> > > > And that really shouldn't be done that way.
> > > 
> > > May you explain?
> > 
> > This goes against the whole idea of the device and driver
> > model. Drivers should only register themselves, device should be
> > created by buses (or by using some external components if the bus
> > can't: DT, ACPI, etc.). If there's a match, you get probed.
> > 
> > A driver that creates its own device just to probe itself violates
> > that.
> 
> In this function (module init), there is no driver yet.
> The module contains 2 drivers: the DE (planes) and the LCD (CRTC),
> and there is no macro to handle such modules.

Ah, yes, my bad. I thought you were registering a device and a
driver. Still this is a very unusual pattern. Why do you need to split
the two? Can't you just merge them?

> > > > > +int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
> > > > > +{
> > > > > +	int ret, possible_crtcs = 1 << lcd->crtc_idx;
> > > > > +
> > > > > +	ret = de2_one_plane_init(drm, &lcd->planes[DE2_PRIMARY_PLANE],
> > > > > +				DRM_PLANE_TYPE_PRIMARY, possible_crtcs,
> > > > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > > > > +	if (ret >= 0)
> > > > > +		ret = de2_one_plane_init(drm, &lcd->planes[DE2_CURSOR_PLANE],
> > > > > +				DRM_PLANE_TYPE_CURSOR, possible_crtcs,
> > > > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > > > 
> > > > Nothing looks really special about that cursor plane. Any reasion not
> > > > to make it an overlay?
> > > 
> > > As explained above (channel/layer/pipe plane definitions), the cursor
> > > cannot go in a channel lower or equal to the one of the primary plane.
> > > Then, it must be known and, so, have an explicit plane.
> > 
> > If you were to make it a plane, you could use atomic_check to check
> > this and make sure this doesn't happen. And you would gain a generic
> > plane that can be used for other purposes if needed.
> 
> The function drm_crtc_init_with_planes() offers a cursor plane for free.
> On the other side, having 6 overlay planes is more than the SoCs can
> support.

It's not really for free, it costs you a generic plane that could
definitely be used for something else and cannot anymore because
they've been hardcoded to a cursor.

And having a camera, the VPU or even an application directly output
directly into one of these planes seems a much better use of a generic
plane than a cursor.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/1138769a/attachment.sig>
