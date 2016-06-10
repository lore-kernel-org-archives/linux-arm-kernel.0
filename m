From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 10 Jun 2016 21:55:15 +0200
Subject: [PATCH V9 07/11] PCI: Factor DT specific pci_bus_find_domain_nr()
 code out
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
Message-ID: <1465588519-11334-8-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_bus_find_domain_nr() retrieves the host bridge domain number in a DT
specific way. Factor our pci_bus_find_domain_nr() in a separate DT
function (ie of_pci_bus_find_domain_nr()) so that DT code is self
contained, paving the way for retrieving domain number in
pci_bus_find_domain_nr() with additional firmware methods (ie ACPI).

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9a7833..327828d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4941,7 +4941,7 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
+static int of_pci_bus_find_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = -1;
@@ -4987,6 +4987,11 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 
 	return domain;
 }
+
+int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	return of_pci_bus_find_domain_nr(parent);
+}
 #endif
 #endif
 
-- 
1.9.1
