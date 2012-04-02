From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon,  2 Apr 2012 19:48:25 -0400
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
Message-ID: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 9f786d033d025ab7d2c4d1b959aa81d935eb9e19

    "arm/PCI: get rid of device resource fixups"

causes this failure on the versatile:

arch/arm/mach-versatile/pci.c: In function 'pci_versatile_setup_resources':
arch/arm/mach-versatile/pci.c:221: error: 'sys' undeclared (first use in this function)

because the versatile wasn't passing in the full struct pci_sys_data
but only the resource sub-field.  Change it to pass in the full
struct so that sys will be in scope.

Reported-by: Bruce Ashfield <bruce.ashfield@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index a6e23f4..d2268be 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -190,7 +190,7 @@ static struct resource pre_mem = {
 	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
 };
 
-static int __init pci_versatile_setup_resources(struct list_head *resources)
+static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 {
 	int ret = 0;
 
@@ -218,9 +218,9 @@ static int __init pci_versatile_setup_resources(struct list_head *resources)
 	 * the mem resource for this bus
 	 * the prefetch mem resource for this bus
 	 */
-	pci_add_resource_offset(resources, &io_mem, sys->io_offset);
-	pci_add_resource_offset(resources, &non_mem, sys->mem_offset);
-	pci_add_resource_offset(resources, &pre_mem, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &io_mem, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);
 
 	goto out;
 
@@ -249,7 +249,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 	if (nr == 0) {
 		sys->mem_offset = 0;
-		ret = pci_versatile_setup_resources(&sys->resources);
+		ret = pci_versatile_setup_resources(sys);
 		if (ret < 0) {
 			printk("pci_versatile_setup: resources... oops?\n");
 			goto out;
-- 
1.7.9.1
