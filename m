From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 14:11:04 -0600
Subject: [PATCH v2] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
Message-ID: <20130917201104.GA5209@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the property was not specified then then the returned resource
had a resource_size(..) == 1, rather than 0. The PCI-E driver checks
for 0 so it blindly continues on with a corrupted resource.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

- Revise the comment to clarify the code is setting resource_size(x)
  to 0 [Thomas]
- Use -1 instead of -- for clarity

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 19ab6ff..8aa6cdd 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -861,11 +861,13 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	int ret;
 
 	/*
-	 * These are optional, so we clear them and they'll
-	 * be zero if they are missing from the DT.
+	 * These are optional, so we make sure that resource_size(x) will
+	 * return 0.
 	 */
 	memset(mem, 0, sizeof(struct resource));
+	mem->end = -1;
 	memset(io, 0, sizeof(struct resource));
+	io->end = -1;
 
 	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
 	if (!ret) {
-- 
1.8.1.2
