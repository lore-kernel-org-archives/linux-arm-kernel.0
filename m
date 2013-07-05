From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:17 -0300
Subject: [PATCH v6 06/21] ARM: dove: Move to ID based window creation
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

With the introduction of the ID based MBus API, it's better
to switch to use it instead of the current name based scheme.

This will allow to deprecate the name based API, once every
user is removed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c | 68 ++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 00247c7..bc22056 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -27,6 +27,22 @@
 #include <plat/time.h>
 #include "common.h"
 
+/* These can go away once Dove uses the mvebu-mbus DT binding */
+#define DOVE_MBUS_PCIE0_MEM_TARGET    0x4
+#define DOVE_MBUS_PCIE0_MEM_ATTR      0xe8
+#define DOVE_MBUS_PCIE0_IO_TARGET     0x4
+#define DOVE_MBUS_PCIE0_IO_ATTR       0xe0
+#define DOVE_MBUS_PCIE1_MEM_TARGET    0x8
+#define DOVE_MBUS_PCIE1_MEM_ATTR      0xe8
+#define DOVE_MBUS_PCIE1_IO_TARGET     0x8
+#define DOVE_MBUS_PCIE1_IO_ATTR       0xe0
+#define DOVE_MBUS_CESA_TARGET         0x3
+#define DOVE_MBUS_CESA_ATTR           0x1
+#define DOVE_MBUS_BOOTROM_TARGET      0x1
+#define DOVE_MBUS_BOOTROM_ATTR        0xfd
+#define DOVE_MBUS_SCRATCHPAD_TARGET   0xd
+#define DOVE_MBUS_SCRATCHPAD_ATTR     0x0
+
 /*****************************************************************************
  * I/O Address Mapping
  ****************************************************************************/
@@ -332,34 +348,40 @@ void __init dove_setup_cpu_wins(void)
 {
 	/*
 	 * The PCIe windows will no longer be statically allocated
-	 * here once Dove is migrated to the pci-mvebu driver.
+	 * here once Dove is migrated to the pci-mvebu driver. The
+	 * non-PCIe windows will no longer be created here once Dove
+	 * fully moves to DT.
 	 */
-	mvebu_mbus_add_window_remap_flags("pcie0.0",
+	mvebu_mbus_add_window_remap_by_id(DOVE_MBUS_PCIE0_IO_TARGET,
+					  DOVE_MBUS_PCIE0_IO_ATTR,
 					  DOVE_PCIE0_IO_PHYS_BASE,
 					  DOVE_PCIE0_IO_SIZE,
-					  DOVE_PCIE0_IO_BUS_BASE,
-					  MVEBU_MBUS_PCI_IO);
-	mvebu_mbus_add_window_remap_flags("pcie1.0",
+					  DOVE_PCIE0_IO_BUS_BASE);
+	mvebu_mbus_add_window_remap_by_id(DOVE_MBUS_PCIE1_IO_TARGET,
+					  DOVE_MBUS_PCIE1_IO_ATTR,
 					  DOVE_PCIE1_IO_PHYS_BASE,
 					  DOVE_PCIE1_IO_SIZE,
-					  DOVE_PCIE1_IO_BUS_BASE,
-					  MVEBU_MBUS_PCI_IO);
-	mvebu_mbus_add_window_remap_flags("pcie0.0",
-					  DOVE_PCIE0_MEM_PHYS_BASE,
-					  DOVE_PCIE0_MEM_SIZE,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
-	mvebu_mbus_add_window_remap_flags("pcie1.0",
-					  DOVE_PCIE1_MEM_PHYS_BASE,
-					  DOVE_PCIE1_MEM_SIZE,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
-	mvebu_mbus_add_window("cesa", DOVE_CESA_PHYS_BASE,
-			      DOVE_CESA_SIZE);
-	mvebu_mbus_add_window("bootrom", DOVE_BOOTROM_PHYS_BASE,
-			      DOVE_BOOTROM_SIZE);
-	mvebu_mbus_add_window("scratchpad", DOVE_SCRATCHPAD_PHYS_BASE,
-			      DOVE_SCRATCHPAD_SIZE);
+					  DOVE_PCIE1_IO_BUS_BASE);
+	mvebu_mbus_add_window_by_id(DOVE_MBUS_PCIE0_MEM_TARGET,
+				    DOVE_MBUS_PCIE0_MEM_ATTR,
+				    DOVE_PCIE0_MEM_PHYS_BASE,
+				    DOVE_PCIE0_MEM_SIZE);
+	mvebu_mbus_add_window_by_id(DOVE_MBUS_PCIE1_MEM_TARGET,
+				    DOVE_MBUS_PCIE1_MEM_ATTR,
+				    DOVE_PCIE1_MEM_PHYS_BASE,
+				    DOVE_PCIE1_MEM_SIZE);
+	mvebu_mbus_add_window_by_id(DOVE_MBUS_CESA_TARGET,
+				    DOVE_MBUS_CESA_ATTR,
+				    DOVE_CESA_PHYS_BASE,
+				    DOVE_CESA_SIZE);
+	mvebu_mbus_add_window_by_id(DOVE_MBUS_BOOTROM_TARGET,
+				    DOVE_MBUS_BOOTROM_ATTR,
+				    DOVE_BOOTROM_PHYS_BASE,
+				    DOVE_BOOTROM_SIZE);
+	mvebu_mbus_add_window_by_id(DOVE_MBUS_SCRATCHPAD_TARGET,
+				    DOVE_MBUS_SCRATCHPAD_ATTR,
+				    DOVE_SCRATCHPAD_PHYS_BASE,
+				    DOVE_SCRATCHPAD_SIZE);
 }
 
 void __init dove_init(void)
-- 
1.8.1.5
