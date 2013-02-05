From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 05 Feb 2013 12:43:42 +0000
Subject: [PATCH 1/2] spi: sirf: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130205124342.EB5AC3E0E27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Dec 2012 10:48:33 +0800, Barry Song <Barry.Song@csr.com> wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-sirf.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index e0f43a5..38a191c 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -570,7 +570,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>  		ret = -EINVAL;
>  		goto free_pin;
>  	}
> -	clk_enable(sspi->clk);
> +	clk_prepare_enable(sspi->clk);
>  	sspi->ctrl_freq = clk_get_rate(sspi->clk);
>  
>  	init_completion(&sspi->done);
> @@ -594,7 +594,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  free_clk:
> -	clk_disable(sspi->clk);
> +	clk_disable_unprepare(sspi->clk);
>  	clk_put(sspi->clk);
>  free_pin:
>  	pinctrl_put(sspi->p);
> @@ -618,7 +618,7 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
>  		if (sspi->chipselect[i] > 0)
>  			gpio_free(sspi->chipselect[i]);
>  	}
> -	clk_disable(sspi->clk);
> +	clk_disable_unprepare(sspi->clk);
>  	clk_put(sspi->clk);
>  	pinctrl_put(sspi->p);
>  	spi_master_put(master);
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
