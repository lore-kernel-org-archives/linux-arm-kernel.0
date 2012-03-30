From: oskar.andero@gmail.com (Oskar Andero)
Date: Sat, 31 Mar 2012 01:37:37 +0200
Subject: [PATCH] ARM: versatile: fix broken build in pci.c
Message-ID: <1333150657-6534-1-git-send-email-oskar.andero@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An undefined reference to sys was introduced by 9f786d03.

Signed-off-by: Oskar Andero <oskar.andero@gmail.com>
---
 arch/arm/mach-versatile/pci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index a6e23f4..e4447dd 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -190,8 +190,9 @@ static struct resource pre_mem = {
 	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
 };
 
-static int __init pci_versatile_setup_resources(struct list_head *resources)
+static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 {
+	struct list_head *resources = &sys->resources;
 	int ret = 0;
 
 	ret = request_resource(&iomem_resource, &io_mem);
@@ -249,7 +250,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 	if (nr == 0) {
 		sys->mem_offset = 0;
-		ret = pci_versatile_setup_resources(&sys->resources);
+		ret = pci_versatile_setup_resources(sys);
 		if (ret < 0) {
 			printk("pci_versatile_setup: resources... oops?\n");
 			goto out;
-- 
1.7.3.4
