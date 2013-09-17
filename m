From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 12:38:53 -0600
Subject: [PATCH] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties
Message-ID: <20130917183853.GC21230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the property was not specified then then the returned resource
had a resource_size(..) == 1, rather than 0. The PCI-E driver checks
for 0 so it blindly continues on with a corrupted resource.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 19ab6ff..7a66203 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -866,6 +866,8 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	 */
 	memset(mem, 0, sizeof(struct resource));
 	memset(io, 0, sizeof(struct resource));
+	mem->end--;
+	io->end--;
 
 	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
 	if (!ret) {
-- 
1.8.1.2
