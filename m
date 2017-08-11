From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Aug 2017 12:56:36 -0400
Subject: [PATCH V10 3/3] PCI: display not responding message while device is
 unreachable
In-Reply-To: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1502470596-4112-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a print statement into pci_bus_wait_crs() so that user observes
the progress of device polling instead of silently waiting for timeout
to be reached.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1cb7bd..2f4cf7d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1839,11 +1839,17 @@ bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int crs_timeout)
 		delay *= 2;
 		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 			return false;
+
+		if (delay >= 1000)
+			pr_info("pci %04x:%02x:%02x.%d: not responding since %dms still polling\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay);
+
 		/* Card hasn't responded in 60 seconds?  Must be stuck. */
 		if (delay > crs_timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
+			pr_warn("pci %04x:%02x:%02x.%d: not responding %dms timeout reached\n",
 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn));
+			       PCI_FUNC(devfn), crs_timeout);
 			return false;
 		}
 	} while ((*l & 0xffff) == 0x0001);
-- 
1.9.1
