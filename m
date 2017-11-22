From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:31:05 -0500
Subject: [PATCH 20/30] PCI/syscall: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-21-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 83efa00..e725f99 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -28,7 +28,7 @@
 		return -EPERM;
 
 	err = -ENODEV;
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		goto error;
 
@@ -96,7 +96,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	dev = pci_get_bus_and_slot(bus, dfn);
+	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 	if (!dev)
 		return -ENODEV;
 
-- 
1.9.1
