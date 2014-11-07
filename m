From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri,  7 Nov 2014 14:27:54 +0100
Subject: [RFC PATCH 2/4] x86, acpi,
 pci: Isolate new PCI mmconfig entry insertion.
In-Reply-To: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1415366876-30811-3-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add special pci_mmcfg_insert_lock mutex since pci_mmcfg_lock was moved
to common file. No functional changes.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/pci/mmconfig-shared.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 94c3d38..d1e45e7 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -28,6 +28,7 @@
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
+static DEFINE_MUTEX(pci_mmcfg_insert_lock);
 
 static const char *__init pci_mmcfg_e7520(void)
 {
@@ -566,7 +567,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	if (start > end)
 		return -EINVAL;
 
-	mutex_lock(&pci_mmcfg_lock);
+	mutex_lock(&pci_mmcfg_insert_lock);
 	cfg = pci_mmconfig_lookup(seg, start);
 	if (cfg) {
 		if (cfg->end_bus < end)
@@ -575,12 +576,12 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 				 "domain %04x [bus %02x-%02x] "
 				 "only partially covers this bridge\n",
 				  cfg->segment, cfg->start_bus, cfg->end_bus);
-		mutex_unlock(&pci_mmcfg_lock);
+		mutex_unlock(&pci_mmcfg_insert_lock);
 		return -EEXIST;
 	}
 
 	if (!addr) {
-		mutex_unlock(&pci_mmcfg_lock);
+		mutex_unlock(&pci_mmcfg_insert_lock);
 		return -EINVAL;
 	}
 
@@ -621,7 +622,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		kfree(cfg);
 	}
 
-	mutex_unlock(&pci_mmcfg_lock);
+	mutex_unlock(&pci_mmcfg_insert_lock);
 
 	return rc;
 }
-- 
1.9.1
