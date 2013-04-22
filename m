From: vinayakm.list@gmail.com (vinayakm.list at gmail.com)
Date: Mon, 22 Apr 2013 20:53:00 +0530
Subject: [PATCH] mm: add an option to disable bounce
Message-ID: <1366644180-6140-1-git-send-email-vinayakm.list@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vinayak Menon <vinayakm.list@gmail.com>

There are times when HIGHMEM is enabled, but
we don't prefer CONFIG_BOUNCE to be enabled.
CONFIG_BOUNCE can reduce the block device
throughput, and this is not ideal for machines
where we don't gain much by enabling it. So
provide an option to deselect CONFIG_BOUNCE. The
observation was made while measuring eMMC throughput
using iozone on an ARM device with 1GB RAM.

Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>
---
 mm/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3bea74f..29f9736 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -263,8 +263,14 @@ config ZONE_DMA_FLAG
 	default "1"
 
 config BOUNCE
+	bool "Enable bounce buffers"
 	def_bool y
 	depends on BLOCK && MMU && (ZONE_DMA || HIGHMEM)
+	help
+	  Enable bounce buffers for devices that cannot access
+	  the full range of memory available to the CPU. Enabled
+	  by default when ZONE_DMA or HIGMEM is selected, but you
+	  may say n to override this.
 
 # On the 'tile' arch, USB OHCI needs the bounce pool since tilegx will often
 # have more than 4GB of memory, but we don't currently use the IOTLB to present
-- 
1.7.10.4
