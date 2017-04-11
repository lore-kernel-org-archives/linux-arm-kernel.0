From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:56:04 +0100
Subject: [PATCH 5/5] Add "remove" probe driver for memory hot-remove
In-Reply-To: <cover.1491920513.git.ar@linux.vnet.ibm.com>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <0547052acd62958af1336281fcee8735c9d91d07.1491920514.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows to remove sections of memory that have been previously offlined
from userspace.

This is symmetric to the "memory probe" interface, as described in
Documentation/memory-hotplug.txt. It can be used to manually notify the
OS that one memory section has been removed.

Please, remind that a memory section can only be removed after it has
been logically off-lined; trying to remove a section which has not been
previously off-lined is not supported and will have undefined (but most
likely very bad) behaviour.

To offline a section one can:
# echo offline > /sys/devices/system/memory/memoryXXX/state

To use the remove interface to remove the section:
# echo $((0xYYYYYY)) > /sys/devices/system/memory/remove

where 0xYYYYYY is the physical address of the memory section to remove.

Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
Signed-off-by: Maciej Bielski <m.bielski@virtualopensystems.com>
---
 drivers/base/memory.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index cc4f1d0..8e033b5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -511,7 +511,36 @@ static DEVICE_ATTR(auto_online_blocks, 0644, show_auto_online_blocks,
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
-#endif
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static ssize_t
+memory_remove_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	u64 phys_addr;
+	int nid, ret;
+	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
+
+	ret = kstrtoull(buf, 0, &phys_addr);
+	if (ret)
+		return ret;
+
+	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
+		return -EINVAL;
+
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	remove_memory(nid, phys_addr,
+			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
+	unlock_device_hotplug();
+	return count;
+}
+static DEVICE_ATTR(remove, S_IWUSR, NULL, memory_remove_store);
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+#endif /* CONFIG_ARCH_MEMORY_PROBE */
 
 #ifdef CONFIG_MEMORY_FAILURE
 /*
@@ -776,6 +805,9 @@ bool is_memblock_offlined(struct memory_block *mem)
 static struct attribute *memory_root_attrs[] = {
 #ifdef CONFIG_ARCH_MEMORY_PROBE
 	&dev_attr_probe.attr,
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	&dev_attr_remove.attr,
+#endif
 #endif
 
 #ifdef CONFIG_MEMORY_FAILURE
-- 
1.9.1
