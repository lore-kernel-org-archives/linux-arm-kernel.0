From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 Aug 2013 23:52:08 +0200
Subject: [RFC 3/3] PCI: tegra: Support driver unbinding
In-Reply-To: <52128650.7090009@wwwdotorg.org>
References: <1376392346-14127-1-git-send-email-treding@nvidia.com>
 <1376392346-14127-4-git-send-email-treding@nvidia.com>
 <520BFA0C.5070001@wwwdotorg.org> <20130815103452.GA13740@ulmo>
 <520CF211.6060003@wwwdotorg.org> <20130819201623.GD5191@mithrandir>
 <52128650.7090009@wwwdotorg.org>
Message-ID: <20130819215208.GC9885@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 02:55:44PM -0600, Stephen Warren wrote:
> On 08/19/2013 02:16 PM, Thierry Reding wrote:
> > On Thu, Aug 15, 2013 at 09:21:53AM -0600, Stephen Warren wrote:
> >> On 08/15/2013 04:34 AM, Thierry Reding wrote:
> >>> On Wed, Aug 14, 2013 at 03:43:40PM -0600, Stephen Warren
> >>> wrote:
> >>>> On 08/13/2013 05:12 AM, Thierry Reding wrote:
> >>>>> Implement the platform driver's .remove() callback to free
> >>>>> all resources allocated during driver setup and call 
> >>>>> pci_common_exit() to cleanup ARM specific datastructures.
> >>>>> Unmap the fixed PCI I/O mapping by calling the new
> >>>>> pci_iounmap_io() function in the new .teardown() callback.
> >>>>> 
> >>>>> Finally, no longer set the .suppress_bind_attrs field to
> >>>>> true to allow the driver to unbind from a device.
> >>>> 
> >>>>> +static int tegra_pcie_remove(struct platform_device *pdev)
> >>>>> +{ +	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
> >>>>> + struct tegra_pcie_bus *bus, *tmp; +	int err; + + 
> >>>>> pci_common_exit(&pcie->sys); + +
> >>>>> list_for_each_entry_safe(bus, tmp, &pcie->busses, list) { +
> >>>>> vunmap(bus->area->addr); + kfree(bus); +	} + +	if
> >>>>> (IS_ENABLED(CONFIG_PCI_MSI)) { +		err = 
> >>>>> tegra_pcie_disable_msi(pcie); +		if (err < 0) +			return
> >>>>> err; + }
> >>>> 
> >>>> Wouldn't it make sense to do that as early as possible in
> >>>> the function, to make sure that no MSI accidentally fires
> >>>> after some of the cleanup has already happened?
> >>> 
> >>> I don't think that's strictly necessary in this case. After
> >>> the call to pci_common_exit() there are no PCI devices left,
> >>> there's not even a bus left. All MSI users should have cleaned
> >>> up after themselves.
> >>> 
> >>> Given that I thought it more useful to mirror the setup done
> >>> in .probe() to make it clearer what's being undone (and
> >>> potentially what's missing).
> >> 
> >> That makes sense SW-wise, but what about mis-behaving HW that
> >> triggers an MSI even when it's been told not to? I assume that 
> >> tegra_pcie_disable_msi() unrequests the IRQ, hence solves that 
> >> problem, if done early enough.
> > 
> > To be honest, I'm not sure about the side-effects that this will
> > have. tegra_pcie_disable_msi() does quite a bit more than just
> > masking the interrupts. It also completely removes the IRQ domain
> > that provides the MSI interrupts. While I haven't tried it yet I
> > can imagine that it will cause crashes at a later point when
> > drivers want to disable MSI on a device and the IRQ domain having
> > vanished from underneath.
> 
> Surely by the time the PCIe controller device has been remove()d then
> all devices for PCIe "client" devices have also been removed.

The PCIe controller is the device being removed. Part of that removal
involves stopping and removing all PCI devices. That's done as part of
pci_common_exit().

But I was under the impression that you were arguing that the call to
tegra_pcie_disable_msi() should be the first call in .remove() in order
to prevent any spurious MSIs from occurring. That in turn would mean
calling tegra_pcie_disable_msi() before pci_common_exit(), and that
would lead to the problem that I described.

> But I guess the problem is if the controller is added back, yet the
> IRQ resources aren't re-parsed under the new IRQ domain? Still, that
> seems like an unrelated issue to exactly where the MSI IRQ domain gets
> cleaned up in the host controller's remove().

I don't think that should be a problem. Given that both the MSI IRQ
domain and the PCI devices will be setup from scratch I don't see how
any stale resources could mess things up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/6609a805/attachment.sig>
