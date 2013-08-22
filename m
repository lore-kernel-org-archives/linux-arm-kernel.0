From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 22 Aug 2013 17:47:49 +0100
Subject: [PATCH 2/3] ARM: PCI: versatile: Fix PCI I/O
In-Reply-To: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <1377190070-7305-3-git-send-email-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The versatile PCI controller code was confused between the
PCI I/O window (at 0x43000000) and the first PCI memory
window (at 0x44000000). Pass the correct base address to
pci_remap_io() so that PCI I/O accesses work.

Since the first PCI memory window isn't used at all (it's
an odd size), rename the associated variables and labels
so that it's clear that it isn't related to the I/O window.

This has been tested and confirmed to fix PCI I/O accesses
both on physical PB926+PCI backplane hardware and on QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 arch/arm/mach-versatile/include/mach/platform.h |    2 ++
 arch/arm/mach-versatile/pci.c                   |   16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
index ec08740..6f938cc 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/include/mach/platform.h
@@ -231,12 +231,14 @@
 /* PCI space */
 #define VERSATILE_PCI_BASE             0x41000000	/* PCI Interface */
 #define VERSATILE_PCI_CFG_BASE	       0x42000000
+#define VERSATILE_PCI_IO_BASE          0x43000000
 #define VERSATILE_PCI_MEM_BASE0        0x44000000
 #define VERSATILE_PCI_MEM_BASE1        0x50000000
 #define VERSATILE_PCI_MEM_BASE2        0x60000000
 /* Sizes of above maps */
 #define VERSATILE_PCI_BASE_SIZE	       0x01000000
 #define VERSATILE_PCI_CFG_BASE_SIZE    0x02000000
+#define VERSATILE_PCI_IO_BASE_SIZE     0x01000000
 #define VERSATILE_PCI_MEM_BASE0_SIZE   0x0c000000	/* 32Mb */
 #define VERSATILE_PCI_MEM_BASE1_SIZE   0x10000000	/* 256Mb */
 #define VERSATILE_PCI_MEM_BASE2_SIZE   0x10000000	/* 256Mb */
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 234740d..1e48878 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -170,8 +170,8 @@ static struct pci_ops pci_versatile_ops = {
 	.write	= versatile_write_config,
 };
 
-static struct resource io_mem = {
-	.name	= "PCI I/O space",
+static struct resource unused_mem = {
+	.name	= "PCI unused",
 	.start	= VERSATILE_PCI_MEM_BASE0,
 	.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
 	.flags	= IORESOURCE_MEM,
@@ -195,9 +195,9 @@ static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 {
 	int ret = 0;
 
-	ret = request_resource(&iomem_resource, &io_mem);
+	ret = request_resource(&iomem_resource, &unused_mem);
 	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate I/O "
+		printk(KERN_ERR "PCI: unable to allocate unused "
 		       "memory region (%d)\n", ret);
 		goto out;
 	}
@@ -205,7 +205,7 @@ static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 	if (ret) {
 		printk(KERN_ERR "PCI: unable to allocate non-prefetchable "
 		       "memory region (%d)\n", ret);
-		goto release_io_mem;
+		goto release_unused_mem;
 	}
 	ret = request_resource(&iomem_resource, &pre_mem);
 	if (ret) {
@@ -225,8 +225,8 @@ static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 
  release_non_mem:
 	release_resource(&non_mem);
- release_io_mem:
-	release_resource(&io_mem);
+ release_unused_mem:
+	release_resource(&unused_mem);
  out:
 	return ret;
 }
@@ -246,7 +246,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 		goto out;
 	}
 
-	ret = pci_ioremap_io(0, VERSATILE_PCI_MEM_BASE0);
+	ret = pci_ioremap_io(0, VERSATILE_PCI_IO_BASE);
 	if (ret)
 		goto out;
 
-- 
1.7.9.5
