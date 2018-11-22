From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2018 15:45:23 +0100
Subject: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
Message-ID: <20181122154523.5aa652d4@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

Sorry for the delayed review.

On Wed,  3 Oct 2018 15:49:43 +0300, Baruch Siach wrote:

>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -137,6 +139,12 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> +	if (pcie->reset_gpio) {

This should be:

	if (!IS_ERR(pcie->reset_gpio))

Indeed, in the case of an error, pcie->reset_gpio will be non-NULL,
with the error encoded as a ERR_PTR().

> +		/* assert and then deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +		msleep(100);
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +	}
>	dw_pcie_setup_rc(pp);

An empty new line here would be good before the dw_pcie_setup_rc() call.

If you send a new iteration with those two issues fixed, you can
directly add my

  Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
