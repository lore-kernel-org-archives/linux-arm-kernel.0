From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 08:21:24 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <4FD66410.7090001@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
 <4FD66410.7090001@wwwdotorg.org>
Message-ID: <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds support for instantiating the Tegra PCIe controller
> > from a device tree.
> 
> > +++ b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
> 
> Can we please name this nvidia,tegra20-pcie.txt to match the naming of
> all the other Tegra bindings.

Yes, will do.

> > +Required properties:
> > +- compatible: "nvidia,tegra20-pcie"
> > +- reg: physical base address and length of the controller's registers
> 
> Since there's more than one range now, that should specify how many
> entries are required and what they represent.

Okay.

> > +Optional properties:
> > +- pex-clk-supply: supply voltage for internal reference clock
> > +- vdd-supply: power supply for controller (1.05V)
> 
> Those shouldn't be optional. If the board has no regulator, the board's
> .dts should provide a fixed always-on regulator that those properties
> can refer to, so that the driver can always get() those regulators.

That'll add more dummy regulators and I don't think sprinkling them across
the DTS is going to work very well. Maybe collecting them under a top-level
"regulators" node is a good option. If you have a better alternative, I'm all
open for it.

> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> 
> > +	pci {
> ...
> > +		status = "disable";
> 
> That should be "disabled"; sorry for providing a bad example.

Yes.

> > diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
> 
> > +static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct platform_device *pdev)
> 
> > +	if (of_find_property(node, "vdd-supply", NULL)) {
> 
> As mentioned above, that if statement should be removed, since the
> regulators shouldn't be optional.

Okay.

> > +		pcie->vdd_supply = regulator_get(&pdev->dev, "vdd");
> 
> Those could be devm_regulator_get(). Then tegra_pcie_remove() wouldn't
> have to put() them.

Okay.

> > +	for (i = 0; i < TEGRA_PCIE_MAX_PORTS; i++)
> > +		pdata->enable_ports[i] = true;
> 
> Shouldn't the DT indicate which ports are used? I assume there's some
> reason that the existing driver allows that to be configured, rather
> than always enabling all ports. At least, enumeration time wasted on
> non-existent ports springs to mind, and perhaps attempting to enable
> port 1 when port 0 is x4 and using all the lanes would cause errors in
> port 0?

Yes, that's been on my mind as well. I'm not sure about the best binding for
this. Perhaps something like:

	pci {
		enable-ports = <0 1 2>;
	};

Would do?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/525d5b8b/attachment.sig>
