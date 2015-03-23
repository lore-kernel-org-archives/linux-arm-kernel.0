From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 Mar 2015 21:54:07 +0100
Subject: [PATCH 03/11] drm: add driver for simple vga encoders
In-Reply-To: <21277731.pHgJosY13N@diego>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
 <10479896.3hQzemuBRM@avalon> <21277731.pHgJosY13N@diego>
Message-ID: <2913851.5ZpddhQmSu@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Am Samstag, 28. Februar 2015, 01:42:45 schrieb Heiko St?bner:
> thanks for the comments
> 
> Am Donnerstag, 26. Februar 2015, 20:33:33 schrieb Laurent Pinchart:
> > On Saturday 31 January 2015 17:32:56 Heiko Stuebner wrote:
> > > There exist simple vga encoders without any type of management interface
> > > and just maybe a simple gpio for turning it on or off. Examples for
> > > these
> > > are the Analog Devices ADV7123, Chipsea CS7123 or Micronas SDA7123.
> > > 
> > > Add a generic encoder driver for those that can be used by drm drivers
> > > using the component framework.
> > 
> > The rcar-du driver already handles the adi,adv7123 compatible string used
> > by this driver. A generic driver is in my opinion a very good idea, but
> > we can't break the existing support. Porting the rcar-du driver to the
> > component model is needed.
> 
> is this in someones plans already? Because I'm still having trouble
> understanding parts of the rockchip driver sometimes, so feel in no way
> qualified to try to get this tackled in some reasonable timeframe :-)

currently my idea is to simply do something like the following for this :-)

static const struct of_device_id rcar_du_of_table[] = {
	{ .compatible = "renesas,du-r8a7779" },
	{ .compatible = "renesas,du-r8a7790" },
	{ .compatible = "renesas,du-r8a7791" },
	{ }
};

static int __init vga_encoder_init(void)
{
	struct device_node *np;

	/*
	 * Play nice with rcar-du that is having its own implementation
	 * of the adv7123 binding implementation and is not yet
	 * converted to using components.
	 */
	np = of_find_matching_node(NULL, rcar_du_of_table);
	if (np) {
		of_node_put(np);
		return 0;
	}

	return platform_driver_register(&vga_encoder_driver);
}


slightly similar to what some iommus do


> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > 
> > >  drivers/gpu/drm/i2c/Kconfig      |   6 +
> > >  drivers/gpu/drm/i2c/Makefile     |   2 +
> > >  drivers/gpu/drm/i2c/vga-simple.c | 325
> > >  ++++++++++++++++++++++++++++++++++++
> > 
> > drivers/gpu/drm/i2c/ feels wrong for a platform device.
> 
> yep, i2c probably being the wrong place was one of the caveats in the cover
> letter and I was hoping some more seasoned drm people could suggest where
> this should live after all.
> 
> As your comments further down suggest that we might introduce some different
> components, simply congregate them in a "components" subdir or something
> splitting them more?

so does a "components" subdir look reasonable?


