From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Jan 2013 13:34:36 -0700
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130111035246.GB28094@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
 <50EF616E.7040609@wwwdotorg.org>
 <20130111035246.GB28094@avionic-0098.adnet.avionic-design.de>
Message-ID: <50F0775C.5050204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 08:52 PM, Thierry Reding wrote:
> On Thu, Jan 10, 2013 at 05:48:46PM -0700, Stephen Warren wrote:
>> On 01/09/2013 01:43 PM, Thierry Reding wrote:
>>> Move the PCIe driver from arch/arm/mach-tegra into the
>>> drivers/pci/host directory. The motivation is to collect
>>> various host controller drivers in the same location in order
>>> to facilitate refactoring.
>>> 
>>> The Tegra PCIe driver has been largely rewritten, both in order
>>> to turn it into a proper platform driver and to add MSI (based
>>> on code by Krishna Kishore <kthota@nvidia.com>) as well as
>>> device tree support.
>> 
>>> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c
>>> b/arch/arm/mach-tegra/board-dt-tegra20.c

>>> +static int tegra_pcie_enable_controller(struct tegra_pcie
>>> *pcie) +{ +	unsigned int timeout; +	unsigned long value; + +	/*
>>> enable dual controller and both ports */ +	value =
>>> afi_readl(pcie, AFI_PCIE_CONFIG); +	value &=
>>> ~(AFI_PCIE_CONFIG_PCIEC0_DISABLE_DEVICE | +
>>> AFI_PCIE_CONFIG_PCIEC1_DISABLE_DEVICE | +
>>> AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK); +	value |=
>>> AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL; +	afi_writel(pcie,
>>> value, AFI_PCIE_CONFIG);
>> 
>> Eventually, we should probably derive the port enables from the
>> state of the root port DT nodes, so that we can disable some and
>> presumably save a little power. Also, I notice that the
>> nvidia,num-lanes property isn't implemented yet. Still, we can
>> probably take care of this later.
> 
> Yes, the plan was to eventually derive the disable bits from the
> port status and setup the XBAR_CONFIG field based on the
> combination of nvidia,num-lanes properties.
> 
> I assume we should simply fail if the configuration specified by 
> nvidia,num-lanes is invalid?

Makes sense to me.

>>> +static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>> 
>>> +	pcie->vdd_supply = devm_regulator_get(pcie->dev, "vdd"); +	if
>>> (IS_ERR(pcie->vdd_supply)) +		return
>>> PTR_ERR(pcie->vdd_supply); + +	pcie->pex_clk_supply =
>>> devm_regulator_get(pcie->dev, "pex-clk"); +	if
>>> (IS_ERR(pcie->pex_clk_supply)) +		return
>>> PTR_ERR(pcie->pex_clk_supply);
>> 
>> Oh, I guess the regulator_get() calls are already strict.
> 
> Yeah, I think they can't return NULL, right? In that case I can
> just drop the extra checks in tegra_pcie_power_{on,off}().

It looks like NULL can be returned if !CONFIG_REGULATOR. The comment
in the dummy implementation implies that drivers should treat a NULL
value as valid regulator in most cases.
