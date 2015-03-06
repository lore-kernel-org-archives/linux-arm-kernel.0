From: wuyun.wu@huawei.com (Yun Wu)
Date: Fri, 6 Mar 2015 12:13:19 +0800
Subject: [PATCH v4 1/5] irqchip: gicv3-its: zero itt before handling to
 hardware
In-Reply-To: <1425615203-3300-1-git-send-email-wuyun.wu@huawei.com>
References: <1425615203-3300-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1425615203-3300-2-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some kind of brain-dead implementations chooses to insert ITEes in
rapid sequence of disabled ITEes, and an un-zeroed ITT will confuse
ITS on judging whether an ITE is really enabled or not. Considering
the implementations are still supported by the GICv3 architecture,
in which ITT is not required to be zeroed before being handled to
hardware, we do the favor in ITS driver.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6850141..69eeea3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1076,7 +1076,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kmalloc(sz, GFP_KERNEL);
+	itt = kzalloc(sz, GFP_KERNEL);
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);

 	if (!dev || !itt || !lpi_map) {
--
1.8.0
