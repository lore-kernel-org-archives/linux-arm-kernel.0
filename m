From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 13 Nov 2013 13:32:18 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHY0XVsgNC83XSBzdGFnaW5nOiBpbXgtZHJtOiBwYXJhbGxl?=
 =?UTF-8?B?bCBkaXNwbGF5OiBhZGQgcmVndWxhdG9yIHN1cHBvcnQu?=
In-Reply-To: <1384334603-14208-4-git-send-email-denis@eukrea.com>
References: <1384334603-14208-1-git-send-email-denis@eukrea.com>
 <1384334603-14208-4-git-send-email-denis@eukrea.com>
Message-ID: <1384335138.228918633@f342.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

?????, 13 ?????? 2013, 10:23 +01:00 ?? Denis Carikli <denis@eukrea.com>:
...
> --- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
...
> @@ -139,6 +141,12 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
>  {
>  	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
>  
> +	if (imxpd->disp_reg && !regulator_is_enabled(imxpd->disp_reg)) {

if (!IS_ERR(imxpd->disp_reg) && ...

> +		if (regulator_enable(imxpd->disp_reg))
> +			dev_err(imxpd->dev,
> +				"Failed to enable regulator.\n");
> +	}
> +
>  	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
>  			imxpd->interface_pix_fmt);
>  }
> @@ -155,6 +163,12 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
>  
>  static void imx_pd_encoder_disable(struct drm_encoder *encoder)
>  {
> +	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
> +
> +	if (imxpd->disp_reg && regulator_is_enabled(imxpd->disp_reg)) {

if (!IS_ERR(imxpd->disp_reg) && ...

> +		if (regulator_disable(imxpd->disp_reg))
> +			dev_err(imxpd->dev, "Failed to disable regulator.\n");
> +	}
>  }
>  
>  static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
> @@ -258,6 +272,14 @@ static int imx_pd_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	imxpd->disp_reg = devm_regulator_get(&pdev->dev, "display");
> +	if (IS_ERR(imxpd->disp_reg)) {

if (PTR_ERR(imxpd->disp_reg) == -EPROBE_DEFER)
return -EPROBE_DEFER;

> +		dev_warn(&pdev->dev, "Operating without display regulator.\n");

dev_dbg

> +		imxpd->disp_reg = NULL;

No need set this to NULL;

> +	} else {
> +		dev_info(&pdev->dev, "Using display regulator.\n");

Useless.

...

---
