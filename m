From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 10:31:17 -0300
Subject: [PATCH v8 13/28] bus: mvebu-mbus: Remove the no longer used
 name-based API
In-Reply-To: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374586292-4941-14-git-send-email-ezequiel.garcia@free-electrons.com>
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
index 929fed1..b4a7382 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -766,44 +766,6 @@ int mvebu_mbus_add_window_remap_by_id(unsigned int target,
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
index 650bc15..345b8c5 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -63,15 +63,10 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
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
