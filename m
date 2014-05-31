From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Sat, 31 May 2014 01:36:41 +0100
Subject: [PATCH 2/2] of: treat PCI config space as IORESOURCE_MEM type with
 special flags.
In-Reply-To: <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1401496601-31983-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we have a PCI config space specified in something like a ranges
property we should treat it as memory type resource. Use the
IORESOURCE_ECFG bit to distinguish the config space from standard
IORESOURCE_MEM resources.

Signed-off-by: Kumar Gama <galak@codeaurora.org>
[Updated commit log and added IORESOURCE_ECFG bit]
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/of/address.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 2fcfbae..877e9e5 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -123,6 +123,9 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 	u32 w = be32_to_cpup(addr);
 
 	switch((w >> 24) & 0x03) {
+	case 0x00: /* cfg space */
+		flags |= IORESOURCE_MEM | IORESOURCE_PCI_ECFG;
+		break;
 	case 0x01:
 		flags |= IORESOURCE_IO;
 		break;
-- 
1.9.2
