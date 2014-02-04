From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 16:53:02 +0000
Subject: [PATCH 1/3] ARM: bios32: use pci_enable_resource to enable PCI
 resources
In-Reply-To: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391532784-1953-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves bios32 over to using the generic code for enabling PCI
resources. All that's left to take care of is the case of PCI bridges,
which need to be enabled for both IO and MEMORY, regardless of the
resource types.

A side-effect of this change is that we no longer explicitly enable
devices when running in PCI_PROBE_ONLY mode. This stays closer to the
meaning of the option and prevents us from trying to enable devices
without any assigned resources (the core code refuses to enable
resources without parents).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/bios32.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88ae65b..9f3c76638689 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -608,40 +608,25 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
+	int err;
+	u16 cmd;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
 
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
+	err = pci_enable_resources(dev, mask);
+	if (err)
+		return err;
 
 	/*
 	 * Bridges (eg, cardbus bridges) need to be fully enabled
 	 */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-
-	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+
 	return 0;
 }
 
-- 
1.8.2.2
