From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 15:41:32 -0700
Subject: [PATCH 1/3] PCI: Allow quirks to override SRIOV BARs.
In-Reply-To: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442529694-1792-2-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Devices with fixed BARs can install BAR resources with
IORESOURCE_PCI_FIXED from the header fixup.  Allow this to work with
the SRIOV BARs as well by testing if the BAR resource has already been
set before attempting to read it from the config space.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/iov.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..f8a6e1e 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -436,8 +436,13 @@ found:
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
-		bar64 = __pci_read_base(dev, pci_bar_unknown, res,
-					pos + PCI_SRIOV_BAR + i * 4);
+		if (res->flags)
+			/* Already populated by quirks, just set bar64. */
+			bar64 = (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
+		else
+			bar64 = __pci_read_base(dev, pci_bar_unknown, res,
+						pos + PCI_SRIOV_BAR + i * 4);
+
 		if (!res->flags)
 			continue;
 		if (resource_size(res) & (PAGE_SIZE - 1)) {
-- 
1.9.1
