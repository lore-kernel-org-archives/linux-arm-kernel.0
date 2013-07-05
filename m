From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:13 -0300
Subject: [PATCH v6 02/21] bus: mvebu-mbus: Add new API for window creation
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

We add an API to create MBus address decoding windows from the target
ID and attribute. This function will be used later and deprecate the
current name based scheme.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 33 +++++++++++++++++++++++++--------
 include/linux/mbus.h     |  6 ++++++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 33c6947..827468a 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -748,6 +748,22 @@ static const struct of_device_id of_mvebu_mbus_ids[] = {
 /*
  * Public API of the driver
  */
+int mvebu_mbus_add_window_remap_by_id(unsigned int target,
+				      unsigned int attribute,
+				      phys_addr_t base, size_t size,
+				      phys_addr_t remap)
+{
+	struct mvebu_mbus_state *s = &mbus_state;
+
+	if (!mvebu_mbus_window_conflicts(s, base, size, target, attribute)) {
+		pr_err("cannot add window '%x:%x', conflicts with another window\n",
+		       target, attribute);
+		return -EINVAL;
+	}
+
+	return mvebu_mbus_alloc_window(s, base, size, remap, target, attribute);
+}
+
 int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 				      size_t size, phys_addr_t remap,
 				      unsigned int flags)
@@ -776,14 +792,8 @@ int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 	else if (flags == MVEBU_MBUS_PCI_WA)
 		attr |= 0x28;
 
-	if (!mvebu_mbus_window_conflicts(s, base, size, target, attr)) {
-		pr_err("cannot add window '%s', conflicts with another window\n",
-		       devname);
-		return -EINVAL;
-	}
-
-	return mvebu_mbus_alloc_window(s, base, size, remap, target, attr);
-
+	return mvebu_mbus_add_window_remap_by_id(target, attr, base,
+						 size, remap);
 }
 
 int mvebu_mbus_add_window(const char *devname, phys_addr_t base, size_t size)
@@ -792,6 +802,13 @@ int mvebu_mbus_add_window(const char *devname, phys_addr_t base, size_t size)
 						 MVEBU_MBUS_NO_REMAP, 0);
 }
 
+int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
+				phys_addr_t base, size_t size)
+{
+	return mvebu_mbus_add_window_remap_by_id(target, attribute, base,
+						 size, MVEBU_MBUS_NO_REMAP);
+}
+
 int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 {
 	int win;
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index dba482e..9245b66 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -62,8 +62,14 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 				      size_t size, phys_addr_t remap,
 				      unsigned int flags);
+int mvebu_mbus_add_window_remap_by_id(unsigned int target,
+				      unsigned int attribute,
+				      phys_addr_t base, size_t size,
+				      phys_addr_t remap);
 int mvebu_mbus_add_window(const char *devname, phys_addr_t base,
 			  size_t size);
+int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
+				phys_addr_t base, size_t size);
 int mvebu_mbus_del_window(phys_addr_t base, size_t size);
 int mvebu_mbus_init(const char *soc, phys_addr_t mbus_phys_base,
 		    size_t mbus_size, phys_addr_t sdram_phys_base,
-- 
1.8.1.5
