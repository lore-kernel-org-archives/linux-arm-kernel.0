From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:22 -0300
Subject: [PATCH v6 11/21] bus: mvebu-mbus: Remove the no longer used
 name-based API
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-12-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Now that every user of the deprecated name-based API has been
converted to using the ID-based API, let's remove the former one.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 38 --------------------------------------
 include/linux/mbus.h     |  5 -----
 2 files changed, 43 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 8aa3b45..db68436 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -764,44 +764,6 @@ int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 	return mvebu_mbus_alloc_window(s, base, size, remap, target, attribute);
 }
 
-int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
-				      size_t size, phys_addr_t remap,
-				      unsigned int flags)
-{
-	struct mvebu_mbus_state *s = &mbus_state;
-	u8 target, attr;
-	int i;
-
-	if (!s->soc->map)
-		return -ENODEV;
-
-	for (i = 0; s->soc->map[i].name; i++)
-		if (!strcmp(s->soc->map[i].name, devname))
-			break;
-
-	if (!s->soc->map[i].name) {
-		pr_err("unknown device '%s'\n", devname);
-		return -ENODEV;
-	}
-
-	target = s->soc->map[i].target;
-	attr   = s->soc->map[i].attr;
-
-	if (flags == MVEBU_MBUS_PCI_MEM)
-		attr |= 0x8;
-	else if (flags == MVEBU_MBUS_PCI_WA)
-		attr |= 0x28;
-
-	return mvebu_mbus_add_window_remap_by_id(target, attr, base,
-						 size, remap);
-}
-
-int mvebu_mbus_add_window(const char *devname, phys_addr_t base, size_t size)
-{
-	return mvebu_mbus_add_window_remap_flags(devname, base, size,
-						 MVEBU_MBUS_NO_REMAP, 0);
-}
-
 int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 				phys_addr_t base, size_t size)
 {
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index eadefd6..fa84dcb 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -59,15 +59,10 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 }
 #endif
 
-int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
-				      size_t size, phys_addr_t remap,
-				      unsigned int flags);
 int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 				      unsigned int attribute,
 				      phys_addr_t base, size_t size,
 				      phys_addr_t remap);
-int mvebu_mbus_add_window(const char *devname, phys_addr_t base,
-			  size_t size);
 int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 				phys_addr_t base, size_t size);
 int mvebu_mbus_del_window(phys_addr_t base, size_t size);
-- 
1.8.1.5
