From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 13 Aug 2012 19:40:03 +0200
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <50201E1D.5060200@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
Message-ID: <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
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
> 
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
> 
> Thanks.

I've looked into this a bit, and it seems like ARM is using an open-
coded version of the pci_enable_resources() function here, with the only
difference being the unconditional enabling of both I/O and memory-
mapped access for bridges. On Tegra there is already a PCI fixup to do
this, so pci_enable_resources() can be used as-is. I came up with the
attached patch but haven't been able to test it yet.

Thierry
-------------- next part --------------
>From ebd69ae0a3d076e574da74d963cb3834b71dc6ad Mon Sep 17 00:00:00 2001
From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 13 Aug 2012 18:49:28 +0200
Subject: [PATCH] ARM: PCI: refactor pcibios_enable_device()

The implementation is an open-coded version on pci_enable_resources()
with a special case to enable I/O and memory-mapped functionality on
bridges. This commit reuses the existing PCI core implementation of the
pci_enable_resources() function. This also means that bridges no longer
enable I/O and memory-mapped functionality unconditionally. Platforms
where this is really required can add a corresponding fixup.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/kernel/bios32.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 13fd97b..dfe25f7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -601,41 +601,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = dev->resource + idx;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	/*
-	 * Bridges (eg, cardbus bridges) need to be fully enabled
-	 */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-
-	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-- 
1.7.11.4

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120813/05e25d04/attachment.sig>
