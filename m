From: yinghai@kernel.org (Yinghai Lu)
Date: Sun, 27 Jan 2013 11:23:29 -0800
Subject: [PATCH v3 02/22] PCI: Add dummy bus_type for pci_host_bridge
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Message-ID: <1359314629-18651-3-git-send-email-yinghai@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to use it for looping registered host_bridge, and kill
pci_root_buses list.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac at vger.kernel.org
Cc: x86 at kernel.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux at vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64 at vger.kernel.org
Cc: linux-altix at sgi.com
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha at vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux at itee.uq.edu.au
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list at redhat.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev at lists.ozlabs.org
---
 drivers/pci/pci-driver.c |   11 ++++++++++-
 drivers/pci/probe.c      |    1 +
 include/linux/pci.h      |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index acdcc3c..9fb004b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1278,11 +1278,20 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 };
 
+struct bus_type pci_host_bridge_bus_type = {
+	.name           = "pci_host_bridge",
+};
+
+static int __init pci_host_bridge_driver_init(void)
+{
+	return bus_register(&pci_host_bridge_bus_type);
+}
+postcore_initcall(pci_host_bridge_driver_init);
+
 static int __init pci_driver_init(void)
 {
 	return bus_register(&pci_bus_type);
 }
-
 postcore_initcall(pci_driver_init);
 
 EXPORT_SYMBOL_GPL(pci_add_dynid);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef50154..04ecf0d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1692,6 +1692,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 
 	bridge->dev.parent = parent;
+	bridge->dev.bus = &pci_host_bridge_bus_type;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 056d3d6..9da06ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -669,6 +669,7 @@ enum pcie_bus_config_types {
 
 extern enum pcie_bus_config_types pcie_bus_config;
 
+extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
@@ -740,6 +741,7 @@ void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
+#define dev_is_pci_host_bridge(d) ((d)->bus == &pci_host_bridge_bus_type)
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
-- 
1.7.10.4
