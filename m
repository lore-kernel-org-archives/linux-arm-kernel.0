From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 24 Mar 2015 11:34:24 +0800
Subject: [PATCH v8 30/30] PCI: Clean up CONFIG_PCI_DOMAINS_GENERIC
In-Reply-To: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1427168064-8657-31-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we could clean up CONFIG_PCI_DOMAINS_GENERIC.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/Kconfig          |    3 ---
 arch/arm64/Kconfig        |    3 ---
 drivers/pci/host-bridge.c |   11 ++++++-----
 drivers/pci/pci.c         |    2 --
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..b5dab6c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1283,9 +1283,6 @@ config PCI_DOMAINS
 	bool
 	depends on PCI
 
-config PCI_DOMAINS_GENERIC
-	def_bool PCI_DOMAINS
-
 config PCI_NANOENGINE
 	bool "BSE nanoEngine PCI support"
 	depends on SA1100_NANOENGINE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..4b1cc27 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -242,9 +242,6 @@ config PCI
 config PCI_DOMAINS
 	def_bool PCI
 
-config PCI_DOMAINS_GENERIC
-	def_bool PCI
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index c78f4d0..18a0f6c 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -4,6 +4,8 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
+#include <linux/of.h>
 #include <linux/module.h>
 
 #include "pci.h"
@@ -82,12 +84,13 @@ struct pci_host_bridge *pci_create_host_bridge(
 	resource_list_for_each_entry_safe(window, n, resources)
 		list_move_tail(&window->node, &host->windows);
 	/*
-	 * If support CONFIG_PCI_DOMAINS_GENERIC, use
+	 * If domain == -1, we need to use
 	 * pci_host_assign_domain_nr() to update domain
 	 * number.
 	 */
 	host->domain = domain;
-	pci_host_assign_domain_nr(host);
+	if (host->domain == -1)
+		pci_host_assign_domain_nr(host);
 	mutex_lock(&pci_host_mutex);
 	list_for_each_entry(tmp, &pci_host_bridge_list, list) {
 		if (tmp->domain != host->domain
@@ -169,7 +172,6 @@ int pci_get_new_domain_nr(void)
 	return atomic_inc_return(&__domain_nr);
 }
 
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
 static int pci_assign_domain_nr(struct device *dev)
 {
 	static int use_dt_domains = -1;
@@ -215,11 +217,10 @@ static int pci_assign_domain_nr(struct device *dev)
 	return domain;
 }
 #endif
-#endif
 
 void pci_host_assign_domain_nr(struct pci_host_bridge *host)
 {
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
+#ifdef CONFIG_PCI_DOMAINS
 	host->domain = pci_assign_domain_nr(host->dev.parent);
 #endif
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 044801c..5b18429 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -10,8 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/of.h>
-#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-- 
1.7.1
