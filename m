From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 00:19:06 -0700
Subject: [PATCH] ARM: Kirkwood: Update PCI-E fixup
Message-ID: <20121121071906.GF19837@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- The code relies on rc_pci_fixup being called, which only happens
  when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
  this causes a booting failure with a non-obvious cause.
- Update rc_pci_fixup to set the class properly, copying the
  more modern style from other places
- Correct the rc_pci_fixup comment

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-kirkwood/pcie.c |    9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Another cleanup.. It took a fair while to figure out that things
were not working properly because PCI_QUIRKS was not set :|

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..9759fec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -547,6 +547,7 @@ config ARCH_KIRKWOOD
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
 	select PCI
+	select PCI_QUIRKS
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index d5aedf6..59c97fe 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -207,14 +207,17 @@ static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
+/* The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
+   is operating as a root complex this needs to be switched to
+   PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
+   the device. Decoding setup is handled by the orion code. */
 static void __devinit rc_pci_fixup(struct pci_dev *dev)
 {
-	/*
-	 * Prevent enumeration of root complex.
-	 */
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
 		int i;
 
+		dev->class &= 0xff;
+		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
-- 
1.7.4.1
