From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 06:59:37 +0200
Subject: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
In-Reply-To: <4FD6617C.4090805@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
 <4FD6617C.4090805@wwwdotorg.org>
Message-ID: <20120612045937.GA3669@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds a platform device driver for the PCIe controller on
> > Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> > converted and now initialize and register a corresponding platform
> > device.
> 
> > -static int tegra_pcie_clocks_get(void)
> > +static int tegra_pcie_clocks_get(struct tegra_pcie_info *pcie)
> >  {
> >  	int err;
> >  
> > -	tegra_pcie.pex_clk = clk_get(NULL, "pex");
> > -	if (IS_ERR(tegra_pcie.pex_clk))
> > -		return PTR_ERR(tegra_pcie.pex_clk);
> > +	pcie->pex_clk = clk_get(NULL, "pex");
> > +	if (IS_ERR(pcie->pex_clk))
> > +		return PTR_ERR(pcie->pex_clk);
> 
> While we're changing this, can we convert this to devm_clk_get(), and ...

Will do.

> > -	tegra_pcie.regs = ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
> > -	if (tegra_pcie.regs == NULL) {
> > -		pr_err("PCIE: Failed to map PCI/AFI registers\n");
> > +	regs = request_mem_region(regs->start, resource_size(regs), "PCI/AFI");
> > +	if (regs == NULL) {
> > +		dev_err(&pdev->dev, "failed to request PCI/AFI region: %d\n", err);
> > +		goto err_req_reg;
> > +	}
> > +
> > +	pcie->regs = ioremap_nocache(regs->start, resource_size(regs));
> > +	if (pcie->regs == NULL) {
> > +		dev_err(&pdev->dev, "failed to map PCI/AFI registers\n");
> >  		err = -ENOMEM;
> >  		goto err_map_reg;
> >  	}
> 
> ... that to devm_request_and_ioremap(). That would allow a bunch of the
> cleanup code to be deleted rather than just modified.

Yes, I'll fix that up as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/4cfb6a75/attachment.sig>
