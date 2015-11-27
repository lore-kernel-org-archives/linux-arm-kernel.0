From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 27 Nov 2015 11:34:24 +0100
Subject: [PATCH v2] PCI: imx6: Fix reset-gpio to work with active low GPIO
In-Reply-To: <1448618499-14990-1-git-send-email-ynezz@true.cz>
References: <1448373334.3689.33.camel@pengutronix.de>
 <1448618499-14990-1-git-send-email-ynezz@true.cz>
Message-ID: <1448620464.3689.94.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 27.11.2015, 11:01 +0100 schrieb Petr ?tetiar:
> It's currently not possible to use reset-gpio on board where the GPIO is
> active low as the code incorrectly assumes, that reset-gpio will be
> always active high.
> 
> In my case the broken behavior was observed on Toradex Apalis SoM with
> Ixora base board.
> 
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
> 
> Changes since v1:
>  * reworked to use descriptor based GPIO interface
> 
>  drivers/pci/host/pci-imx6.c |   20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 22e8224..c0e121d 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -32,7 +32,7 @@
>  #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
>  
>  struct imx6_pcie {
> -	int			reset_gpio;
> +	struct gpio_desc	*reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie;
> @@ -287,10 +287,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  	usleep_range(200, 500);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value(imx6_pcie->reset_gpio, 0);
> +	if (imx6_pcie->reset_gpio) {
> +		gpiod_set_value(imx6_pcie->reset_gpio, 0);

This now collides with a fix from Fabio that allows this function to
sleep. So this should use gpiod_set_value_cansleep() and be rebased to
pci/host-imx6, or if Bjorn prefers to pull this in quickly, replace
Fabios commit.

Regards,
Lucas

>  		msleep(100);
> -		gpio_set_value(imx6_pcie->reset_gpio, 1);
> +		gpiod_set_value(imx6_pcie->reset_gpio, 1);
>  	}
>  	return 0;
>  
> @@ -560,7 +560,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct imx6_pcie *imx6_pcie;
>  	struct pcie_port *pp;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct resource *dbi_base;
>  	int ret;
>  
> @@ -581,15 +580,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pp->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
> -					    GPIOF_OUT_INIT_LOW, "PCIe reset");
> -		if (ret) {
> -			dev_err(&pdev->dev, "unable to get reset gpio\n");
> -			return ret;
> -		}
> -	}
> +	imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> +							GPIOD_OUT_LOW);
>  
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
