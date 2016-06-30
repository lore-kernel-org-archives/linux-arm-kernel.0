From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Jun 2016 15:47:28 +0200
Subject: [PATCH] pci: tegra: actually program REFCLK_CFG* on recent SoCs
In-Reply-To: <20160624143703.13231-1-swarren@wwwdotorg.org>
References: <20160624143703.13231-1-swarren@wwwdotorg.org>
Message-ID: <20160630134728.GE26758@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 08:37:03AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
> tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
> part of tegra_pcie_phy_enable() needs to happen in all cases. Move that
> code to tegra_pcie_port_enable() instead.
> 
> For reference, NVIDIA's downstream Linux kernel performs this operation
> in tegra_pcie_enable_rp_features(), which is called immediately after
> tegra_pcie_port_enable(). Since that function doesn't exist in the mainline
> driver, we'll just add it to the tail of tegra_pcie_port_enable() instead.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 74887fedc3d4..2ec64a9e7943 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -541,12 +541,13 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>  
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  {
> -	const struct tegra_pcie_soc_data *soc = port->pcie->soc_data;
> +	struct tegra_pcie *pcie = port->pcie;
> +	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
>  	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
>  	unsigned long value;
>  
>  	/* enable reference clock */
> -	value = afi_readl(port->pcie, ctrl);
> +	value = afi_readl(pcie, ctrl);
>  	value |= AFI_PEX_CTRL_REFCLK_EN;
>  
>  	if (soc->has_pex_clkreq_en)
> @@ -554,9 +555,14 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  
>  	value |= AFI_PEX_CTRL_OVERRIDE_EN;
>  
> -	afi_writel(port->pcie, value, ctrl);
> +	afi_writel(pcie, value, ctrl);
>  
>  	tegra_pcie_port_reset(port);
> +
> +	/* Configure the reference clock driver */
> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
> +	if (soc->num_ports > 2)
> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>  }

This will actually write these two registers for each enabled port,
which, while it shouldn't make a difference, is unnecessary. I've
applied a slightly modified version of this patch. Specifically I moved
this code to the tail of the tegra_pcie_phy_power_on() function, which
is closest to where it was before.

I've also applied the patch that changes the values that are written
into this register, though I reversed the order because that made more
sense to me. I've pushed both patches to the for-4.8/pci branch in the
Tegra tree, can you please take a look if that still looks okay to you?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/a8b7fa3d/attachment-0001.sig>
