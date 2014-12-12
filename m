From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 10:51:24 +0000
Subject: [PATCH 3/3] irqchip: gicv3-its: Fix ITT allocation
In-Reply-To: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
References: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1418381484-4394-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When issuing a MAPD command, one of the parameters passed to the ITS
is the number of EventID bits used to index the per-device Interrupt
Translation Table (ITT). Crucially, this is the number of bits
*minus one*.

This has two consequences:
- The size of the ITT has to be a strict power of two, no matter
  how many different events the device is actually going to generate.
- It is impossible to express an ITT with a single entry, as you
  would have to tell the ITS to "use zero bit from the EventID",
  and that clashes with "minus one" above.

Fix this by allocating the ITT with the number of vectors rounded up
to the next power of two, with a minimum of two entries.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 98144fd..86e4684 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -228,7 +228,7 @@ static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
 						 struct its_cmd_desc *desc)
 {
 	unsigned long itt_addr;
-	u8 size = order_base_2(desc->its_mapd_cmd.dev->nr_ites);
+	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
 
 	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
 	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
@@ -1043,11 +1043,18 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	void *itt;
 	int lpi_base;
 	int nr_lpis;
+	int nr_ites;
 	int cpu;
 	int sz;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	sz = nvecs * its->ite_size;
+	/*
+	 * At least one bit of EventID is being used, hence a minimum
+	 * of two entries. No, the architecture doesn't let you
+	 * express an ITT with a single entry.
+	 */
+	nr_ites = max(2, roundup_pow_of_two(nvecs));
+	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kmalloc(sz, GFP_KERNEL);
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
@@ -1061,7 +1068,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 	dev->its = its;
 	dev->itt = itt;
-	dev->nr_ites = nvecs;
+	dev->nr_ites = nr_ites;
 	dev->lpi_map = lpi_map;
 	dev->lpi_base = lpi_base;
 	dev->nr_lpis = nr_lpis;
-- 
2.1.3
