From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Nov 2015 13:39:49 +0000
Subject: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
In-Reply-To: <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20151121133949.GH26072@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:
> This patch revises failure flow while pm_runtime_enable().

Why?  This also doesn't apply against current code, please check and
resend.

> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  drivers/spi/spi-mt65xx.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6c1a96e..00a36da 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -607,7 +607,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
> -		goto err_disable_clk;
> +		clk_disable_unprepare(mdata->spi_clk);
> +		goto err_put_master;
>  	}
>  
>  	clk_disable_unprepare(mdata->spi_clk);
> @@ -617,7 +618,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
> -		goto err_put_master;
> +		goto err_disable_runtime_pm;
>  	}
>  
>  	if (mdata->dev_comp->need_pad_sel) {
> @@ -626,14 +627,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  				"pad_num does not match num_chipselect(%d != %d)\n",
>  				mdata->pad_num, master->num_chipselect);
>  			ret = -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>  		}
>  
>  		if (!master->cs_gpios && master->num_chipselect > 1) {
>  			dev_err(&pdev->dev,
>  				"cs_gpios not specified and num_chipselect > 1\n");
>  			ret = -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>  		}
>  
>  		if (master->cs_gpios) {
> @@ -644,7 +645,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  				if (ret) {
>  					dev_err(&pdev->dev,
>  						"can't get CS GPIO %i\n", i);
> -					goto err_put_master;
> +					goto err_disable_runtime_pm;
>  				}
>  			}
>  		}
> @@ -652,8 +653,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_disable_clk:
> -	clk_disable_unprepare(mdata->spi_clk);
> +err_disable_runtime_pm:
> +	pm_runtime_disable(&pdev->dev);
>  err_put_master:
>  	spi_master_put(master);
>  
> -- 
> 1.7.9.5
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151121/ba01b195/attachment.sig>
