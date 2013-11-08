From: robherring2@gmail.com (Rob Herring)
Date: Fri,  8 Nov 2013 15:25:56 -0600
Subject: [PATCH] ARM: rename ioremap_cached to ioremap_cache
Message-ID: <1383945956-27788-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

ioremap_cache is more aligned with other architectures. There are only
2 users of this in the kernel: pxa2xx-flash and Xen.

This fixes Xen build failures on arm64:

drivers/tty/hvc/hvc_xen.c:233:2: error: implicit declaration of function 'ioremap_cached' [-Werror=implicit-function-declaration]
drivers/xen/grant-table.c:1174:3: error: implicit declaration of function 'ioremap_cached' [-Werror=implicit-function-declaration]
drivers/xen/xenbus/xenbus_probe.c:778:4: error: implicit declaration of function 'ioremap_cached' [-Werror=implicit-function-declaration]

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/io.h       | 2 +-
 arch/arm/include/asm/xen/page.h | 2 +-
 drivers/mtd/maps/pxa2xx-flash.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3c597c2..fbeb39c 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -329,7 +329,7 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  */
 #define ioremap(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE)
-#define ioremap_cached(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE_CACHED)
+#define ioremap_cache(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE_WC)
 #define iounmap				__arm_iounmap
 
diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 5d0e4c5..a8591fb 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -123,6 +123,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
-#define xen_remap(cookie, size) ioremap_cached((cookie), (size));
+#define xen_remap(cookie, size) ioremap_cache((cookie), (size));
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index d210d13..0f55589 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -73,7 +73,7 @@ static int pxa2xx_flash_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	info->map.cached =
-		ioremap_cached(info->map.phys, info->map.size);
+		ioremap_cache(info->map.phys, info->map.size);
 	if (!info->map.cached)
 		printk(KERN_WARNING "Failed to ioremap cached %s\n",
 		       info->map.name);
-- 
1.8.1.2
