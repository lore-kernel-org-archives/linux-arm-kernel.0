From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 15 May 2014 16:07:13 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140513212639.GA18001@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com> <20140513212639.GA18001@atomide.com>
Message-ID: <5374BC01.7030802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/14 00:26, Tony Lindgren wrote:

> +static int sharp_ls_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +
> +	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
> +	if (IS_ERR(ddata->vcc)) {
> +		dev_err(&pdev->dev, "failed to get regulator\n");
> +		return PTR_ERR(ddata->vcc);
> +	}
> +
> +	/* lcd INI */
> +	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
> +	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Hmm, the GPIOs are optional, but shouldn't we react somehow to real
errors? I guess we should do something like:

ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
if (IS_ERR(ddata->ini_gpio) {
	int err = PTR_ERR(ddata->ini_gpio);
	if (err == -EPROBE_DEFER || err != -ENOENT)
		return err;
}

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/b5873065/attachment.sig>
