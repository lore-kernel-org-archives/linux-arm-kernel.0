From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Dec 2014 14:11:09 +0000
Subject: [PATCH] irqchip: gicv3-its: fix use of max with decimal constant
Message-ID: <1418825469-30529-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 defconfig spits out the following compiler warning from the ITS
driver:

In file included from include/linux/bitmap.h:9:0,
                 from drivers/irqchip/irq-gic-v3-its.c:18:
drivers/irqchip/irq-gic-v3-its.c: In function ?its_create_device?:
include/linux/kernel.h:716:17: warning: comparison of distinct pointer types lacks a cast
  (void) (&_max1 == &_max2);  \
                 ^
drivers/irqchip/irq-gic-v3-its.c:1056:12: note: in expansion of macro ?max?
  nr_ites = max(2, roundup_pow_of_two(nvecs));

Fix the warning by specifying the decimal constant `2' explicitly as an
unsigned long type.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 86e4684adeb1..d8996bdf0f61 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1053,7 +1053,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 * of two entries. No, the architecture doesn't let you
 	 * express an ITT with a single entry.
 	 */
-	nr_ites = max(2, roundup_pow_of_two(nvecs));
+	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kmalloc(sz, GFP_KERNEL);
-- 
2.1.3
