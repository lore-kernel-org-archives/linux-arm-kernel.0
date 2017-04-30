From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 30 Apr 2017 09:36:15 -0500
Subject: [PATCH v4] irqchip/gicv3-its: Avoid memory over allocation for ITEs
Message-ID: <1493562975-14365-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are always allocating extra 255Bytes of memory to handle ITE
physical address alignment requirement. The kmalloc() satisfies
the ITE alignment since the ITS driver is requesting a minimum
size of ITS_ITT_ALIGN bytes.

Let's try to allocate the exact amount of memory that is required
for ITEs to avoid wastage.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes:
v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
v3: changed from IITE to ITE.
v3: removed fallback since kmalloc() guarantees the right alignment.

 drivers/irqchip/irq-gic-v3-its.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 45ea1933..72e56f03 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -261,7 +261,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
 	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
 
 	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
-	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
 
 	its_encode_cmd(cmd, GITS_CMD_MAPD);
 	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -1329,13 +1328,14 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 */
 	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
-	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	sz = max(sz, ITS_ITT_ALIGN);
 	itt = kzalloc(sz, GFP_KERNEL);
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
 	if (lpi_map)
 		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
 
-	if (!dev || !itt || !lpi_map || !col_map) {
+	if (!dev || !itt || !lpi_map || !col_map ||
+	    !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
 		kfree(dev);
 		kfree(itt);
 		kfree(lpi_map);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
