From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Sat,  9 Oct 2010 20:31:20 +0530
Subject: [PATCH] amba: add name based matching
Message-ID: <1286636480-27454-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some peripherals on the DBx500 family of SoCs have changes in their
functionality and registers between different variants in the family but
retain the same AMBA peripheral ID, making it impossible to distinguish
between them in AMBA drivers with the current AMBA id_table.

To support this, add a name parameter to the amba_device and the amba_id
and allow name based matching as a second level filter after the
periphid match.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/amba/bus.c       |    6 ++++++
 include/linux/amba/bus.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d31590e..926121a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -28,6 +28,12 @@ amba_lookup(struct amba_id *table, struct amba_device *dev)
 
 	while (table->mask) {
 		ret = (dev->periphid & table->mask) == table->id;
+		if (ret && (table->name || dev->name)) {
+			if (table->name && dev->name)
+				ret = strcmp(dev->name, table->name) == 0;
+			else
+				ret = 0;
+		}
 		if (ret)
 			break;
 		table++;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index b0c1740..61ec94a 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -29,12 +29,14 @@ struct amba_device {
 	struct clk		*pclk;
 	u64			dma_mask;
 	unsigned int		periphid;
+	const char		*name;
 	unsigned int		irq[AMBA_NR_IRQS];
 };
 
 struct amba_id {
 	unsigned int		id;
 	unsigned int		mask;
+	const char		*name;
 	void			*data;
 };
 
-- 
1.7.1
