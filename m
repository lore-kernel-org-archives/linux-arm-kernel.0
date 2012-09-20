From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 20 Sep 2012 09:21:49 +0200
Subject: [PATCH v2 1/2] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1348125710-28726-1-git-send-email-thierry.reding@avionic-design.de>
References: <1348125710-28726-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1348125710-28726-2-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using deferred driver probing, PCI host controller drivers may
actually require this function after the init stage.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- remove __devinit annotation from pcibios_swizzle
- remove __init annotations altogether

 arch/arm/kernel/bios32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2b2f25e..6f1d75f 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -388,7 +388,7 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
  * PCI standard swizzle is implemented on plug-in cards and Cardbus based
  * PCI extenders, so it can not be ignored.
  */
-static u8 __devinit pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	int slot, oldpin = *pin;
@@ -423,7 +423,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -472,7 +472,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
-- 
1.7.12
