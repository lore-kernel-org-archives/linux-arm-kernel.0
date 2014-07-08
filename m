From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  8 Jul 2014 10:37:37 -0300
Subject: [PATCH for v3.16] ARM: mvebu: Fix coherency bus notifiers by using
 separate notifiers
Message-ID: <1404826657-6977-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the coherency fabric support registers two bus notifiers;
one for platform, one for pci bus types, with the same notifier block.
However, this is illegal and can cause serious issues: the notifier
block is also a link in the notifier list and cannot be inserted twice.

This commit fixes this by using different notifier blocks (with the same
notifier callback) to set the platform and pci bus types notifiers.

Fixes: b0063aad5dd8 ("ARM: mvebu: use hardware I/O coherency also for PCI devices")
Reported-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 477202f..2bdc323 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -292,6 +292,10 @@ static struct notifier_block mvebu_hwcc_nb = {
 	.notifier_call = mvebu_hwcc_notifier,
 };
 
+static struct notifier_block mvebu_hwcc_pci_nb = {
+	.notifier_call = mvebu_hwcc_notifier,
+};
+
 static void __init armada_370_coherency_init(struct device_node *np)
 {
 	struct resource res;
@@ -427,7 +431,7 @@ static int __init coherency_pci_init(void)
 {
 	if (coherency_available())
 		bus_register_notifier(&pci_bus_type,
-				       &mvebu_hwcc_nb);
+				       &mvebu_hwcc_pci_nb);
 	return 0;
 }
 
-- 
1.9.1
