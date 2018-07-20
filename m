From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:31 +0200
Subject: [PATCH 1/5] ARM: shmobile: rcar-gen2: Stop compiling headsmp-apmu on
 !SMP
In-Reply-To: <cover.1532087129.git.horms+renesas@verge.net.au>
References: <cover.1532087129.git.horms+renesas@verge.net.au>
Message-ID: <23295aeebf0706c717adf55487779b19a3605e21.1532087129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit cad160ed0a94927e ("ARM: shmobile: Convert file to use
cntvoff"), there's no non-SMP code left in headsmp-apmu.S.

Hence build the file for SMP only, and drop the no longer needed check
for CONFIG_SMP inside the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile       | 2 +-
 arch/arm/mach-shmobile/headsmp-apmu.S | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 05ba728ed4f6..b33dc59d8698 100644
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
index a7b4bc7a087b..fabe9cadd12e 100644
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
2.11.0
