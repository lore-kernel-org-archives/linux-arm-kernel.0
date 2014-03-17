From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 14:42:35 +0100
Subject: [PATCH RESEND v2 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <20140317144016.0508cc4d@marrow.netinsight.se>
References: <20140317144016.0508cc4d@marrow.netinsight.se>
Message-ID: <20140317144235.546d2e19@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-PCI devices can use the entire 32-bit range, PCI dittos are
limited to the first 64MiB.

Also actually setup coherent_dma_mask.

The patch has been verified on a board with 128MiB memory, one
ipx4xx_eth device and a e100 PCI device.

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
ChangeLog:

* v2: Move EXPORT_SYMBOL together with dma_set_coherent_mask (Anrd Bergmann)

 arch/arm/mach-ixp4xx/common-pci.c |    9 ---------
 arch/arm/mach-ixp4xx/common.c     |   12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 200970d..055d816 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -481,14 +481,5 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (mask >= SZ_64M - 1)
-		return 0;
-
-	return -EIO;
-}
-
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
-EXPORT_SYMBOL(dma_set_coherent_mask);
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 6d68aed..df82a2b 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/cpu.h>
 #include <linux/sched_clock.h>
+#include <linux/pci.h>
 
 #include <mach/udc.h>
 #include <mach/hardware.h>
@@ -578,6 +579,17 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (dev_is_pci(dev) && mask >= SZ_64M)
+		return -EIO;
+
+	dev->coherent_dma_mask = mask;
+
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
 /*
  * In the case of using indirect PCI, we simply return the actual PCI
-- 
1.7.9.6
