From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 12 Dec 2010 22:52:36 +0100
Subject: Fix IXP4xx build
Message-ID: <m3ei9m7j6j.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Is it ok if I send the following to Linus, or would you like to do it
yourself? Leaving IXP4xx build broken for 2.6.37 isn't the best idea.

From: Imre Kaloz <kaloz@openwrt.org>

arm: export dma_set_coherent_mask

While a regression was fixed with commit 710224fa2750cf (arm: fix
"arm: fix pci_set_consistent_dma_mask for dmabounce devices"), a
new one was introduced as dma_set_coherent_mask wasn't exported
for modules. This patch takes care for this issue.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -352,3 +352,4 @@ struct pci_bus * __init it8152_pci_scan_bus(int nr, struct pci_sys_data *sys)
 	return pci_scan_bus(nr, &it8152_ops, sys);
 }
 
+EXPORT_SYMBOL(dma_set_coherent_mask);
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -483,4 +483,4 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
-
+EXPORT_SYMBOL(dma_set_coherent_mask);

-- 
Krzysztof Halasa
