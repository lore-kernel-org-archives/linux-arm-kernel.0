From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 23 Nov 2011 08:00:27 +0100
Subject: [PATCH 08/17] ASoC: Tegra I2S: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-9-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-9-git-send-email-swarren@nvidia.com>
Message-ID: <20111123070027.GC5255@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.
> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/tegra_i2s.c |   45 +++++++++---------------------------------
>  1 files changed, 10 insertions(+), 35 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
[...]
> @@ -422,43 +422,29 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
>  		ret = -ENOMEM;
> -		goto err_unmap;
> +		goto err_clk_put;
>  	}
>  
>  	tegra_i2s_debug_add(i2s, pdev->id);
>  
>  	return 0;
>  
> -err_unmap:
> -	iounmap(i2s->regs);
> -err_release:
> -	release_mem_region(mem->start, resource_size(mem));
>  err_clk_put:
>  	clk_put(i2s->clk_i2s);
> -err_free:
> -	kfree(i2s);
> -exit:
> +err:
>  	return ret;
>  }
>  
>  static int __devexit tegra_i2s_platform_remove(struct platform_device *pdev)
>  {
>  	struct tegra_i2s *i2s = dev_get_drvdata(&pdev->dev);
> -	struct resource *res;
>  
>  	snd_soc_unregister_dai(&pdev->dev);
>  
>  	tegra_i2s_debug_remove(i2s);
>  
> -	iounmap(i2s->regs);
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -
>  	clk_put(i2s->clk_i2s);
>  
> -	kfree(i2s);
> -
>  	return 0;
>  }
[...]

Is this perhaps missing a dev_set_drvdata(&pdev->dev, NULL) as well?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/59ee7e39/attachment.sig>
