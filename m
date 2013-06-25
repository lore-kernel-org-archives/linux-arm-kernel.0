From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 01:06:00 +0200
Subject: [PATCH 3/3] ARM: integrator: pciv3: do not remap IO so early
Message-ID: <1372201560-26015-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of remapping the IO memory very early with
pci_map_io_early(), use pci_ioremap_io() when setting
up resources as most PCI bridges do. Also request this
resource properly.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index bef1005..029d670 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -538,6 +538,13 @@ static int __init pci_v3_setup_resources(struct pci_sys_data *sys)
 		       "memory region\n");
 		return -EBUSY;
 	}
+	if (request_resource(&iomem_resource, &io_mem)) {
+		release_resource(&io_mem);
+		printk(KERN_ERR "PCI: unable to allocate I/O "
+		       "memory region\n");
+		return -EBUSY;
+	}
+	pci_ioremap_io(0, io_mem.start);
 
 	/*
 	 * the mem resource for this bus
@@ -1039,6 +1046,5 @@ int __init pci_v3_early_init(void)
 {
 	iotable_init(pci_v3_io_desc, ARRAY_SIZE(pci_v3_io_desc));
 	vga_base = (unsigned long)PCI_MEMORY_VADDR;
-	pci_map_io_early(__phys_to_pfn(PHYS_PCI_IO_BASE));
 	return 0;
 }
-- 
1.8.1.4
