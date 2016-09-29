From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Sep 2016 16:42:47 -0700
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <20160925205809.GR20761@phenom.ffwll.local>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
 <20160925205809.GR20761@phenom.ffwll.local>
Message-ID: <20160929234246.GA18734@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2016 at 10:58:09PM +0200, Daniel Vetter wrote:
> On Sat, Sep 24, 2016 at 10:26:25PM +0800, Shawn Guo wrote:
> > It adds the initial ZTE VOU display controller DRM driver.  There are
> > still some features to be added, like overlay plane, scaling, and more
> > output devices support.  But it's already useful with dual CRTCs and
> > HDMI monitor working.
> > 
> > It's been tested on Debian Jessie LXDE desktop with modesetting driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I've done a very quick read-through, looks real pretty. A few comments
> below and in-line.

Thanks much for looking at it.

> For testing, have you tried to run i-g-t validation tests per our
> documentation? See https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#validating-changes-with-igt

Sorry for my ignorance on that.  I'm on business travel right now, and
will give it a try once I get back to the hardware.

> >  drivers/gpu/drm/Kconfig          |   2 +
> >  drivers/gpu/drm/Makefile         |   1 +
> >  drivers/gpu/drm/zte/Kconfig      |   8 +
> >  drivers/gpu/drm/zte/Makefile     |   8 +
> >  drivers/gpu/drm/zte/zx_crtc.c    | 691 +++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/zte/zx_crtc.h    |  47 +++
> >  drivers/gpu/drm/zte/zx_drm_drv.c | 258 +++++++++++++++
> >  drivers/gpu/drm/zte/zx_drm_drv.h |  22 ++
> >  drivers/gpu/drm/zte/zx_hdmi.c    | 540 ++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/zte/zx_plane.c   | 362 ++++++++++++++++++++
> >  drivers/gpu/drm/zte/zx_plane.h   |  26 ++
> >  11 files changed, 1965 insertions(+)
> >  create mode 100644 drivers/gpu/drm/zte/Kconfig
> >  create mode 100644 drivers/gpu/drm/zte/Makefile
> >  create mode 100644 drivers/gpu/drm/zte/zx_crtc.c
> >  create mode 100644 drivers/gpu/drm/zte/zx_crtc.h
> >  create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
> >  create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
> >  create mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
> >  create mode 100644 drivers/gpu/drm/zte/zx_plane.c
> >  create mode 100644 drivers/gpu/drm/zte/zx_plane.h
> 
> New entry in MAINTAINERS listening you (and probably dri-devel as the m-l)
> is missing.

Okay.  I will add a patch to do that in the next version.

> > +static int zx_drm_bind(struct device *dev)
> > +{
> > +	struct drm_device *drm;
> > +	struct zx_drm_private *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	drm = drm_dev_alloc(&zx_drm_driver, dev);
> > +	if (!drm)
> > +		return -ENOMEM;
> > +
> > +	drm->dev_private = priv;
> > +	dev_set_drvdata(dev, drm);
> > +
> > +	drm_mode_config_init(drm);
> > +	drm->mode_config.min_width = 16;
> > +	drm->mode_config.min_height = 16;
> > +	drm->mode_config.max_width = 4096;
> > +	drm->mode_config.max_height = 4096;
> > +	drm->mode_config.funcs = &zx_drm_mode_config_funcs;
> > +
> > +	ret = drm_dev_register(drm, 0);
> 
> drm_dev_register should be the last function call in your bind function.
> Similar for unbind, drm_dev_register should be called first.
> 
> As a consequence of that you can remove the drm_connector_(un)register
> calls, those are only needed for hotplugged connectors like dp mst. But
> with correct ordering of drm_dev_(un)register that function will also take
> care of connector registration and unregistration.

Aha, that's the trick to save the call to drm_connector_register() from
connector driver.  Thanks for the info.

> > +static int zx_hdmi_get_edid_block(void *data, u8 *buf, unsigned int block,
> > +				  size_t len)
> > +{
> > +	struct zx_hdmi *hdmi = data;
> > +	int retry = 0;
> > +	int ret = 0;
> > +	int i = 0;
> > +	u8 val;
> > +
> > +	/* Enable DDC master access */
> > +	val = hdmi_readb(hdmi, TPI_DDC_MASTER_EN);
> > +	val |= HW_DDC_MASTER;
> > +	hdmi_writeb(hdmi, TPI_DDC_MASTER_EN, val);
> > +
> > +	hdmi_writeb(hdmi, ZX_DDC_ADDR, 0xa0);
> > +	hdmi_writeb(hdmi, ZX_DDC_OFFSET, block * EDID_LENGTH);
> > +	/* Bits [9:8] of bytes */
> > +	hdmi_writeb(hdmi, ZX_DDC_DIN_CNT2, (len >> 8) & 0xff);
> > +	/* Bits [7:0] of bytes */
> > +	hdmi_writeb(hdmi, ZX_DDC_DIN_CNT1, len & 0xff);
> > +
> > +	/* Clear FIFO */
> > +	val = hdmi_readb(hdmi, ZX_DDC_CMD);
> > +	val &= ~DDC_CMD_MASK;
> > +	val |= DDC_CMD_CLEAR_FIFO;
> > +	hdmi_writeb(hdmi, ZX_DDC_CMD, val);
> > +
> > +	/* Kick off the read */
> > +	val = hdmi_readb(hdmi, ZX_DDC_CMD);
> > +	val &= ~DDC_CMD_MASK;
> > +	val |= DDC_CMD_SEQUENTIAL_READ;
> > +	hdmi_writeb(hdmi, ZX_DDC_CMD, val);
> 
> It looks like the ZX_DDC register range implements a hw i2c engine (since
> you specifiy port and offsets and everything). Please implement it as an
> i2c_adapter driver and use the normal drm_get_edid function.

Okay.  I will give it a try to see if it works.

> > +static int zx_gl_plane_atomic_check(struct drm_plane *plane,
> > +				    struct drm_plane_state *state)
> > +{
> > +	u32 src_w, src_h;
> > +
> > +	src_w = state->src_w >> 16;
> > +	src_h = state->src_h >> 16;
> > +
> > +	/* TODO: support scaling of the plane source */
> > +	if ((src_w != state->crtc_w) || (src_h != state->crtc_h))
> > +		return -EINVAL;
> 
> This is generally not enough checking. You probably need a call to
> drm_plane_helper_check_state.

Okay, will do.

Shawn
