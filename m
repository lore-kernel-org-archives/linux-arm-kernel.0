From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 May 2011 14:38:25 +0100
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revision=
Message-ID: <mailman.27.1308131645.24103.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s

It appears that the system-wide flags register that used to be at
0x02025000 on the first revision of Exynos4 has moved to 0x02020000.

The kernel has been updated accordingly, but this unfortunately leaves
early boards without SMP support (the secondary CPU spins endlessly
in BL0 waiting for an address to be written at that memory location).

Solve the problem by providing an s3c_get_chip_id() function, common
to all s3c/s5p implementations, and test the result on the secondary boot
path.

Revision table, as provided by Kyungmin Park <kmpark@infradead.org>:
0x4320 0200 EVT0
0x4321 0210 EVT1
0x4321 0211 EVT2

The last 8 bits can be overrided by efuses, so only bits [16:19] are
used to identify the revision.

Tested on a vintage SMDK-v310.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kmpark@infradead.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/include/mach/map.h |    1 +
 arch/arm/mach-exynos4/platsmp.c          |   22 +++++++++++++++++++++-
 arch/arm/plat-samsung/include/plat/cpu.h |    2 ++
 arch/arm/plat-samsung/init.c             |    8 ++++++++
 4 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exyno=
s4/include/mach/map.h
index 57d8074..da08f5c 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -24,6 +24,7 @@
 #include <plat/map-s5p.h>
=20
 #define EXYNOS4_PA_SYSRAM=09=090x02020000
+#define EXYNOS4_PA_SYSRAM_EVT0=09=090x02025000
=20
 #define EXYNOS4_PA_FIMC0=09=090x11800000
 #define EXYNOS4_PA_FIMC1=09=090x11810000
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsm=
p.c
index c5e65a0..086d1e3 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -26,6 +26,8 @@
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
=20
+#include <plat/cpu.h>
+
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
=20
@@ -170,6 +172,24 @@ void __init platform_smp_prepare_cpus(unsigned int max=
_cpus)
 =09 * system-wide flags register. The boot monitor waits
 =09 * until it receives a soft interrupt, and then the
 =09 * secondary CPU branches to this address.
+=09 *
+=09 * EVT0 has the system-wide flags register at a different
+=09 * address, hence the following hackery...
 =09 */
-=09__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSR=
AM);
+=09if (s3c_get_chip_id() & 0xF0000UL)
+=09=09__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+=09=09=09     S5P_VA_SYSRAM);
+=09else {
+=09=09void __iomem *sysram_evt0;
+
+=09=09sysram_evt0 =3D ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);
+=09=09if (!sysram_evt0) {
+=09=09=09pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");
+=09=09=09return;
+=09=09}
+=09=09__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+=09=09=09     sysram_evt0);
+=09=09iounmap(sysram_evt0);
+=09}
+
 }
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsu=
ng/include/plat/cpu.h
index c0a5741..41573cc 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -44,6 +44,8 @@ struct cpu_table {
 extern void s3c_init_cpu(unsigned long idcode,
 =09=09=09 struct cpu_table *cpus, unsigned int cputab_size);
=20
+extern unsigned long s3c_get_chip_id(void);
+
 /* core initialisation functions */
=20
 extern void s3c24xx_init_irq(void);
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 79d10fc..320b88f 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -30,6 +30,7 @@
 #include <plat/regs-serial.h>
=20
 static struct cpu_table *cpu;
+static unsigned long s3c_chip_id;
=20
 static struct cpu_table * __init s3c_lookup_cpu(unsigned long idcode,
 =09=09=09=09=09=09struct cpu_table *tab,
@@ -60,6 +61,8 @@ void __init s3c_init_cpu(unsigned long idcode,
 =09=09panic("Unsupported Samsung CPU");
 =09}
=20
+=09s3c_chip_id =3D idcode;
+
 =09cpu->map_io();
 }
=20
@@ -140,6 +143,11 @@ void __init s3c24xx_init_uarts(struct s3c2410_uartcfg =
*cfg, int no)
 =09=09(cpu->init_uarts)(cfg, no);
 }
=20
+unsigned long s3c_get_chip_id(void)
+{
+=09return s3c_chip_id;
+}
+
 static int __init s3c_arch_init(void)
 {
 =09int ret;
--=20
1.7.0.4

--------------030601050903020505020403--
