From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 10:56:59 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask common,
 correct implementation
In-Reply-To: <20140317105448.14bcb617@marrow.netinsight.se>
References: <20140317105448.14bcb617@marrow.netinsight.se>
Message-ID: <20140317105659.449505d8@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-PCI devices can use the entire 32-bit range, PCI dittos are
limited to the first 64MiB.

Also actually setup coherent_dma_mask.

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
 arch/arm/mach-ixp4xx/common-pci.c |    8 --------
 arch/arm/mach-ixp4xx/common.c     |   11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 200970d..b02c764 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -481,14 +481,6 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
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
 EXPORT_SYMBOL(dma_set_coherent_mask);
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 6d68aed..b221c78 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/cpu.h>
 #include <linux/sched_clock.h>
+#include <linux/pci.h>
 
 #include <mach/udc.h>
 #include <mach/hardware.h>
@@ -578,6 +579,16 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
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
+
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
 /*
  * In the case of using indirect PCI, we simply return the actual PCI
-- 
1.7.9.6
