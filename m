From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 19 Jun 2018 19:20:49 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: Stop compiling headsmp-apmu on !SMP
Message-ID: <20180619172049.20089-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit cad160ed0a94927e ("ARM: shmobile: Convert file to use
cntvoff"), there's no non-SMP code left in headsmp-apmu.S.

Hence build the file for SMP only, and drop the no longer needed check
for CONFIG_SMP inside the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile       | 2 +-
 arch/arm/mach-shmobile/headsmp-apmu.S | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 05ba728ed4f67cf2..b33dc59d8698d218 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -21,13 +21,13 @@ cpu-y				:= platsmp.o headsmp.o
 # Shared SoC family objects
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
-obj-$(CONFIG_ARCH_RCAR_GEN2)	+= headsmp-apmu.o
 obj-$(CONFIG_ARCH_R8A7790)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
+smp-$(CONFIG_ARCH_RCAR_GEN2)	+= headsmp-apmu.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
index a7b4bc7a087bdca1..fabe9cadd12ef0b1 100644
--- a/arch/arm/mach-shmobile/headsmp-apmu.S
+++ b/arch/arm/mach-shmobile/headsmp-apmu.S
@@ -8,9 +8,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-#ifdef CONFIG_SMP
 ENTRY(shmobile_boot_apmu)
 	bl	secure_cntvoff_init
 	b	secondary_startup
 ENDPROC(shmobile_boot_apmu)
-#endif
-- 
2.17.1
