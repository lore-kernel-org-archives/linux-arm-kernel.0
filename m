From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 23 Nov 2011 08:05:59 +0100
Subject: [PATCH 12/17] ASoC: Tegra+WM8903 machine: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-13-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-13-git-send-email-swarren@nvidia.com>
Message-ID: <20111123070559.GE5255@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.

module_platform_driver

Thierry

> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/tegra_wm8903.c |   26 +++++++-------------------
>  1 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
> index 9b0ee15..33feee8 100644
> --- a/sound/soc/tegra/tegra_wm8903.c
> +++ b/sound/soc/tegra/tegra_wm8903.c
> @@ -390,17 +390,19 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	machine = kzalloc(sizeof(struct tegra_wm8903), GFP_KERNEL);
> +	machine = devm_kzalloc(&pdev->dev, sizeof(struct tegra_wm8903),
> +			       GFP_KERNEL);
>  	if (!machine) {
>  		dev_err(&pdev->dev, "Can't allocate tegra_wm8903 struct\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err;
>  	}
>  
>  	machine->pdata = pdata;
>  
>  	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
>  	if (ret)
> -		goto err_free_machine;
> +		goto err;
>  
>  	card->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, card);
> @@ -431,8 +433,7 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
>  
>  err_fini_utils:
>  	tegra_asoc_utils_fini(&machine->util_data);
> -err_free_machine:
> -	kfree(machine);
> +err:
>  	return ret;
>  }
>  
> @@ -460,8 +461,6 @@ static int __devexit tegra_wm8903_driver_remove(struct platform_device *pdev)
>  
>  	tegra_asoc_utils_fini(&machine->util_data);
>  
> -	kfree(machine);
> -
>  	return 0;
>  }
>  
> @@ -474,18 +473,7 @@ static struct platform_driver tegra_wm8903_driver = {
>  	.probe = tegra_wm8903_driver_probe,
>  	.remove = __devexit_p(tegra_wm8903_driver_remove),
>  };
> -
> -static int __init tegra_wm8903_modinit(void)
> -{
> -	return platform_driver_register(&tegra_wm8903_driver);
> -}
> -module_init(tegra_wm8903_modinit);
> -
> -static void __exit tegra_wm8903_modexit(void)
> -{
> -	platform_driver_unregister(&tegra_wm8903_driver);
> -}
> -module_exit(tegra_wm8903_modexit);
> +module_platform_driver(tegra_wm8903_driver);
>  
>  MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
>  MODULE_DESCRIPTION("Tegra+WM8903 machine ASoC driver");
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/f4782419/attachment.sig>
