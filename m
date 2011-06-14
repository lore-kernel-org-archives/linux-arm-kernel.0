From: angus.ainslie@linaro.org (Angus Ainslie)
Date: Tue, 14 Jun 2011 16:13:35 -0600
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revision=
Message-ID: <mailman.26.1308090403.24103.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s

It appears that the system-wide flags register that used to be at
0x02025000 on the first revision of Exynos4 has moved to 0x02020000.

The kernel has been updated accordingly, but this unfortunately leaves
early boards without SMP support (the secondary CPU spins endlessly
in BL0 waiting for an address to be written at that memory location).

Use the CPU id to decide whether we are running on EVT0 and use the
old location in that case.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Angus Ainslie <angus.ainslie@linaro.org>
---
 arch/arm/mach-exynos4/include/mach/map.h |    1 +
 arch/arm/mach-exynos4/platsmp.c          |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/map.h
b/arch/arm/mach-exynos4/include/mach/map.h
index 0009e77..781e149 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -24,6 +24,7 @@
 #include <plat/map-s5p.h>

 #define EXYNOS4_PA_SYSRAM              0x02020000
+#define EXYNOS4_PA_SYSRAM_EVT0         0x02025000

 #define EXYNOS4_PA_FIMC0               0x11800000
 #define EXYNOS4_PA_FIMC1               0x11810000
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsm=
p.c
index c5e65a0..5f70aec 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -155,6 +155,8 @@ void __init smp_init_cpus(void)
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
        int i;
+       unsigned long idcode;
+       void __iomem *sysram_evt0;

        /*
         * Initialise the present map, which describes the set of CPUs
@@ -165,11 +167,30 @@ void __init platform_smp_prepare_cpus(unsigned
int max_cpus)

        scu_enable(scu_base_addr());

+       idcode =3D __raw_readl(S5P_VA_CHIPID);
+
        /*
         * Write the address of secondary startup into the
         * system-wide flags register. The boot monitor waits
         * until it receives a soft interrupt, and then the
         * secondary CPU branches to this address.
         */
-       __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
S5P_VA_SYSRAM);
+       if ((idcode & 0xF0000) =3D=3D 0) {
+               /*
+                * EVT0 has the system-wide flags register at a
different address.
+                * Poke it as well, in case we're running on an old
SoC revision.
+                */
+               sysram_evt0 =3D ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);
+               if (!sysram_evt0) {
+                       pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");
+                       return;
+               }
+               __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+                            sysram_evt0);
+               iounmap(sysram_evt0);
+       } else {
+               __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+                            S5P_VA_SYSRAM);
+       }
+
 }
--=20
1.7.4.1

--=20
Angus Ainslie <angus.ainslie@linaro.org>
Team Lead, Samsung Landing Team
