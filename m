From: Jianwei.Wang@freescale.com (Wang J.W.)
Date: Fri, 17 Jul 2015 03:17:21 +0000
Subject: [PATCH v9 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <20150716113106.GB4635@ulmo>
References: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
 <20150714104913.GI12465@ulmo.nvidia.com>
 <DM2PR0301MB12297B66D33EE9E26F011D9E9F990@DM2PR0301MB1229.namprd03.prod.outlook.com>
 <20150716113106.GB4635@ulmo>
Message-ID: <DM2PR0301MB1229816732FEF8BD31343F1C9F980@DM2PR0301MB1229.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding at gmail.com]
> Sent: Thursday, July 16, 2015 7:31 PM
> To: Wang Jianwei-B52261
> Cc: dri-devel at lists.freedesktop.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> airlied at linux.ie; daniel.vetter at ffwll.ch; mark.yao at rock-chips.com; Wood
> Scott-B07421; Wang Huan-B18965; Xiubo Li
> Subject: Re: [PATCH v9 1/4] drm/layerscape: Add Freescale DCU DRM driver
> 
> On Thu, Jul 16, 2015 at 11:10:29AM +0000, Wang J.W. wrote:
> [...]
> > > -----Original Message-----
> > > From: Thierry Reding [mailto:thierry.reding at gmail.com]
> [...]
> > > On Mon, Jul 13, 2015 at 06:51:29PM +0800, Jianwei Wang wrote:
> [...]
> > > >  DRM DRIVERS FOR NVIDIA TEGRA
> > > >  M:	Thierry Reding <thierry.reding@gmail.com>
> > > >  M:	Terje Bergstr?m <tbergstrom@nvidia.com>
> > > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > > index c46ca31..9cfd14e 100644
> > > > --- a/drivers/gpu/drm/Kconfig
> > > > +++ b/drivers/gpu/drm/Kconfig
> > > > @@ -231,6 +231,8 @@ source "drivers/gpu/drm/virtio/Kconfig"
> > > >
> > > >  source "drivers/gpu/drm/msm/Kconfig"
> > > >
> > > > +source "drivers/gpu/drm/fsl-dcu/Kconfig"
> > > > +
> > >
> > > As mentioned in a different email, I'm somewhat annoyed by the
> > > random placement of these source statements. But we can probably
> > > clean that up in one go and insist on proper ordering when there is
> one.
> > >
> >
> > Ok, I plan to move it to the last line. Is it ok?
> 
> It doesn't really matter, it will be inconsistent no matter what because
> the current ordering isn't consistent. Keep it where it is for now. I'll
> prepare a set of patches to get some consistency into this file.
> 
> > > > +int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
> > > > +				 struct drm_encoder *encoder) {
> > > > +	struct drm_connector *connector = &fsl_dev-
> >connector.connector;
> > > > +	struct device_node *panel_node;
> > > > +	int ret;
> > > > +
> > > > +	fsl_dev->connector.encoder = encoder;
> > >
> > > Why do you need this? The DRM core should set this for you when
> > > setting the initial configuration.
> > >
> >
> > This connector is a private structure fsl_dcu_drm_connector. I set it
> > for select best encoder.
> 
> That doesn't sound right. Technically the DRM core or userspace is going
> to select the encoder for your connector, so it'd be better to derive the
> pointer to your driver-private structure from struct drm_encoder *,
> otherwise you'll end up getting you private copy of the assignment out of
> sync with what the DRM core and/or userspace set up.
> 

Maybe this is a misunderstanding.

fsl_dev->connector.encoder = encoder;
In this sentence fsl_dev and connector are all driver-private structures

Fsl_dev define:
177 struct fsl_dcu_drm_device {
178         struct device *dev;
179         struct device_node *np;
180         struct regmap *regmap;
181         int irq;
182         struct clk *clk;
183         /*protects hardware register*/
184         spinlock_t irq_lock;
185         struct drm_device *drm;
186         struct drm_fbdev_cma *fbdev;
187         struct drm_crtc crtc;
188         struct drm_encoder encoder;
189         struct fsl_dcu_drm_connector connector;  connector is here
190 };

fsl_dcu_drm_connector define:
15 struct fsl_dcu_drm_connector {
16         struct drm_connector base;
17         struct drm_encoder *encoder;
18         struct drm_panel *panel;
19 };
 
And this will be used in .best_encoder hooker

91 static struct drm_encoder *
92 fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
93 {
94         struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
95
96         return fsl_con->encoder;
97 }

I see some other also do it like this. Is it ok?



> Note that you might not run into problems now because you only have a
> single encoder. But if you ever add support for another you're going to
> run into problems with this kind of static assignment.
> 
> > > > +	dev->irq_enabled = true;
> > > > +	dev->vblank_disable_allowed = true;
> > > > +
> > > > +	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0);
> > > > +	if (ret)
> > > > +		dev_err(&pdev->dev, "set DCU_INT_STATUS failed\n");
> > > > +	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &int_mask);
> > > > +	if (ret)
> > > > +		dev_err(&pdev->dev, "read DCU_INT_MASK failed\n");
> > > > +	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, int_mask &
> > > > +			   ~DCU_INT_MASK_VBLANK);
> > > > +	if (ret)
> > > > +		dev_err(&pdev->dev, "set DCU_INT_MASK failed\n");
> > > > +	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
> > > > +			   DCU_UPDATE_MODE_READREG);
> > >
> > > What's this DCU_UPDATE_MODE_READREG bit?
> > >
> >
> > In fact, Only when setting DCU_UPDATE_MODE_READREG bit, it begin to
> > transfer register values. So setting DCU_UPDATE_MODE_READREG bit is a
> > must after registers updating.
> 
> Okay, I see. That's going to be convenient for atomic updates.
> 
> > > > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > > > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > > [...]
> > > > +#define DCU_DISP_SIZE			0x0018
> > > > +#define DCU_DISP_SIZE_DELTA_Y(x)	((x) << 16)
> > > > +/*Regisiter value 1/16 of horizontal resolution*/
> > > > +#define DCU_DISP_SIZE_DELTA_X(x)	((x) >> 4)
> > >
> > > Does this mean the display controller only supports horizontal
> > > resolutions that are a multiple of 16?
> > >
> >
> > Yes.
> 
> You may want to check for this explicitly in the driver and filter out
> modes that you don't support.
 

