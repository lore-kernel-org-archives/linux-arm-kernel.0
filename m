From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 13:46:16 +0100
Subject: [PATCH 2/3] ata: Add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <1384457519-21335-3-git-send-email-lho@apm.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <1384457519-21335-2-git-send-email-lho@apm.com>
 <1384457519-21335-3-git-send-email-lho@apm.com>
Message-ID: <201311151346.17231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013, Loc Ho wrote:
> +
> +/* SATA port 4 - 5 force power down VCO */
> +static void xgene_phy_sata45_macro_pdwn_force_vco(struct xgene_ahci_phy_ctx
> +						     *ctx)
> +{
> +	sds_pcie_toggle1to0(ctx->pcie_base, KC_CLKMACRO_CMU_REGS_CMU_REG0_ADDR,
> +			    CMU_REG0_PDOWN_MASK);
> +	sds_pcie_toggle1to0(ctx->pcie_base,
> +			    KC_CLKMACRO_CMU_REGS_CMU_REG32_ADDR,
> +			    CMU_REG32_FORCE_VCOCAL_START_MASK);
> +}

I think it's bad to have knowledge of specific port numbers in the driver.
Can you change this so that the driver treats all PHYs the same way but
gets the differences between sata/eth/pcie mode from DT properties?


> +void xgene_ahci_serdes_reset_rxa_rxd(struct xgene_ahci_phy_ctx *ctx, int chan)

All functions in the driver should be 'static'. You are not calling these
directly from the SATA driver, are you?

> +	/* Select SATA mux for SATA port 0 - 3 which shared with SGMII ETH */
> +	if (ctx->id < 2) {
> +		if (xgene_phy_host_sata_select(ctx) != 0) {
> +			dev_err(ctx->dev, "SATA%d can not select SATA MUX\n",
> +				ctx->id);
> +			return -1;
> +		}
> +	}

I think all checks for the "id" field are to find out what kind of PHY you
are talking to, the driver itself does not need to know the id, and the
field can be removed if you find that out in a different way.

> +	if (ctx->id == 2) {
> +		/* For 3rd controller, we must also program another resource */
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res) {
> +			dev_err(&pdev->dev,
> +				"no SATA/PCIE PHY resource address\n");
> +			goto error;
> +		}
> +		ctx->pcie_base = devm_ioremap(&pdev->dev, res->start,
> +					      resource_size(res));
> +		if (!ctx->pcie_base) {
> +			dev_err(&pdev->dev,
> +				"can't map SATA/PCIe PHY resource\n");
> +			rc = -ENOMEM;
> +			goto error;
> +		}
> +	}

If you need a second memory resource, I take that as a hint that
the device is actually different from the others, so using a separate
"compatible" string in DT might be more appropriate.

	Arnd
