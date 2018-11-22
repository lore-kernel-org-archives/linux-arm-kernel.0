From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Nov 2018 15:23:10 +0000
Subject: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
Message-ID: <20181122152310.GA16857@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> This commit adds support for the gpio reset signal binding as described
> in the designware-pcie.txt DT binding document. Both the documented
> 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> supported.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied to pci/dwc for v4.21, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 0c389a30ef5d..b171b6bc15c8 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,6 +22,7 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -29,6 +30,7 @@ struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -137,6 +139,12 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> +	if (pcie->reset_gpio) {
> +		/* assert and then deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +		msleep(100);
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +	}
>  	dw_pcie_setup_rc(pp);
>  	armada8k_pcie_establish_link(pcie);
>  
> @@ -249,6 +257,14 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	/* Get reset gpio signal and hold asserted (logically high) */
> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset_gpio)) {
> +		ret = PTR_ERR(pcie->reset_gpio);
> +		goto fail_clkreg;
> +	}
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = armada8k_add_pcie_port(pcie, pdev);
> -- 
> 2.19.0
> 
