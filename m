From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Jun 2012 13:29:32 +0800
Subject: [PATCH 2/5] DRM i.MX: Add parallel display support
In-Reply-To: <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120622052929.GA13338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:43:24PM +0200, Sascha Hauer wrote:
> +static int __devinit imx_pd_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const u8 *edidp;
> +	struct imx_parallel_display *imxpd;
> +	int ret;
> +	u32 crtcs[2];

It seems used nowhere.

> +	const char *fmt;
> +	struct device_node *crtc_node;

Ditto.

> +
> +	imxpd = devm_kzalloc(&pdev->dev, sizeof(*imxpd), GFP_KERNEL);
> +	if (!imxpd)
> +		return -ENOMEM;
> +
> +	edidp = of_get_property(np, "edid", &imxpd->edid_len);
> +	if (edidp)
> +		imxpd->edid = kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
> +
> +	ret = of_property_read_string(np, "interface_pix_fmt", &fmt);
> +	if (!ret) {
> +		if (!strcmp(fmt, "rgb24"))
> +			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB24;
> +		else if (!strcmp(fmt, "rgb565"))
> +			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB565;
> +	}
> +
> +	imxpd->dev = &pdev->dev;
> +
> +	ret = imx_pd_register(imxpd);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
> +
> +	platform_set_drvdata(pdev, imxpd);
> +
> +	return 0;
> +}

-- 
Regards,
Shawn
