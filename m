From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Aug 2013 09:21:53 -0600
Subject: [RFC 3/3] PCI: tegra: Support driver unbinding
In-Reply-To: <20130815103452.GA13740@ulmo>
References: <1376392346-14127-1-git-send-email-treding@nvidia.com>
 <1376392346-14127-4-git-send-email-treding@nvidia.com>
 <520BFA0C.5070001@wwwdotorg.org> <20130815103452.GA13740@ulmo>
Message-ID: <520CF211.6060003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 04:34 AM, Thierry Reding wrote:
> On Wed, Aug 14, 2013 at 03:43:40PM -0600, Stephen Warren wrote:
>> On 08/13/2013 05:12 AM, Thierry Reding wrote:
>>> Implement the platform driver's .remove() callback to free all
>>> resources allocated during driver setup and call
>>> pci_common_exit() to cleanup ARM specific datastructures. Unmap
>>> the fixed PCI I/O mapping by calling the new pci_iounmap_io()
>>> function in the new .teardown() callback.
>>> 
>>> Finally, no longer set the .suppress_bind_attrs field to true
>>> to allow the driver to unbind from a device.
>> 
>>> +static int tegra_pcie_remove(struct platform_device *pdev) +{ 
>>> +	struct tegra_pcie *pcie = platform_get_drvdata(pdev); +
>>> struct tegra_pcie_bus *bus, *tmp; +	int err; + +
>>> pci_common_exit(&pcie->sys); + +	list_for_each_entry_safe(bus,
>>> tmp, &pcie->busses, list) { +		vunmap(bus->area->addr); +
>>> kfree(bus); +	} + +	if (IS_ENABLED(CONFIG_PCI_MSI)) { +		err =
>>> tegra_pcie_disable_msi(pcie); +		if (err < 0) +			return err; +
>>> }
>> 
>> Wouldn't it make sense to do that as early as possible in the
>> function, to make sure that no MSI accidentally fires after some
>> of the cleanup has already happened?
> 
> I don't think that's strictly necessary in this case. After the
> call to pci_common_exit() there are no PCI devices left, there's
> not even a bus left. All MSI users should have cleaned up after
> themselves.
> 
> Given that I thought it more useful to mirror the setup done in
> .probe() to make it clearer what's being undone (and potentially
> what's missing).

That makes sense SW-wise, but what about mis-behaving HW that triggers
an MSI even when it's been told not to? I assume that
tegra_pcie_disable_msi() unrequests the IRQ, hence solves that
problem, if done early enough.
