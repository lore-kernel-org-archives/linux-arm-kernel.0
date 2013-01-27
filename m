From: yinghai@kernel.org (Yinghai Lu)
Date: Sun, 27 Jan 2013 11:23:49 -0800
Subject: [PATCH v3 22/22] PCI: Kill pci_root_buses
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Message-ID: <1359314629-18651-23-git-send-email-yinghai@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No user now, remove it.

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
 drivers/pci/probe.c |    8 --------
 include/linux/pci.h |    3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04ecf0d..8420b9d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -23,10 +23,6 @@ struct resource busn_resource = {
 	.flags	= IORESOURCE_BUS,
 };
 
-/* Ugh.  Need to stop exporting this to modules. */
-LIST_HEAD(pci_root_buses);
-EXPORT_SYMBOL(pci_root_buses);
-
 static LIST_HEAD(pci_domain_busn_res_list);
 
 struct pci_domain_busn_res {
@@ -1746,10 +1742,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	return b;
 
 class_dev_reg_err:
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bb07db2..b42721b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -674,9 +674,6 @@ extern enum pcie_bus_config_types pcie_bus_config;
 extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
-/* Do NOT directly access these two variables, unless you are arch specific pci
- * code, or pci core code. */
-extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 /* Some device drivers need know if pci is initiated */
 extern int no_pci_devices(void);
 
-- 
1.7.10.4
