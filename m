From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 23 Apr 2016 17:33:07 +0800
Subject: [PATCH] of: iommu: make of_iommu_init() postcore_initcall_sync
Message-ID: <1461403987-10697-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_iommu_init() is called multiple times by arch code,
make it postcore_initcall_sync, then we can drop relevant
calls fully.

Note, the IOMMUs should have a chance to perform some basic
initialisation before we start adding masters to them. So
postcore_initcall_sync is good choice, it ensures of_iommu_init()
called before of_platform_populate.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/kernel/setup.c     | 2 --
 arch/arm64/kernel/setup.c   | 2 --
 arch/sh/boards/of-generic.c | 2 --
 drivers/iommu/of_iommu.c    | 5 ++++-
 include/linux/of_iommu.h    | 2 --
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 2c4bea3..18a29a0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -19,7 +19,6 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
@@ -902,7 +901,6 @@ static int __init customize_machine(void)
 	 * machine from the device tree, if no callback is provided,
 	 * otherwise we would always need an init_machine callback.
 	 */
-	of_iommu_init();
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 #ifdef CONFIG_OF
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9dc6776..e20b64f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -39,7 +39,6 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
-#include <linux/of_iommu.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/efi.h>
@@ -365,7 +364,6 @@ void __init setup_arch(char **cmdline_p)
 static int __init arm64_device_init(void)
 {
 	if (of_have_populated_dt()) {
-		of_iommu_init();
 		of_platform_populate(NULL, of_default_bus_match_table,
 				     NULL, NULL);
 	} else if (acpi_disabled) {
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index bf3a166..b4d4313 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
-#include <linux/of_iommu.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <linux/clk-provider.h>
@@ -185,7 +184,6 @@ static int __init sh_of_device_init(void)
 {
 	pr_info("SH generic board support: populating platform devices\n");
 	if (of_have_populated_dt()) {
-		of_iommu_init();
 		of_platform_populate(NULL, of_default_bus_match_table,
 				     NULL, NULL);
 	} else {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5fea665..04cc80f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -174,7 +174,7 @@ err_put_node:
 	return NULL;
 }
 
-void __init of_iommu_init(void)
+static int __init of_iommu_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match, *matches = &__iommu_of_table;
@@ -186,4 +186,7 @@ void __init of_iommu_init(void)
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
+
+	return 0;
 }
+postcore_initcall_sync(of_iommu_init);
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index ffbe470..e2c2e71 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -11,7 +11,6 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     int index, unsigned long *busno, dma_addr_t *addr,
 			     size_t *size);
 
-extern void of_iommu_init(void);
 extern struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
@@ -24,7 +23,6 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 	return -EINVAL;
 }
 
-static inline void of_iommu_init(void) { }
 static inline struct iommu_ops *of_iommu_configure(struct device *dev,
 					 struct device_node *master_np)
 {
-- 
2.6.0.GIT
