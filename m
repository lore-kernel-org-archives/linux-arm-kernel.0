From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:42 -0600
Subject: [PATCH v3 30/30] ARM: orion5x: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-31-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

orion5x i/o handling must have been broken as it had no __io()
translation. It may actually work now.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-orion5x/common.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 0e28bae..9bab4cb 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -24,6 +24,7 @@
 #include <asm/timex.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 #include <mach/bridge-regs.h>
 #include <mach/hardware.h>
@@ -44,16 +45,6 @@ static struct map_desc orion5x_io_desc[] __initdata = {
 		.length		= ORION5X_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= ORION5X_PCIE_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(ORION5X_PCIE_IO_PHYS_BASE),
-		.length		= ORION5X_PCIE_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= ORION5X_PCI_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(ORION5X_PCI_IO_PHYS_BASE),
-		.length		= ORION5X_PCI_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= ORION5X_PCIE_WA_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_PCIE_WA_PHYS_BASE),
 		.length		= ORION5X_PCIE_WA_SIZE,
@@ -63,6 +54,11 @@ static struct map_desc orion5x_io_desc[] __initdata = {
 
 void __init orion5x_map_io(void)
 {
+	unsigned long pci_io_pfn[] = {
+		__phys_to_pfn(ORION5X_PCI_IO_PHYS_BASE),
+		__phys_to_pfn(ORION5X_PCIE_IO_PHYS_BASE),
+	};
+	pci_map_io_pfn(pci_io_pfn, ARRAY_SIZE(pci_io_pfn));
 	iotable_init(orion5x_io_desc, ARRAY_SIZE(orion5x_io_desc));
 }
 
-- 
1.7.5.4
