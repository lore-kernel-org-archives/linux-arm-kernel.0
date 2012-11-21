From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 11:25:28 -0700
Subject: [PATCH] ARM: Kirkwood: Support basic hotplug for PCI-E
Message-ID: <20121121182528.GA12715@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unconditionally register the PCI-E bus, even if the link is currently
down. When the link is brought up the bus can be scanned through
/sys/bus/pci/rescan or otherwise. Since the HW has no interrupt for
link up, userspace will have to take care of the timing.

An earlier version of this was contingent on CONFIG_HOTPLUG, but
that is being removed from the kernel.

This also fixes printing the link up/down message to be displayed
on one line (structured logging broke this?)

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mach-kirkwood/pcie.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

All PCI-E ports are required to support hot plug at the link training
level. Our systems support it electrically, and userspace sequences
everything to work properly. But the PCI-E root port needs to be
registered with the kernel to initiate a rescan via sysfs when things
are ready.

diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 59c97fe..80fd4f2 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -244,13 +244,9 @@ static struct hw_pci kirkwood_pci __initdata = {
 
 static void __init add_pcie_port(int index, void __iomem *base)
 {
-	printk(KERN_INFO "Kirkwood PCIe port %d: ", index);
-
-	if (orion_pcie_link_up(base)) {
-		printk(KERN_INFO "link up\n");
-		pcie_port_map[num_pcie_ports++] = index;
-	} else
-		printk(KERN_INFO "link down, ignoring\n");
+	pcie_port_map[num_pcie_ports++] = index;
+	pr_info("Kirkwood PCIe port %d: link %s\n", index,
+		orion_pcie_link_up(base) ? "up" : "down");
 }
 
 void __init kirkwood_pcie_init(unsigned int portmask)
-- 
1.7.5.4
