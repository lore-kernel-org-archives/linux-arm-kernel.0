From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 20 Sep 2012 09:43:44 +0200
Subject: [PATCH v3 1/2] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1348127025-29461-1-git-send-email-thierry.reding@avionic-design.de>
References: <1348127025-29461-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1348127025-29461-2-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using deferred driver probing, PCI host controller drivers may
actually require this function after the init stage.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- remove __init annotation from pcibios_init_resources()

Changes in v2:
- remove __devinit annotation from pcibios_swizzle
- remove __init annotations altogether

 arch/arm/kernel/bios32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index b244696..2c80f36 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
  * PCI standard swizzle is implemented on plug-in cards and Cardbus based
  * PCI extenders, so it can not be ignored.
  */
-static u8 __devinit pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	int slot, oldpin = *pin;
@@ -424,7 +424,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static int __init pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 {
 	int ret;
 	struct pci_host_bridge_window *window;
@@ -456,7 +456,7 @@ static int __init pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 	return 0;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -504,7 +504,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
-- 
1.7.12
