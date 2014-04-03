From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Apr 2014 14:50:39 +0800
Subject: [PATCH 4/8] PCI: imx6: use new clock names
In-Reply-To: <1396025579-14344-5-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-5-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140403065037.GJ2801@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 05:52:55PM +0100, Lucas Stach wrote:
> As defined in the new binding.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-imx6.c | 74 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ee082509b0ba..71730bbcd9a2 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
...
> @@ -583,32 +574,25 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Fetch clocks */
> -	imx6_pcie->lvds_gate = devm_clk_get(&pdev->dev, "lvds_gate");
> -	if (IS_ERR(imx6_pcie->lvds_gate)) {
> -		dev_err(&pdev->dev,
> -			"lvds_gate clock select missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->lvds_gate);
> -	}
> -
> -	imx6_pcie->sata_ref_100m = devm_clk_get(&pdev->dev, "sata_ref_100m");
> -	if (IS_ERR(imx6_pcie->sata_ref_100m)) {
> +	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
> +	if (IS_ERR(imx6_pcie->pcie_phy)) {

Won't this break the existing DTBs?

Shawn

>  		dev_err(&pdev->dev,
> -			"sata_ref_100m clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->sata_ref_100m);
> +			"pcie_phy clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_phy);
>  	}
>  
> -	imx6_pcie->pcie_ref_125m = devm_clk_get(&pdev->dev, "pcie_ref_125m");
> -	if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
> +	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
> +	if (IS_ERR(imx6_pcie->pcie_bus)) {
>  		dev_err(&pdev->dev,
> -			"pcie_ref_125m clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_ref_125m);
> +			"pcie_bus clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_bus);
>  	}
>  
> -	imx6_pcie->pcie_axi = devm_clk_get(&pdev->dev, "pcie_axi");
> -	if (IS_ERR(imx6_pcie->pcie_axi)) {
> +	imx6_pcie->pcie = devm_clk_get(&pdev->dev, "pcie");
> +	if (IS_ERR(imx6_pcie->pcie)) {
>  		dev_err(&pdev->dev,
> -			"pcie_axi clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_axi);
> +			"pcie clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
>  	/* Grab GPR config register range */
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