> > >  3 files changed, 333 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/i2c/vga-simple.c
> > > 
> > > diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
> > > index 22c7ed6..319f2cb 100644
> > > --- a/drivers/gpu/drm/i2c/Kconfig
> > > +++ b/drivers/gpu/drm/i2c/Kconfig
> > > @@ -31,4 +31,10 @@ config DRM_I2C_NXP_TDA998X
> > > 
> > >  	help
> > >  	
> > >  	  Support for NXP Semiconductors TDA998X HDMI encoders.
> > > 
> > > +config DRM_VGA_SIMPLE
> > > +	tristate "Generic simple vga encoder"
> > > +	help
> > > +	  Support for vga encoder chips without any special settings
> > > +	  and at most a power-control gpio.
> > > +
> > > 
> > >  endmenu
> > > 
> > > diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
> > > index 2c72eb5..858961f 100644
> > > --- a/drivers/gpu/drm/i2c/Makefile
> > > +++ b/drivers/gpu/drm/i2c/Makefile
> > > @@ -10,3 +10,5 @@ obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
> > > 
> > >  tda998x-y := tda998x_drv.o
> > >  obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
> > > 
> > > +
> > > +obj-$(CONFIG_DRM_VGA_SIMPLE) += vga-simple.o
> > > diff --git a/drivers/gpu/drm/i2c/vga-simple.c
> > > b/drivers/gpu/drm/i2c/vga-simple.c new file mode 100644
> > > index 0000000..bb9d19c
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/i2c/vga-simple.c
> > > @@ -0,0 +1,325 @@
> > > +/*
> > > + * Simple vga encoder driver
> > > + *
> > > + * Copyright (C) 2014 Heiko Stuebner <heiko@sntech.de>
> > > + *
> > > + * This software is licensed under the terms of the GNU General Public
> > > + * License version 2, as published by the Free Software Foundation, and
> > > + * may be copied, distributed, and modified under those terms.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/component.h>
> > > +#include <linux/gpio.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <drm/drm_of.h>
> > > +#include <drm/drmP.h>
> > > +#include <drm/drm_crtc.h>
> > > +#include <drm/drm_crtc_helper.h>
> > > +#include <drm/drm_edid.h>
> > > +
> > > +#define connector_to_vga_simple(x) container_of(x, struct vga_simple,
> > > connector) +#define encoder_to_vga_simple(x) container_of(x, struct
> > > vga_simple, encoder) +
> > > +struct vga_simple {
> > > +	struct drm_connector connector;
> > > +	struct drm_encoder encoder;
> > > +
> > > +	struct device *dev;
> > > +	struct i2c_adapter *ddc;
> > > +
> > > +	struct regulator *vaa_reg;
> > > +	struct gpio_desc *enable_gpio;
> > > +
> > > +	struct mutex enable_lock;
> > > +	bool enabled;
> > > +};
> > > +
> > > +/*
> > > + * Connector functions
> > > + */
> > > +
> > > +enum drm_connector_status vga_simple_detect(struct drm_connector
> > > *connector, +					    bool force)
> > > +{
> > > +	struct vga_simple *vga = connector_to_vga_simple(connector);
> > > +
> > > +	if (!vga->ddc)
> > > +		return connector_status_unknown;
> > > +
> > > +	if (drm_probe_ddc(vga->ddc))
> > > +		return connector_status_connected;
> > > +
> > > +	return connector_status_disconnected;
> > > +}
> > > +
> > > +void vga_simple_connector_destroy(struct drm_connector *connector)
> > > +{
> > > +	drm_connector_unregister(connector);
> > > +	drm_connector_cleanup(connector);
> > > +}
> > > +
> > > +struct drm_connector_funcs vga_simple_connector_funcs = {
> > > +	.dpms = drm_helper_connector_dpms,
> > > +	.fill_modes = drm_helper_probe_single_connector_modes,
> > > +	.detect = vga_simple_detect,
> > > +	.destroy = vga_simple_connector_destroy,
> > > +};
> > > +
> > > +/*
> > > + * Connector helper functions
> > > + */
> > > +
> > > +static int vga_simple_connector_get_modes(struct drm_connector
> > > *connector)
> > > +{
> > > +	struct vga_simple *vga = connector_to_vga_simple(connector);
> > > +	struct edid *edid;
> > > +	int ret = 0;
> > > +
> > > +	if (!vga->ddc)
> > > +		return 0;
> > > +
> > > +	edid = drm_get_edid(connector, vga->ddc);
> > > +	if (edid) {
> > > +		drm_mode_connector_update_edid_property(connector, edid);
> > > +		ret = drm_add_edid_modes(connector, edid);
> > > +		kfree(edid);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int vga_simple_connector_mode_valid(struct drm_connector
> > > *connector, +					struct drm_display_mode *mode)
> > > +{
> > > +	return MODE_OK;
> > > +}
> > > +
> > > +static struct drm_encoder
> > > +*vga_simple_connector_best_encoder(struct drm_connector *connector)
> > > +{
> > > +	struct vga_simple *vga = connector_to_vga_simple(connector);
> > > +
> > > +	return &vga->encoder;
> > > +}
> > > +
> > > +static struct drm_connector_helper_funcs
> > > vga_simple_connector_helper_funcs
> > > = { +	.get_modes = vga_simple_connector_get_modes,
> > > +	.best_encoder = vga_simple_connector_best_encoder,
> > > +	.mode_valid = vga_simple_connector_mode_valid,
> > > +};
> > > +
> > > +/*
> > > + * Encoder functions
> > > + */
> > > +
> > > +static void vga_simple_encoder_destroy(struct drm_encoder *encoder)
> > > +{
> > > +	drm_encoder_cleanup(encoder);
> > > +}
> > > +
> > > +static const struct drm_encoder_funcs vga_simple_encoder_funcs = {
> > > +	.destroy = vga_simple_encoder_destroy,
> > > +};
> > > +
> > > +/*
> > > + * Encoder helper functions
> > > + */
> > > +
> > > +static void vga_simple_encoder_dpms(struct drm_encoder *encoder, int
> > > mode)
> > > +{
> > > +	struct vga_simple *vga = encoder_to_vga_simple(encoder);
> > > +
> > > +	mutex_lock(&vga->enable_lock);
> > > +
> > > +	switch (mode) {
> > > +	case DRM_MODE_DPMS_ON:
> > > +		if (vga->enabled)
> > > +			goto out;
> > > +
> > > +		if (!IS_ERR(vga->vaa_reg))
> > > +			regulator_enable(vga->vaa_reg);
> > > +
> > > +		if (vga->enable_gpio)
> > > +			gpiod_set_value(vga->enable_gpio, 1);
> > > +
> > > +		vga->enabled = true;
> > > +		break;
> > > +	case DRM_MODE_DPMS_STANDBY:
> > > +	case DRM_MODE_DPMS_SUSPEND:
> > > +	case DRM_MODE_DPMS_OFF:
> > > +		if (!vga->enabled)
> > > +			goto out;
> > > +
> > > +		if (vga->enable_gpio)
> > > +			gpiod_set_value(vga->enable_gpio, 0);
> > > +
> > > +		if (!IS_ERR(vga->vaa_reg))
> > > +			regulator_enable(vga->vaa_reg);
> > > +
> > > +		vga->enabled = false;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +out:
> > > +	mutex_unlock(&vga->enable_lock);
> > > +}
> > > +
> > > +static bool vga_simple_mode_fixup(struct drm_encoder *encoder,
> > > +				  const struct drm_display_mode *mode,
> > > +				  struct drm_display_mode *adjusted_mode)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > > +static void vga_simple_encoder_prepare(struct drm_encoder *encoder)
> > > +{
> > > +}
> > > +
> > > +static void vga_simple_encoder_mode_set(struct drm_encoder *encoder,
> > > +					struct drm_display_mode *mode,
> > > +					struct drm_display_mode *adjusted_mode)
> > > +{
> > > +}
> > > +
> > > +static void vga_simple_encoder_commit(struct drm_encoder *encoder)
> > > +{
> > > +	vga_simple_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> > > +}
> > > +
> > > +static void vga_simple_encoder_disable(struct drm_encoder *encoder)
> > > +{
> > > +	vga_simple_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> > > +}
> > > +
> > > +static const struct drm_encoder_helper_funcs
> > > vga_simple_encoder_helper_funcs = {
> > > +	.dpms = vga_simple_encoder_dpms,
> > > +	.mode_fixup = vga_simple_mode_fixup,
> > > +	.prepare = vga_simple_encoder_prepare,
> > > +	.mode_set = vga_simple_encoder_mode_set,
> > > +	.commit = vga_simple_encoder_commit,
> > > +	.disable = vga_simple_encoder_disable,
> > 
> > this is interesting. Some users of this encoder (I'm thinking about
> > rcar-du, for which I've just posted the patches) are already ported to
> > atomic updates, while others are not. How can we support both ?
> 
> Wild guess, support both in such generic components and let bind decide
> which to use ... is there some sort of drm_is_atomic() against the master
> device.

my hope here is that till I am finished with my part, the atomic conversion 
will have turned up "magically" :-)


> > > +};
> > > +
> > > +/*
> > > + * Component helper functions
> > > + */
> > > +
> > > +static int vga_simple_bind(struct device *dev, struct device *master,
> > > +				 void *data)
> > > +{
> > > +	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct drm_device *drm = data;
> > > +
> > > +	struct device_node *ddc_node, *np = pdev->dev.of_node;
> > > +	struct vga_simple *vga;
> > > +	int ret;
> > > +
> > > +	if (!np)
> > > +		return -ENODEV;
> > > +
> > > +	vga = devm_kzalloc(dev, sizeof(*vga), GFP_KERNEL);
> > > +	if (!vga)
> > > +		return -ENOMEM;
> > > +
> > > +	vga->dev = dev;
> > > +	dev_set_drvdata(dev, vga);
> > > +	mutex_init(&vga->enable_lock);
> > > +
> > > +	vga->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> > > +						   GPIOD_OUT_LOW);
> > > +	if (IS_ERR(vga->enable_gpio)) {
> > > +		ret = PTR_ERR(vga->enable_gpio);
> > > +		dev_err(dev, "failed to request GPIO: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	vga->enabled = false;
> > > +
> > > +	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
> > > +	if (ddc_node) {
> > > +		vga->ddc = of_find_i2c_adapter_by_node(ddc_node);
> > > +		of_node_put(ddc_node);
> > > +		if (!vga->ddc) {
> > > +			dev_dbg(vga->dev, "failed to read ddc node\n");
> > > +			return -EPROBE_DEFER;
> > > +		}
> > > +	} else {
> > > +		dev_dbg(vga->dev, "no ddc property found\n");
> > > +	}
> > > +
> > > +	vga->vaa_reg = devm_regulator_get_optional(dev, "vaa");
> > > +
> > > +	vga->encoder.possible_crtcs = drm_of_find_possible_crtcs(drm, np);
> > > +	vga->encoder.of_node = np;
> > > +	vga->connector.polled = DRM_CONNECTOR_POLL_CONNECT |
> > > +				DRM_CONNECTOR_POLL_DISCONNECT;
> > > +
> > > +	drm_encoder_helper_add(&vga->encoder,
> 
> &vga_simple_encoder_helper_funcs);
> 
> > > +	drm_encoder_init(drm, &vga->encoder, &vga_simple_encoder_funcs,
> > > +			 DRM_MODE_ENCODER_DAC);
> > > +
> > > +	drm_connector_helper_add(&vga->connector,
> > > +				 &vga_simple_connector_helper_funcs);
> > 
> > I really dislike this, this is an encoder driver, not a connector driver.
> > It shouldn't be responsible for creating the connector. For all it knows,
> > there might not even be a VGA connector connected to the encoder, VGA
> > signals could be sent to a chained encoder. That might be a bit
> > far-fetched in the VGA case, but in the generic case encoder drivers
> > shouldn't create connectors.
> 
> ok, so you suggest to have this split. Taking into account Rob's comment
> probably a "simple-encoder" and a "ddc-connector" for connectors using
> system i2c busses? And then connect everything via ports.

having them separate actually looks quite interesting, so definitly no argument 
from me against doing a "vga-encoder" and "vga-connector" driver using the 
already established bindings.


Heiko
