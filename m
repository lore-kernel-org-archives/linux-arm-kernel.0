From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue,  7 Mar 2017 08:25:20 -0600
Subject: [PATCH v3] irqchip/gicv3-its: Avoid memory over allocation for ITEs
Message-ID: <1488896720-6223-1-git-send-email-shankerd@codeaurora.org>
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
v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
v3: changed from IITE to ITE.

 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 86bd428..5aeca78 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1329,8 +1329,13 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 */
 	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
-	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	sz = max(sz, ITS_ITT_ALIGN);
 	itt = kzalloc(sz, GFP_KERNEL);
+	if (itt && !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
+		kfree(itt);
+		itt = kzalloc(sz + ITS_ITT_ALIGN - 1, GFP_KERNEL);
+	}
+
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
 	if (lpi_map)
 		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
