From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 26 Apr 2016 11:14:19 +0200
Subject: [PATCH v4 05/11] drm: Add Allwinner A10 Display Engine support
In-Reply-To: <1461590572-4027-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160426111419.63db18d4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 25 Apr 2016 15:22:46 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> The Allwinner A10 and subsequent SoCs share the same display pipeline, with
> variations in the number of controllers (1 or 2), or the presence or not of
> some output (HDMI, TV, VGA) or not.
> 
> Add a driver with a limited set of features for now, and we will hopefully
> support all of them eventually
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Just 2 comments below. Once addressed you can add my

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---

[...]

> +
> +static int sun4i_drv_connector_plug_all(struct drm_device *drm)
> +{
> +	struct drm_connector *connector, *failed;
> +	int ret;
> +
> +	mutex_lock(&drm->mode_config.mutex);
> +	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
> +		ret = drm_connector_register(connector);
> +		if (ret) {
> +			failed = connector;
> +			goto err;
> +		}
> +	}
> +	mutex_unlock(&drm->mode_config.mutex);
> +	return 0;
> +
> +err:
> +	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
> +		if (failed == connector)
> +			break;
> +
> +		drm_connector_unregister(connector);
> +	}
> +	mutex_unlock(&drm->mode_config.mutex);
> +
> +	return ret;
> +}

You can use the generic drm_connector_register_all() to do that.

[...]

> +
> +static void sun4i_drv_unbind(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +

And you probably miss a call to drm_connector_unregister_all() here.

> +	drm_dev_unregister(drm);
> +	drm_kms_helper_poll_fini(drm);
> +	sun4i_framebuffer_free(drm);
> +	drm_vblank_cleanup(drm);
> +	drm_dev_unref(drm);
> +}


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
