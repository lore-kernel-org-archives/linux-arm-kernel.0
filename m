From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 30 Sep 2016 13:34:14 +0100
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACvgo51feNJYrHaKT+M06Z7kOUqzYo1Uv_TAHdLhNXPtRUwsvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

A couple of fly-by suggestions, which I hope you'll find useful :-)

On 24 September 2016 at 15:26, Shawn Guo <shawn.guo@linaro.org> wrote:

> +
 > +       val = ((vm.hsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
To save some writing/minimise the chances to typos getting, in you can
have single/collection to static inline functions similar to msm [1].
On a similar note inline wrappers zte_read/write/mask (around
writel/readl) will provide quite useful for debugging/tracing :-)

[1] drivers/gpu/drm/msm/adreno/a4xx.xml.h


> +       if (IS_ERR(zcrtc->pixclk))
> +               return ERR_PTR(PTR_ERR(zcrtc->pixclk));
You might want to s/ERR_PTR(PTR_ERR// or s/ERR_PTR(PTR_ERR/ERR_CAST/
through the patch.


> +static int zx_drm_bind(struct device *dev)
> +{
> +       struct drm_device *drm;
> +       struct zx_drm_private *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       drm = drm_dev_alloc(&zx_drm_driver, dev);
> +       if (!drm)
> +               return -ENOMEM;
> +
> +       drm->dev_private = priv;
> +       dev_set_drvdata(dev, drm);
> +
> +       drm_mode_config_init(drm);
> +       drm->mode_config.min_width = 16;
> +       drm->mode_config.min_height = 16;
> +       drm->mode_config.max_width = 4096;
> +       drm->mode_config.max_height = 4096;
> +       drm->mode_config.funcs = &zx_drm_mode_config_funcs;
> +
> +       ret = drm_dev_register(drm, 0);
The documentation states that drm_dev_register() should be called
after the hardware is setup. which some drivers seems to interpret as
...

> +       if (ret)
> +               goto out_free;
> +
> +       ret = component_bind_all(dev, drm);
> +       if (ret) {
> +               DRM_ERROR("Failed to bind all components\n");
> +               goto out_unregister;
> +       }
> +
> +       ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +       if (ret < 0) {
> +               DRM_ERROR("failed to initialise vblank\n");
> +               goto out_unbind;
> +       }
> +
> +       /*
> +        * We will manage irq handler on our own.  In this case, irq_enabled
> +        * need to be true for using vblank core support.
> +        */
> +       drm->irq_enabled = true;
> +
> +       drm_mode_config_reset(drm);
> +       drm_kms_helper_poll_init(drm);
> +
> +       priv->fbdev = drm_fbdev_cma_init(drm, 32, drm->mode_config.num_crtc,
> +                                        drm->mode_config.num_connector);
... calling it after these. If that's the correct case - perhaps we
can throw a WARN or similar within the above functions to catch
present/future misuse ?


> +       if (IS_ERR(priv->fbdev)) {
> +               ret = PTR_ERR(priv->fbdev);
> +               priv->fbdev = NULL;
> +               goto out_fini;
> +       }
> +
> +       return 0;
> +
> +out_fini:
> +       drm_kms_helper_poll_fini(drm);
> +       drm_mode_config_cleanup(drm);
> +       drm_vblank_cleanup(drm);
> +out_unbind:
> +       component_unbind_all(dev, drm);
> +out_unregister:
> +       drm_dev_unregister(drm);
> +out_free:
> +       dev_set_drvdata(dev, NULL);
> +       drm_dev_unref(drm);
> +       return ret;
> +}
> +
> +static void zx_drm_unbind(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +       struct zx_drm_private *priv = drm->dev_private;
> +
> +       if (priv->fbdev) {
> +               drm_fbdev_cma_fini(priv->fbdev);
> +               priv->fbdev = NULL;
> +       }
> +       drm_kms_helper_poll_fini(drm);
> +       component_unbind_all(dev, drm);
> +       drm_vblank_cleanup(drm);
> +       drm_mode_config_cleanup(drm);
> +       drm_dev_unregister(drm);
> +       drm_dev_unref(drm);
> +       drm->dev_private = NULL;
> +       dev_set_drvdata(dev, NULL);
This and the teardown path in bind() are asymmetrical. Furthermore you
want to call drm_dev_unregister() first, according to its
documentation.
As mentioned above - perhaps it's worth providing feedback for drivers
which get the order wrong ?



> +static int zx_hdmi_bind(struct device *dev, struct device *master, void *data)
> +{


> +
> +       clk_prepare_enable(hdmi->cec_clk);
> +       clk_prepare_enable(hdmi->osc_clk);
> +       clk_prepare_enable(hdmi->xclk);
> +
> +       ret = zx_hdmi_register(drm, hdmi);
> +       if (ret)
> +               return ret;
> +

> +       return 0;
> +}
> +
> +static void zx_hdmi_unbind(struct device *dev, struct device *master,
> +                          void *data)
> +{
> +       struct zx_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(hdmi->cec_clk);
> +       clk_disable_unprepare(hdmi->osc_clk);
> +       clk_disable_unprepare(hdmi->xclk);
Nit: you want the teardown to happen in reverse order of the setup. I
might have missed a few similar cases within the patch, so please
double-check.


> +static int zx_gl_get_fmt(uint32_t format)
> +{
> +       switch (format) {
> +       case DRM_FORMAT_ARGB8888:
> +       case DRM_FORMAT_XRGB8888:
> +               return GL_FMT_ARGB8888;
> +       case DRM_FORMAT_RGB888:
> +               return GL_FMT_RGB888;
> +       case DRM_FORMAT_RGB565:
> +               return GL_FMT_RGB565;
> +       case DRM_FORMAT_ARGB1555:
> +               return GL_FMT_ARGB1555;
> +       case DRM_FORMAT_ARGB4444:
> +               return GL_FMT_ARGB4444;
> +       default:
> +               WARN_ONCE(1, "invalid pixel format %d\n", format);
> +               return -EINVAL;
Afaics the only user of this is atomic_update() and that function
cannot fail. You might want to move this to the _check() function.
Same logic goes for the rest of the driver, in case I've missed any.


Regards,
Emil
