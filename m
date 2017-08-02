From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed,  2 Aug 2017 15:15:17 -0400
Subject: [PATCH V7 3/3] PCI: display not responding message while device is
 unreachable
In-Reply-To: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
References: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1501701317-32249-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a print statement into pci_bus_read_dev_vendor_id() so that
user observes the progress of device polling instead of silently
waiting for timeout to be reached.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c31310d..6e4a846 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1851,9 +1851,15 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 		delay *= 2;
 		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 			return false;
+
+		if (delay > 1000)
+			pr_info("pci %04x:%02x:%02x.%d: not responding\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn));
+
 		/* Card hasn't responded in 60 seconds?  Must be stuck. */
 		if (delay > crs_timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
+			pr_warn("pci %04x:%02x:%02x.%d: not responding timeout reached\n",
 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			       PCI_FUNC(devfn));
 			return false;
-- 
1.9.1
