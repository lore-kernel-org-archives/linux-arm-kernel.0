From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 15:33:04 -0600
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4FD66410.7090001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds support for instantiating the Tegra PCIe controller
> from a device tree.

> +++ b/Documentation/devicetree/bindings/pci/tegra-pcie.txt

Can we please name this nvidia,tegra20-pcie.txt to match the naming of
all the other Tegra bindings.

> +Required properties:
> +- compatible: "nvidia,tegra20-pcie"
> +- reg: physical base address and length of the controller's registers

Since there's more than one range now, that should specify how many
entries are required and what they represent.

> +Optional properties:
> +- pex-clk-supply: supply voltage for internal reference clock
> +- vdd-supply: power supply for controller (1.05V)

Those shouldn't be optional. If the board has no regulator, the board's
.dts should provide a fixed always-on regulator that those properties
can refer to, so that the driver can always get() those regulators.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	pci {
...
> +		status = "disable";

That should be "disabled"; sorry for providing a bad example.

> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c

> +static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct platform_device *pdev)

> +	if (of_find_property(node, "vdd-supply", NULL)) {

As mentioned above, that if statement should be removed, since the
regulators shouldn't be optional.

> +		pcie->vdd_supply = regulator_get(&pdev->dev, "vdd");

Those could be devm_regulator_get(). Then tegra_pcie_remove() wouldn't
have to put() them.

> +	for (i = 0; i < TEGRA_PCIE_MAX_PORTS; i++)
> +		pdata->enable_ports[i] = true;

Shouldn't the DT indicate which ports are used? I assume there's some
reason that the existing driver allows that to be configured, rather
than always enabling all ports. At least, enumeration time wasted on
non-existent ports springs to mind, and perhaps attempting to enable
port 1 when port 0 is x4 and using all the lanes would cause errors in
port 0?
