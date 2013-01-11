From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 04:52:46 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <50EF616E.7040609@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
 <50EF616E.7040609@wwwdotorg.org>
Message-ID: <20130111035246.GB28094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:48:46PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> > directory. The motivation is to collect various host controller drivers
> > in the same location in order to facilitate refactoring.
> > 
> > The Tegra PCIe driver has been largely rewritten, both in order to turn
> > it into a proper platform driver and to add MSI (based on code by
> > Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> 
> > diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
> 
> >  static void __init trimslice_init(void)
> >  {
> >  #ifdef CONFIG_TEGRA_PCI
> > -	int ret;
> > -
> > -	ret = tegra_pcie_init(true, true);
> > -	if (ret)
> > -		pr_err("tegra_pci_init() failed: %d\n", ret);
> > +	platform_device_register(&tegra_pcie_device);
> 
> That struct doesn't actually exist anywhere; only an extern definition
> is added (and that extern definition isn't removed by patch 14 either).

Right, this shouldn't be there. In fact TEGRA_PCI is removed by this
patch, so I should go over the code more carefully again.

> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> 
> > +config PCI_TEGRA
> > +	bool "NVIDIA Tegra PCIe controller"
> > +	depends on ARCH_TEGRA_2x_SOC
> 
> Perhaps depend on ARCH_TEGRA; that will save churn once this is ported
> to Tegra30, and shouldn't cause any problems before then.

Okay, I can do that.

> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> 
> > +#define AFI_INTR_CODE		0xb8
> > +#define  AFI_INTR_CODE_MASK	0xf
> > +#define  AFI_INTR_MASTER_ABORT	4
> > +#define  AFI_INTR_LEGACY	6
> 
> Adding defines for at least some other codes here, would help further
> below ...
> 
> > +static irqreturn_t tegra_pcie_isr(int irq, void *arg)
> 
> > +	if (code == AFI_INTR_MASTER_ABORT) {
> > +		dev_dbg(pcie->dev, "%s, signature: %08x\n", err_msg[code],
> > +			signature);
> > +	} else
> > +		dev_err(pcie->dev, "%s, signature: %08x\n", err_msg[code],
> > +			signature);
> > +
> > +	if (code == 3 || code == 4 || code == 7) {
> 
> ... i.e. here.

Will do.

> 
> > +		u32 fpci = afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
> > +		u64 address = (u64)fpci << 32 | (signature & 0xfffffffc);
> > +		dev_dbg(pcie->dev, "  FPCI address: %10llx\n", address);
> 
> I'd suggest making that dev_err(), or at least something higher than
> debug, since the message indicating the error happened is dev_err(), so
> the complete details may as well be available since they're small.

I can make it conditional on !AFI_INTR_MASTER_ABORT to match the
previous output. Or rather move it into the branches above.

> > +static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
> > +{
> > +	unsigned int timeout;
> > +	unsigned long value;
> > +
> > +	/* enable dual controller and both ports */
> > +	value = afi_readl(pcie, AFI_PCIE_CONFIG);
> > +	value &= ~(AFI_PCIE_CONFIG_PCIEC0_DISABLE_DEVICE |
> > +		   AFI_PCIE_CONFIG_PCIEC1_DISABLE_DEVICE |
> > +		   AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK);
> > +	value |= AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
> > +	afi_writel(pcie, value, AFI_PCIE_CONFIG);
> 
> Eventually, we should probably derive the port enables from the state of
> the root port DT nodes, so that we can disable some and presumably save
> a little power. Also, I notice that the nvidia,num-lanes property isn't
> implemented yet. Still, we can probably take care of this later.

Yes, the plan was to eventually derive the disable bits from the port
status and setup the XBAR_CONFIG field based on the combination of
nvidia,num-lanes properties.

I assume we should simply fail if the configuration specified by
nvidia,num-lanes is invalid?

> > +static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> 
> > +	if (!IS_ERR_OR_NULL(pcie->pex_clk_supply)) {
> 
> Hmm. I think we should make supplies mandatory; it doesn't make sense
> for regulator support to be disabled on Tegra, and where a specific
> board doesn't actually have a regulator, you're supposed to provide a
> dummy fixed regulator so the driver doesn't have to care.
> 
> The same comment obviously applies to tegra_pcie_power_on() and wherever
> regulator_get() happens.

Okay, I'll fix that.

> > +static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> 
> > +	pcie->vdd_supply = devm_regulator_get(pcie->dev, "vdd");
> > +	if (IS_ERR(pcie->vdd_supply))
> > +		return PTR_ERR(pcie->vdd_supply);
> > +
> > +	pcie->pex_clk_supply = devm_regulator_get(pcie->dev, "pex-clk");
> > +	if (IS_ERR(pcie->pex_clk_supply))
> > +		return PTR_ERR(pcie->pex_clk_supply);
> 
> Oh, I guess the regulator_get() calls are already strict.

Yeah, I think they can't return NULL, right? In that case I can just
drop the extra checks in tegra_pcie_power_{on,off}().

> > +static int tegra_pcie_add_port(struct tegra_pcie *pcie, struct device_node *np)
> 
> > +	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&port->list);
> > +	port->index = index;
> > +	port->pcie = pcie;
> > +
> > +	port->base = devm_request_and_ioremap(pcie->dev, &regs);
> > +	if (!port->base)
> > +		return -EADDRNOTAVAIL;
> > +
> > +	if (!tegra_pcie_port_check_link(port)) {
> > +		dev_info(pcie->dev, "link %u down, ignoring\n", port->index);
> 
> Perhaps devm_kfree(port)? Not a big leak, but equally if you don't, it's
> an unreferenced memory block.

I suppose I should do devm_iounmap() and devm_release_mem_region() as
well.

Thanks for reviewing!
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/c0fe7f46/attachment.sig>
