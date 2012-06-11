From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 15:22:04 -0600
Subject: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
In-Reply-To: <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4FD6617C.4090805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds a platform device driver for the PCIe controller on
> Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> converted and now initialize and register a corresponding platform
> device.

> -static int tegra_pcie_clocks_get(void)
> +static int tegra_pcie_clocks_get(struct tegra_pcie_info *pcie)
>  {
>  	int err;
>  
> -	tegra_pcie.pex_clk = clk_get(NULL, "pex");
> -	if (IS_ERR(tegra_pcie.pex_clk))
> -		return PTR_ERR(tegra_pcie.pex_clk);
> +	pcie->pex_clk = clk_get(NULL, "pex");
> +	if (IS_ERR(pcie->pex_clk))
> +		return PTR_ERR(pcie->pex_clk);

While we're changing this, can we convert this to devm_clk_get(), and ...

> -	tegra_pcie.regs = ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
> -	if (tegra_pcie.regs == NULL) {
> -		pr_err("PCIE: Failed to map PCI/AFI registers\n");
> +	regs = request_mem_region(regs->start, resource_size(regs), "PCI/AFI");
> +	if (regs == NULL) {
> +		dev_err(&pdev->dev, "failed to request PCI/AFI region: %d\n", err);
> +		goto err_req_reg;
> +	}
> +
> +	pcie->regs = ioremap_nocache(regs->start, resource_size(regs));
> +	if (pcie->regs == NULL) {
> +		dev_err(&pdev->dev, "failed to map PCI/AFI registers\n");
>  		err = -ENOMEM;
>  		goto err_map_reg;
>  	}

... that to devm_request_and_ioremap(). That would allow a bunch of the
cleanup code to be deleted rather than just modified.