Ok, I'll add mode check in connector_helper_funcs.mode_valid


> 
> > > > +#ifdef CONFIG_SOC_VF610
> > > > +#define DCU_TOTAL_LAYER_NUM             64
> > > > +#define DCU_LAYER_NUM_MAX               6
> > > > +#else
> > > > +#define DCU_TOTAL_LAYER_NUM             16
> > > > +#define DCU_LAYER_NUM_MAX               4
> > > > +#endif
> > >
> > > Should this not be a runtime decision so that the same driver can
> > > run on
> > > VF610 and LS1021A platforms?
> > >
> >
> > Yes, Both VF610 and LS1021A use DCU as video IP module.
> > And there are a bit of differences on each SoCs.
> 
> Yes, I understand. This should be covered by SoC-specific parameters (via
> the of_device_id table) so that you can run the same kernel on both
> VF610 and LS1021A SoCs.
> 
> As it is, if you build this on a configuration where both VF610 and
> LS1021A are enabled you're going to pick up the values for VF610 and cause
> LS1021A to not work.
 

Very good idea, I'll do it



> 
> > > > +void fsl_dcu_drm_plane_destroy(struct drm_plane *plane) {
> > > > +	fsl_dcu_drm_plane_disable(plane);
> > >
> > > Hmm? This function doesn't do anything, so why not just drop it?
> > >
> >
> >
> > I'll implement fsl_dcu_drm_plane_disable(plane)
> >
> >
> >
> > > > +	drm_plane_cleanup(plane);
> > > > +}
> > >
> > > Also this function and ->atomic_update() should be static. Perhaps
> > > make it a habit of running your build tests with C=1 occasionally to
> > > get notified of this kind of error.
> > >
> > > Thierry
> >
> >
> >
> > One question: How can I set C=1?
> 
> Just add it to the make command-line along with any other parameters, like
> this for example:
> 
> 	$ make ARCH=arm CROSS_COMPILE=armv7l-unknown-linux-gnueabihf- \
> 		O=build/vf610 C=1
> 
> Thierry
 

Thanks

Jianwei
