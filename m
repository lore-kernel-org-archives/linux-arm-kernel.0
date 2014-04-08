From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Apr 2014 13:20:57 -0600
Subject: [RFC 3/5] PCI: tegra: Implement accurate power supply scheme
In-Reply-To: <1396622969-17837-4-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-4-git-send-email-treding@nvidia.com>
Message-ID: <53444C19.2080904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 08:49 AM, Thierry Reding wrote:
> The current description of power supplies doesn't match the hardware.
> Instead it's designed to support the needs of current designs, which
> will break as soon as a new design appears that cannot be described
> using the current assumptions.
> 
> In order to fully support all possible future designs, all power supply
> inputs to the PCIe block need to be accurately described and separately
> configurable.

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c

> @@ -930,23 +927,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)

> -	err = regulator_disable(pcie->pex_clk_supply);
> +	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
> -		dev_warn(pcie->dev, "failed to disable pex-clk regulator: %d\n",
> -			 err);
> -
> -	err = regulator_disable(pcie->vdd_supply);
> -	if (err < 0)
> -		dev_warn(pcie->dev, "failed to disable VDD regulator: %d\n",
> -			 err);
> +		dev_warn(pcie->dev, "failed to enable regulators: %d\n", err);

s/enable/disable/
