From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Sat, 30 Sep 2017 10:41:09 +0800
Subject: [PATCH v2] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20170929130435.6805-1-gregory.clement@free-electrons.com>
References: <20170929130435.6805-1-gregory.clement@free-electrons.com>
Message-ID: <20170930104109.60853202@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, 29 Sep 2017 15:04:35 +0200 Gregory CLEMENT wrote:

> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Without this patch the kernel hand during boot if the mvpp2.2 network
> driver was not present in the kernel. Indeed the clock needed by the
> xenon controller was set by the network driver.
> 
> Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core
> functionality)"
> CC: Stable <stable@vger.kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

<snip>

> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 2eec2e652c53..15f912d08a4c 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -466,6 +466,7 @@ static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> +	struct xenon_priv *priv;
>  	int err;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> @@ -474,6 +475,7 @@ static int xenon_probe(struct platform_device *pdev)
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	/*
>  	 * Link Xenon specific mmc_host_ops function,
> @@ -491,9 +493,21 @@ static int xenon_probe(struct platform_device *pdev)
>  	if (err)
>  		goto free_pltfm;
>  
> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> +	if (IS_ERR(priv->axi_clk)) {
> +		err = PTR_ERR(priv->axi_clk);
> +		if (err == -EPROBE_DEFER)
> +			goto err_clk;
> +		priv->axi_clk = NULL;

IMHO, this assignment could be removed. What do you think?

Thanks
