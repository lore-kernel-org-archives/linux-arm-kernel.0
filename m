From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 18 Aug 2015 20:25:38 +0200
Subject: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver
 driver
In-Reply-To: <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1463451.tH10lfH9Hm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,


> +static int rk_spdif_probe(struct platform_device *pdev)
> +{
> +	struct rk_spdif_dev *spdif;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +
> +	spdif = devm_kzalloc(&pdev->dev, sizeof(*spdif), GFP_KERNEL);
> +	if (!spdif)
> +		return -ENOMEM;
> +
> +	spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");

I guess this could be named just "hclk" - as it is the identifier local to the 
spdif-ip. (Of course in the binding too)


> +	if (IS_ERR(spdif->hclk)) {
> +		dev_err(&pdev->dev, "Can't retrieve rk_spdif bus clock\n");
> +		return PTR_ERR(spdif->hclk);
> +	}
> +	ret = clk_prepare_enable(spdif->hclk);
> +	if (ret) {
> +		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	spdif->mclk = devm_clk_get(&pdev->dev, "spdif_clk");

The Rockchip TRMs (and the rest of the driver as well) refer to this clock as 
"mclk", so I guess the identifier could just be named the same.


> +	if (IS_ERR(spdif->mclk)) {
> +		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
> +		return PTR_ERR(spdif->hclk);
> +	}
> +
> +	ret = clk_prepare_enable(spdif->mclk);
> +	if (ret) {
> +		dev_err(spdif->dev, "clock enable failed %d\n", ret);
> +		return ret;
> +	}

I guess this plays into what Mark already wrote, but as the code stands right 
now, you enable the mclk here and then through runtime_resume as well, so that 
it stays running all the time, as the refcount is either 2 or 1 but never 0.

Also I don't think mixing devm_clk_get + clk_prepare_enable calls works well. 
If the devm_clk_get(... "spdif_clk") fails, the hclk would stay running right 
now.


[...]

> +static int rk_spdif_remove(struct platform_device *pdev)
> +{
> +	struct rk_spdif_dev *spdif = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		rk_spdif_runtime_suspend(&pdev->dev);
> +
> +	clk_disable_unprepare(spdif->mclk);
> +	clk_disable_unprepare(spdif->hclk);
> +	snd_dmaengine_pcm_unregister(&pdev->dev);
> +	snd_soc_unregister_component(&pdev->dev);

I think the ordering should stay symmetric to the probe function, where you 
have
	clk_enable
	snd_register
so here it should probably be
	snd_unregister 
	clk_disable



Heiko
