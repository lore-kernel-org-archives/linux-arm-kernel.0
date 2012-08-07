From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 7 Aug 2012 20:20:24 +0200
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <50201E1D.5060200@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
Message-ID: <20120807182024.GA11328@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> > This patch series adds support for device tree based probing of the PCIe
> > controller found on Tegra SoCs.
> 
> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed that
> PCIe doesn't work on TrimSlice when booting use device tree. I think I
> found the cause, and I can't see why the same problem doesn't affect
> this series. Perhaps you can enlighten me?
> 
> When booting TrimSlice (or Harmony) using board files, Tegra's PCIe is
> initialized using a subsys_initcall to tegra_pcie_init() directly (or
> for Harmony to harmony_pcie_init() which then calls tegra_pcie_init()).
> 
> The final thing tegra_pcie_init() does is call pci_common_init(). This
> calls pcibios_init_hw() which calls hw->scan() which calls
> pci_scan_root_bus() which adds a device object for each device on the
> PCIe bus. However, since this happens very early in the boot sequence, I
> believe the enumerated PCIe devices don't immediately get probed.
> Instead, control gets returned to pci_common_init() which I believe then
> calls pci_bus_assign_resources() which actually sets up the resources
> for those devices. Later, the PCIe devices actually get probed, and
> everything works.
> 
> However, when booting using device tree, with the code currently in
> v3.6-rc1, tegra_pcie_init() is called late in the boot sequence, and so
> in the sequence described above, as soon as pci_scan_root_bus() adds a
> device, it gets probed, before the device object's resources have been
> set up, which results in the following failure:
> 
> PCI: Device 0000:01:00.0 not available because of resource collisions
> 
> ... because of the following code in pcibios_enable_device():
> 
> > 	for (idx = 0; idx < 6; idx++) {
> > 		/* Only set up the requested stuff */
> > 		if (!(mask & (1 << idx)))
> > 			continue;
> > 
> > 		r = dev->resource + idx;
> > 		if (!r->start && r->end) {
> > 			printk(KERN_ERR "PCI: Device %s not available because"
> > 			       " of resource collisions\n", pci_name(dev));
> 
> Doesn't this same problem exist when instantiating the PCIe device
> itself from device tree as in your patch series? If not, can you explain
> why?

I think I've seen this before as well but hadn't had the time to
investigate further. The devices that failed to initialize were serial
ports I think. Perhaps the ordering here is the key. All the drivers
that I use for the PCI devices are loaded as modules, so they'll probe
the devices much later anyway. The serial driver is an exception here as
it is builtin.

> Now, the obvious solution in v3.6 would be to simply have
> tegra_pcie_init() be called at the same early stage in the boot process
> when booting using device tree as it is when booting using board files.
> This works for TrimSlice.
> 
> However, on Harmony, it doesn't work, because PCIe on Harmony depends on
> regulators, and the regulators are accessed using an I2C bus that is
> instantiated from DT, and the instantiation of the I2C bus happens
> fairly late in the boot process so can't be found early during the boot
> sequence. See harmony_regulator_init() for the failing code.
> 
> Does anyone have any good ideas (small, self-contained patches) for
> solving this in v3.6 in such a way that PCIe works on both TrimSlice and
> Harmony?

To me this looks like a problem in the probing code. Drivers' .probe()
shouldn't be called on devices that haven't had their resources assigned
yet. Perhaps nobody has ever seen this before because the ordering
always ensured that the PCI controller driver was loaded first.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120807/edcbb095/attachment.sig>
