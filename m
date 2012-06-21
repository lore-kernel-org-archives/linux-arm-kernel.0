From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 13:30:16 +0800
Subject: [PATCH 1/5] DRM: Add i.MX drm core support
In-Reply-To: <1339681407-28721-2-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120621053014.GB3971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:43:23PM +0200, Sascha Hauer wrote:
...
> +struct drm_device *imx_drm_device_get(void)
> +{
> +	struct imx_drm_device *imxdrm = __imx_drm_device();
> +	struct imx_drm_encoder *enc;
> +	struct imx_drm_connector *con;
> +	struct imx_drm_crtc *crtc;
> +
> +	mutex_lock(&imxdrm->mutex);
> +
> +	list_for_each_entry(enc, &imxdrm->encoder_list, list) {
> +		if (!try_module_get(enc->owner)) {
> +			dev_err(imxdrm->dev, "could not get module %s\n",
> +					module_name(enc->owner));
> +			goto unwind_enc;
> +		}
> +	}
> +
> +	list_for_each_entry(con, &imxdrm->connector_list, list) {
> +		if (!try_module_get(con->owner)) {
> +			dev_err(imxdrm->dev, "could not get module %s\n",
> +					module_name(con->owner));
> +			goto unwind_con;
> +		}
> +	}
> +
> +	list_for_each_entry(crtc, &imxdrm->crtc_list, list) {
> +		if (!try_module_get(crtc->owner)) {
> +			dev_err(imxdrm->dev, "could not get module %s\n",
> +					module_name(crtc->owner));
> +			goto unwind_crtc;
> +		}
> +	}
> +
> +	imxdrm->references++;
> +
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return imx_drm_device->drm;

Though I'm not quite sure about the point of retrieving the static
variable imx_drm_device from calling __imx_drm_device(), shouldn't
imxdrm be used here since you already retrieve it?

> +
> +unwind_crtc:
> +	list_for_each_entry_continue_reverse(crtc, &imxdrm->crtc_list, list)
> +		module_put(crtc->owner);
> +unwind_con:
> +	list_for_each_entry_continue_reverse(con, &imxdrm->connector_list, list)
> +		module_put(con->owner);
> +unwind_enc:
> +	list_for_each_entry_continue_reverse(enc, &imxdrm->encoder_list, list)
> +		module_put(enc->owner);
> +
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(imx_drm_device_get);

...

> +/*
> + * register a connector to the drm core
> + */
> +static int imx_drm_connector_register(
> +		struct imx_drm_connector *imx_drm_connector)
> +{
> +	struct imx_drm_device *imxdrm = __imx_drm_device();
> +	int ret;
> +
> +	drm_connector_init(imxdrm->drm, imx_drm_connector->connector,
> +			imx_drm_connector->connector->funcs,
> +			imx_drm_connector->connector->connector_type);
> +	drm_mode_group_reinit(imxdrm->drm);
> +	ret = drm_sysfs_connector_add(imx_drm_connector->connector);
> +	if (ret)
> +		goto err;

Simply return ret to save the err path?

> +
> +	return 0;
> +err:
> +
> +	return ret;
> +}

...

> +/*
> + * imx_drm_add_encoder - add a new encoder
> + */
> +int imx_drm_add_encoder(struct drm_encoder *encoder,
> +		struct imx_drm_encoder **newenc, struct module *owner)
> +{
> +	struct imx_drm_device *imxdrm = __imx_drm_device();
> +	struct imx_drm_encoder *imx_drm_encoder;
> +	int ret;
> +
> +	mutex_lock(&imxdrm->mutex);
> +
> +	if (imxdrm->references) {
> +		ret = -EBUSY;
> +		goto err_busy;
> +	}
> +
> +	imx_drm_encoder = kzalloc(sizeof(struct imx_drm_encoder), GFP_KERNEL);

sizeof(*imx_drm_encoder)

> +	if (!imx_drm_encoder) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	imx_drm_encoder->encoder = encoder;
> +	imx_drm_encoder->owner = owner;
> +
> +	ret = imx_drm_encoder_register(imx_drm_encoder);
> +	if (ret) {
> +		kfree(imx_drm_encoder);
> +		ret = -ENOMEM;
> +		goto err_register;
> +	}
> +
> +	list_add_tail(&imx_drm_encoder->list, &imxdrm->encoder_list);
> +
> +	*newenc = imx_drm_encoder;
> +
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return 0;
> +
> +err_register:
> +	kfree(imx_drm_encoder);
> +err_alloc:
> +err_busy:
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_drm_add_encoder);

...

> +/*
> + * imx_drm_add_connector - add a connector
> + */
> +int imx_drm_add_connector(struct drm_connector *connector,
> +		struct imx_drm_connector **new_con,
> +		struct module *owner)
> +{
> +	struct imx_drm_device *imxdrm = __imx_drm_device();
> +	struct imx_drm_connector *imx_drm_connector;
> +	int ret;
> +
> +	mutex_lock(&imxdrm->mutex);
> +
> +	if (imxdrm->references) {
> +		ret = -EBUSY;
> +		goto err_busy;
> +	}
> +
> +	imx_drm_connector = kzalloc(sizeof(struct imx_drm_connector),

sizeof(*imx_drm_connector)

> +			GFP_KERNEL);
> +	if (!imx_drm_connector) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	imx_drm_connector->connector = connector;
> +	imx_drm_connector->owner = owner;
> +
> +	ret = imx_drm_connector_register(imx_drm_connector);
> +	if (ret)
> +		goto err_register;
> +
> +	list_add_tail(&imx_drm_connector->list, &imxdrm->connector_list);
> +
> +	*new_con = imx_drm_connector;
> +
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return 0;
> +
> +err_register:
> +	kfree(imx_drm_connector);
> +err_alloc:
> +err_busy:
> +	mutex_unlock(&imxdrm->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_drm_add_connector);

...

> +static int __init imx_drm_init(void)
> +{
> +	int ret;
> +
> +	imx_drm_device = kzalloc(sizeof(*imx_drm_device), GFP_KERNEL);
> +	if (!imx_drm_device)
> +		return -ENOMEM;
> +
> +	mutex_init(&imx_drm_device->mutex);
> +	INIT_LIST_HEAD(&imx_drm_device->crtc_list);
> +	INIT_LIST_HEAD(&imx_drm_device->connector_list);
> +	INIT_LIST_HEAD(&imx_drm_device->encoder_list);
> +
> +	imx_drm_pdev = platform_device_register_simple("imx-drm", -1, NULL, 0);
> +	if (!imx_drm_pdev) {
> +		ret = -EINVAL;
> +		goto err_pdev;
> +	}
> +
> +	imx_drm_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32),
> +
> +	ret = platform_driver_register(&imx_drm_pdrv);
> +	if (ret)
> +		goto err_pdrv;
> +
> +	return 0;
> +
> +err_pdev:
> +	kfree(imx_drm_device);
> +err_pdrv:
> +	platform_device_unregister(imx_drm_pdev);

The order between these two blocks looks wrong.

> +
> +	return ret;
> +}

...

> +static int __init imx_fb_helper_init(void)
> +{
> +	struct drm_device *drm = imx_drm_device_get();
> +
> +	if (!drm)
> +		return -EINVAL;
> +
> +	fbdev_cma = drm_fbdev_cma_init(drm, PREFERRED_BPP,
> +			drm->mode_config.num_crtc, MAX_CONNECTOR);
> +
> +	imx_drm_fb_helper_set(fbdev_cma);
> +
> +	if (IS_ERR(fbdev_cma)) {
> +		imx_drm_device_put();
> +		return PTR_ERR(fbdev_cma);
> +	}

Shouldn't this error check be put right after drm_fbdev_cma_init call?

> +
> +	return 0;
> +}

-- 
Regards,
Shawn
