From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 27 Oct 2015 13:24:34 +0000
Subject: [PATCH v5 4/6] memory: mediatek: Add SMI driver
In-Reply-To: <1444357388-30257-5-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <1444357388-30257-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <562F7B12.7030201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/15 03:23, Yong Wu wrote:
[...]
> +static int mtk_smi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_smi_data *smidata;
> +	int ret;
> +
> +	if (!dev->pm_domain)
> +		return -EPROBE_DEFER;
> +
> +	smidata = devm_kzalloc(dev, sizeof(*smidata), GFP_KERNEL);
> +	if (!smidata)
> +		return -ENOMEM;
> +
> +	smidata->clk_apb = devm_clk_get(dev, "apb");
> +	if (IS_ERR(smidata->clk_apb))
> +		return PTR_ERR(smidata->clk_apb);
> +
> +	smidata->clk_smi = devm_clk_get(dev, "smi");
> +	if (IS_ERR(smidata->clk_smi))
> +		return PTR_ERR(smidata->clk_smi);
> +
> +	pm_runtime_enable(dev);
> +	dev_set_drvdata(dev, smidata);
> +	return ret;

ret is used uninitialised here, but you might as well just "return 0;" 
and get rid of the variable entirely.

> +}

Robin.
