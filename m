From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 29 May 2014 11:03:46 -0500
Subject: [PATCH] of: treat PCI config space as IORESOURCE_MEM type
Message-ID: <1401379426-9701-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we have a PCI config space specified in something like a ranges
property we should treat it as memory type resource.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 drivers/of/address.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index cb4242a..4e7ee59 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -122,6 +122,9 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 	u32 w = be32_to_cpup(addr);
 
 	switch((w >> 24) & 0x03) {
+	case 0x00: /* cfg space */
+		flags |= IORESOURCE_MEM;
+		break;
 	case 0x01:
 		flags |= IORESOURCE_IO;
 		break;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
