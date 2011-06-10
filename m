From: zecke@selfish.org (Holger Hans Peter Freyther)
Date: Fri, 10 Jun 2011 20:38:43 +0200
Subject: [PATCH] irq: Check if someone is overwriting the irq chip data
Message-ID: <mailman.14.1307792983.24103.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tries to establish the semantic that one can either
set the chip data to NULL or if it is NULL to some value
but never overwrite a non NULL value.

Signed-off-by: Holger Hans Peter Freyther <zecke@selfish.org>
---
 kernel/irq/chip.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index d5a3009..25e446d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -123,6 +123,10 @@ int irq_set_chip_data(unsigned int irq, void *data)

 	if (!desc)
 		return -EINVAL;
+
+	BUG_ON(data && desc->irq_data.chip_data &&
+		data != desc->irq_data.chip_data);
+
 	desc->irq_data.chip_data = data;
 	irq_put_desc_unlock(desc, flags);
 	return 0;
-- 
1.7.4.1
