From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Mar 2012 19:33:33 -0300
Subject: [PATCH] ARM: mach-versatile: Fix PCI build error
Message-ID: <1331073213-16502-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error that happened on a "make randconfig":

arch/arm/mach-versatile/pci.c: In function 'pci_versatile_setup_resources':
arch/arm/mach-versatile/pci.c:222: error: 'sys' undeclared (first use in this function)

since commit 9f786d033d (arm/PCI: get rid of device resource fixups)
pci_add_resource_offset() has an extra parameter.

Pass the sys struct parameter to pci_versatile_setup_resources() in order to fix
the build.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-versatile/pci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 51733b0..4f41cb8 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -191,7 +191,8 @@ static struct resource pre_mem = {
 	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
 };
 
-static int __init pci_versatile_setup_resources(struct list_head *resources)
+static int __init pci_versatile_setup_resources(struct list_head *resources,
+						struct pci_sys_data *sys)
 {
 	int ret = 0;
 
@@ -250,7 +251,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 	if (nr == 0) {
 		sys->mem_offset = 0;
-		ret = pci_versatile_setup_resources(&sys->resources);
+		ret = pci_versatile_setup_resources(&sys->resources, sys);
 		if (ret < 0) {
 			printk("pci_versatile_setup: resources... oops?\n");
 			goto out;
-- 
1.7.1
