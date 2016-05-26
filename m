From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 May 2016 10:53:30 +0200
Subject: [PATCH 13/20] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <1773896.kpi58ilqqm@avalon>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
 <1773896.kpi58ilqqm@avalon>
Message-ID: <20160526085330.GM9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, May 16, 2016 at 04:24:15PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Monday 16 May 2016 14:47:13 Maxime Ripard wrote:
> > Some boards have an entirely passive RGB to VGA bridge, based on either
> > DACs or resistor ladders.
> > 
> > Those might or might not have an i2c bus routed to the VGA connector in
> > order to access the screen EDIDs.
> > 
> > Add a bridge that doesn't do anything but expose the modes available on the
> > screen, either based on the EDIDs if available, or based on the XGA
> > standards.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../bindings/display/bridge/dumb-vga.txt           |  40 +++++
> >  drivers/gpu/drm/bridge/Kconfig                     |   6 +
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  drivers/gpu/drm/bridge/dumb-vga.c                  | 186 ++++++++++++++++++
> >  4 files changed, 233 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/dumb-vga.txt create mode
> > 100644 drivers/gpu/drm/bridge/dumb-vga.c
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> > b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt new file
> > mode 100644
> > index 000000000000..757f04de97f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> > @@ -0,0 +1,40 @@
> > +Passive RGB to VGA bridge
> > +-------------------------
> > +
> > +This binding is aimed for entirely passive RGB to VGA bridges that do not
> > +require any configuration.
> > +
> > +Required properties:
> > +
> > +- compatible: Should be "dumb-vga-bridge"
> > +
> > +Optional properties:
> > +
> > +- ddc-i2c-bus: phandle to the i2c bus used to communicate with the monitor
> > +
> > +Required nodes:
> > +
> > +This device has one video port. Its connection is modelled using the OF
> > +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> > This +connection is meant to be the RGB input bus.
> 
> Should the bridge have two ports, one input port connected to a display engine 
> and one output port connected to a VGA connector ?

And a separate node for the VGA connector? As far as I can see, all
the other bridges are represented using a single node.

> +static int dumb_vga_get_modes(struct drm_connector *connector)
> > +{
> > +	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> > +	struct edid *edid;
> > +	int ret;
> > +
> > +	if (!vga->ddc)
> > +		goto fallback;
> > +
> > +	edid = drm_get_edid(connector, vga->ddc);
> > +	if (!edid) {
> > +		DRM_INFO("EDID readout failed, falling back to standard modes\n");
> > +		goto fallback;
> > +	}
> > +
> > +	drm_mode_connector_update_edid_property(connector, edid);
> > +	return drm_add_edid_modes(connector, edid);
> > +
> > +fallback:
> > +	/*
> > +	 * In case we cannot retrieve the EDIDs (broken or missing i2c
> > +	 * bus), fallback on the XGA standards
> > +	 */
> > +	ret = drm_add_modes_noedid(connector, 1920, 1200);
> 
> The DRM core adds modes up to 1024x768 in 
> drm_helper_probe_single_connector_modes(). I wonder if it really makes sense 
> to override that in drivers, compared to increasing the maximum resolution in 
> the core. What we can reasonable expect from a VGA monitor doesn't really 
> depend on which display engine it is connected to.

Actually, I would expect it to come from the connectors. Nowadays, the
core add modes that might not even be relevant at all for a given
connector. Take TV as an example, there's not a single TV output that
can reach 1024x768, but actually rely on very different resolutions.

> 
> > +	/* And prefer a mode pretty much anyone can handle */
> > +	drm_set_preferred_mode(connector, 1024, 768);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct drm_encoder *
> > +dumb_vga_best_encoder(struct drm_connector *connector)
> > +{
> > +	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> > +
> > +	return vga->bridge.encoder;
> > +}
> > +
> > +static struct drm_connector_helper_funcs dumb_vga_con_helper_funcs = {
> > +	.get_modes	= dumb_vga_get_modes,
> > +	.best_encoder	= dumb_vga_best_encoder,
> > +};
> > +
> > +static enum drm_connector_status
> > +dumb_vga_connector_detect(struct drm_connector *connector, bool force)
> > +{
> > +	return connector_status_connected;
> 
> Shouldn't that be connector_status_unknown if you have no information about 
> the connection status ?

Probably :)

What are the side effects from such a change? Does it change anything
related to how the fbdev emulation and how the rest of the display
stack detects and enables the outputs whose status are unknown?

> Would it make sense to add an optional GPIO-based connection detection to this 
> driver ?

I asked for it in our prototypes, and apparently, doing VGA cable
detection is really non-trivial, so I don't really expect it to be
found in a lot of designs.

I looked at three different designs done by different vendors, and
none of them have it, so I don't really expect anyone to have it, nor
do I have any hardware to test the code with. However, if there's an
i2c bus, we can always try to probe for the edid, and see if we have
an error. If there's none, then we know something is connected. If
there's an error, we can return connector_status_unknown.

On a set of three samples, only one has that i2c bus, so it might be
just a marginal improvement, but still.


> > +}
> > +
> > +static void
> > +dumb_vga_connector_destroy(struct drm_connector *connector)
> > +{
> > +	drm_connector_cleanup(connector);
> > +}
> > +
> > +static struct drm_connector_funcs dumb_vga_con_funcs = {
> > +	.dpms			= drm_atomic_helper_connector_dpms,
> > +	.detect			= dumb_vga_connector_detect,
> > +	.fill_modes		= drm_helper_probe_single_connector_modes,
> > +	.destroy		= dumb_vga_connector_destroy,
> > +	.reset			= drm_atomic_helper_connector_reset,
> > +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> > +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static int dumb_vga_attach(struct drm_bridge *bridge)
> > +{
> > +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> > +	int ret;
> > +
> > +	if (!bridge->encoder) {
> > +		DRM_ERROR("Missing encoder\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	drm_connector_helper_add(&vga->connector,
> > +				 &dumb_vga_con_helper_funcs);
> > +	ret = drm_connector_init(bridge->dev, &vga->connector,
> > +				 &dumb_vga_con_funcs, DRM_MODE_CONNECTOR_VGA);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to initialize connector\n");
> > +		return ret;
> > +	}
> > +
> > +	drm_mode_connector_attach_encoder(&vga->connector,
> > +					  bridge->encoder);
> > +
> > +	return 0;
> > +}
> > +
> > +static void dumb_vga_nop(struct drm_bridge *bridge) {};
> > +
> > +static struct drm_bridge_funcs dumb_vga_bridge_funcs = {
> > +	.attach		= dumb_vga_attach,
> > +	.enable		= dumb_vga_nop,
> > +	.disable	= dumb_vga_nop,
> > +	.pre_enable	= dumb_vga_nop,
> > +	.post_disable	= dumb_vga_nop,
> > +};
> > +
> > +static int dumb_vga_probe(struct platform_device *pdev)
> > +{
> > +	struct dumb_vga *vga;
> > +	struct device_node *ddc;
> > +
> > +	vga = devm_kzalloc(&pdev->dev, sizeof(*vga), GFP_KERNEL);
> > +	if (!vga)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, vga);
> > +
> > +	ddc = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
> > +	if (ddc) {
> > +		vga->ddc = of_find_i2c_adapter_by_node(ddc);
> 
> You're leaking the reference to the I2C adapter.
> 
> Also, shouldn't you use of_get_i2c_adapter_by_node() ? Otherwise you won't 
> take a reference to the adapter module.

Indeed, I'll fix it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160526/985ae173/attachment.sig>
