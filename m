From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 08 Feb 2017 11:10:59 +0000
Subject: [PATCH 1/3] ARM: mm: move initrd init code out of arm_memblock_init()
In-Reply-To: <20170208111024.GV27312@n2100.armlinux.org.uk>
References: <20170208111024.GV27312@n2100.armlinux.org.uk>
Message-ID: <E1cbQ9L-0003tO-68@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the ARM initrd initialisation code out of arm_memblock_init() into
its own function, so it can be cleaned up.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/init.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 50e5402a8ef3..43d8825e59bb 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -228,11 +228,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	return phys;
 }
 
-void __init arm_memblock_init(const struct machine_desc *mdesc)
+static void __init arm_initrd_init(void)
 {
-	/* Register the kernel text, kernel data and initrd with memblock. */
-	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* FDT scan will populate initrd_start */
 	if (initrd_start && !phys_initrd_size) {
@@ -260,6 +257,14 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 		initrd_end = initrd_start + phys_initrd_size;
 	}
 #endif
+}
+
+void __init arm_memblock_init(const struct machine_desc *mdesc)
+{
+	/* Register the kernel text, kernel data and initrd with memblock. */
+	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
+
+	arm_initrd_init();
 
 	arm_mm_memblock_reserve();
 
-- 
2.7.4
