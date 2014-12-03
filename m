From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 03 Dec 2014 10:25:13 +0100
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: enable IPG clock for sdio
 interrupts
In-Reply-To: <1417538845-10867-2-git-send-email-stefan@agner.ch>
References: <1417538845-10867-1-git-send-email-stefan@agner.ch>
 <1417538845-10867-2-git-send-email-stefan@agner.ch>
Message-ID: <1417598713.2419.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 02.12.2014, 17:47 +0100 schrieb Stefan Agner:
> Enable IPG clock for sdio interrupts while runtime PM, since this
> clock is needed for register access. The need of this clock has been
> verified on Vybrid, but this is probably true for i.MX53 and maybe
> others. The need for bus access during runtime suspend has been
> introduced with be138554a792 ("mmc: sdhci: allow sdio interrupts
> while sdhci runtime suspended").
> 
Am I reading this wrong, or is this commit actually doing something
different than what the commit message says?

This does _not_ enable the IPG clock during runtime PM, in fact it is
disabling it while suspending even with SDIO ints enabled, which is
wrong, as no SDIO interrupts will be delivered with this clock disabled.

One thing that seems to be wrong with the current code is that the state
of sdhci_sdio_irq_enabled could change between a runtime suspend and
resume, so to keep the clocks balanced the driver has to remember if it
disabled those two clocks in the suspend path and always enable them in
that case in the resume path.

Regards,
Lucas

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 587ee0e..b7e9ad1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1193,10 +1193,10 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  
>  	ret = sdhci_runtime_suspend_host(host);
>  
> -	if (!sdhci_sdio_irq_enabled(host)) {
> +	if (!sdhci_sdio_irq_enabled(host))
>  		clk_disable_unprepare(imx_data->clk_per);
> -		clk_disable_unprepare(imx_data->clk_ipg);
> -	}
> +
> +	clk_disable_unprepare(imx_data->clk_ipg);
>  	clk_disable_unprepare(imx_data->clk_ahb);
>  
>  	return ret;
> @@ -1208,10 +1208,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  
> -	if (!sdhci_sdio_irq_enabled(host)) {
> +	if (!sdhci_sdio_irq_enabled(host))
>  		clk_prepare_enable(imx_data->clk_per);
> -		clk_prepare_enable(imx_data->clk_ipg);
> -	}
> +
> +	clk_prepare_enable(imx_data->clk_ipg);
>  	clk_prepare_enable(imx_data->clk_ahb);
>  
>  	return sdhci_runtime_resume_host(host);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
