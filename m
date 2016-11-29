From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:45 +0000
Subject: [RFC v2 PATCH 03/23] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SECTION_SIZE is referenced from several places which breaks NOMMU
build:

  CC      arch/arm/kernel/setup.o
arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
arch/arm/kernel/setup.c:1001:25: error: 'SECTION_SIZE' undeclared (first use in this function)
             crash_size, SECTION_SIZE);
                         ^
arch/arm/kernel/setup.c:1001:25: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/kernel/setup.o] Error 1
make: *** [arch/arm/kernel] Error 2

...

In file included from ./include/linux/cache.h:4:0,
                 from ./include/linux/printk.h:8,
                 from ./include/linux/kernel.h:13,
                 from arch/arm/mach-omap2/omap-secure.c:15:
arch/arm/mach-omap2/omap-secure.c: In function 'omap_secure_ram_reserve_memblock':
arch/arm/mach-omap2/omap-secure.c:65:21: error: 'SECTION_SIZE' undeclared (first use in this function)
  size = ALIGN(size, SECTION_SIZE);
                     ^
./include/uapi/linux/kernel.h:10:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^
./include/linux/kernel.h:48:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^
arch/arm/mach-omap2/omap-secure.c:65:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, SECTION_SIZE);
         ^
arch/arm/mach-omap2/omap-secure.c:65:21: note: each undeclared identifier is reported only once for each function it appears in
  size = ALIGN(size, SECTION_SIZE);
                     ^
./include/uapi/linux/kernel.h:10:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^
./include/linux/kernel.h:48:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^
arch/arm/mach-omap2/omap-secure.c:65:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, SECTION_SIZE);
         ^
make[1]: *** [arch/arm/mach-omap2/omap-secure.o] Error 1

...

In file included from arch/arm/mach-tegra/io.c:31:0:
arch/arm/mach-tegra/iomap.h:116:22: error: 'SECTION_SIZE' undeclared here (not in a function)
 #define IO_PPSB_SIZE SECTION_SIZE
                      ^
arch/arm/mach-tegra/io.c:37:13: note: in expansion of macro 'IO_PPSB_SIZE'
   .length = IO_PPSB_SIZE,
             ^
arch/arm/mach-tegra/io.c:33:24: warning: 'tegra_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc tegra_io_desc[] __initdata = {
                        ^
make[1]: *** [arch/arm/mach-tegra/io.o] Error 1
make: *** [arch/arm/mach-tegra] Error 2

Pickup defines from pgtable-2level.h to make NOMMU build happy.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/pgtable-nommu.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index add094d..9115801 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -35,6 +35,11 @@
 
 #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+#define SECTION_SHIFT           20
+#define SECTION_SIZE            (1UL << SECTION_SHIFT)
+#define SECTION_MASK            (~(SECTION_SIZE-1))
+
 /* FIXME */
 
 #define PAGE_NONE	__pgprot(0)
-- 
1.7.9.5
