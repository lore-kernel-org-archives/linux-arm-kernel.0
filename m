From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Aug 2013 18:59:39 +0400
Subject: [PATCH v4 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <1377267365-24057-3-git-send-email-zonque@gmail.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-3-git-send-email-zonque@gmail.com>
Message-ID: <521778DB.7040402@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-08-2013 18:16, Daniel Mack wrote:

> At least the AM33xx SoC has a control module register to configure
> details such as the hardware ethernet interface mode.

> I'm not sure whether all SoCs which feature the cpsw block have such a
> register, so that third memory region is considered optional for now.

> Signed-off-by: Daniel Mack <zonque@gmail.com>
[...]

> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 849af52..7a25ff4 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
[...]
> @@ -1999,6 +2000,21 @@ static int cpsw_probe(struct platform_device *pdev)
>   		goto clean_runtime_disable_ret;
>   	}
>
> +	/* If the control memory region is unspecified, continue without it.
> +	 * If it is specified, but we're unable to reserve it, bail.
> +	 */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (!res) {
> +		dev_info(priv->dev, "error getting control i/o resource\n");
> +		goto no_gmii_sel;
> +	}
> +	priv->gmii_sel_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->gmii_sel_reg)) {
> +		dev_err(priv->dev, "unable to map control i/o region\n");

    You didn't actually seem to heed my words about error message. And don't 
you want to do:

	res = PTR_ERR(priv->gmii_sel_reg);

> +		goto clean_runtime_disable_ret;
> +	}
> +
> +no_gmii_sel:
>   	memset(&dma_params, 0, sizeof(dma_params));
>   	memset(&ale_params, 0, sizeof(ale_params));

WBR, Sergei
