From: nixiaoming@huawei.com (nixiaoming)
Date: Tue, 29 May 2018 21:36:28 +0800
Subject: [PATCH 3/3] s390:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180529133628.27055-1-nixiaoming@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mark_rodata_ro is only called by the function mark_readonly
when CONFIG_STRICT_KERNEL_RWX=y

if CONFIG_STRICT_KERNEL_RWX is not set
a compile warning may be triggered: unused function

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/s390/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3fa3e53..a96fc3f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -116,6 +116,7 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long size = __end_ro_after_init - __start_ro_after_init;
@@ -123,6 +124,7 @@ void mark_rodata_ro(void)
 	set_memory_ro((unsigned long)__start_ro_after_init, size >> PAGE_SHIFT);
 	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
 }
+#endif
 
 void __init mem_init(void)
 {
-- 
2.10.1
