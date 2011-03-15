From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 15 Mar 2011 15:41:53 +0100
Subject: [PATCH 1/4] amba: add name based matching
In-Reply-To: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

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
index 6d2bb25..7f1590f 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -29,6 +29,12 @@ amba_lookup(const struct amba_id *table, struct amba_device *dev)
 
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
index fcbbe71..f5f82b2 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -32,12 +32,14 @@ struct amba_device {
 	struct regulator	*vcore;
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
1.7.3.1
