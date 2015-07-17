From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 12:45:48 +0200
Subject: [PATCH V3 11/19] PCI: tegra: Add support for generic PM domains
In-Reply-To: <1436791197-32358-12-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-12-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717104547.GN3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:49PM +0100, Jon Hunter wrote:
> Add support to the tegra PCI driver for generic PM domains. However,
> to ensure backward compatibility with older device tree blobs ensure
> that the driver can work with or without generic PM domains. In order
> to migrate to generic PM domain infrastructure the necessary changes
> are:
> 
> 1. If the "power-domains" property is present in the DT device node then
>    generic PM domains is supported and pm_runtime_enable() should be
>    called for the device. Furthermore, the enabling and disabling of the
>    power-domain is handled via calling pm_runtime_get/put, respectively.
> 
> 2. To ensure that clocks are managed consistently when generic PM domains
>    are used and are not used, drivers should be migrated to use the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
>    functions instead of the current tegra_powergate_sequence_power_up()
>    and tegra_powergate_power_off(). The purpose of the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
>    APIs is to mimick the behaviour of the tegra generic power-domain code,
>    such that if generic power domains are not supported the functionality
>    is the same.
> 
> 3. The main difference between the tegra_powergate_sequence_power_up() API
>    and the tegra_powergate_power_on_legacy() is that the clock used to
>    enable the powergate is not kept enabled when using the
>    tegra_powergate_power_on_legacy() API. Therefore, drivers must enable
>    the clocks they need after calling tegra_powergate_power_on_legacy()
>    and disable these clocks before calling
>    tegra_powergate_power_off_legacy().

This is the same comment as in the DRM patch, and it applies to all
devices that use powergating, so it should move into the preparatory
patch rather than be repeated in all patches.

> 
> The helper functions for handling the powering on and off of the PCI
> controller have been updated to support generic PM domains. The
> tegra_pcie_power_off() was missing code to disable the clocks enabled in
> the tegra_pcie_power_on() function and so this has been added.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 49 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 10c05718dbfd..acd1f311eee5 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -40,6 +40,7 @@
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -908,19 +909,32 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  
>  static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  {
> +	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
>  	int err;
>  
> -	/* TODO: disable and unprepare clocks? */
> -
>  	err = phy_power_off(pcie->phy);
>  	if (err < 0)
>  		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
>  
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
>  
> -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +	clk_disable_unprepare(pcie->pll_e);
> +	if (soc->has_cml_clk)
> +		clk_disable_unprepare(pcie->cml_clk);
> +	clk_disable_unprepare(pcie->afi_clk);
> +	clk_disable_unprepare(pcie->pex_clk);
> +
> +	if (pm_runtime_enabled(pcie->dev)) {
> +		err = pm_runtime_put_sync(pcie->dev);
> +	} else {
> +		err = tegra_powergate_power_off_legacy(TEGRA_POWERGATE_PCIE,
> +						       pcie->pex_clk,
> +						       pcie->pex_rst);
> +	}
> +
> +	if (err < 0)
> +		dev_warn(pcie->dev, "powergate power-down failed: %d\n", err);
>  
>  	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
> @@ -934,20 +948,28 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> -
> -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>  
>  	/* enable regulators */
>  	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
>  		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
>  
> -	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
> -						pcie->pex_clk,
> -						pcie->pex_rst);
> -	if (err) {
> -		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
> +	if (pm_runtime_enabled(pcie->dev)) {
> +		err = pm_runtime_get_sync(pcie->dev);
> +	} else {
> +		err = tegra_powergate_power_on_legacy(TEGRA_POWERGATE_PCIE,
> +						      pcie->pex_clk,
> +						      pcie->pex_rst);
> +	}
> +
> +	if (err < 0) {
> +		dev_err(pcie->dev, "powergate power-up failed: %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(pcie->pex_clk);
> +	if (err < 0) {
> +		dev_err(pcie->dev, "failed to enable PEX clock: %d\n", err);
>  		return err;
>  	}
>  

Couldn't we simply move the above code into suspend/resume functions and
then call pm_runtime_get() and pm_runtime_put() instead of
tegra_pcie_power_on() and tegra_pcie_power_off()?

> @@ -2001,6 +2023,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	pcibios_min_mem = 0;
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "power-domains"))
> +		pm_runtime_enable(&pdev->dev);

Then of course we'd have to call pm_runtime_enable() irrespective of the
property and check for the presence of power domain support via another
method (like the dev->pm_domain field).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/baca9294/attachment.sig>
