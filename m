From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  6 Jun 2018 10:52:34 +0200
Subject: [PATCH] ARM: Build secure_cntvoff.S unconditionally to fix shmobile
 !SMP build
Message-ID: <1528275154-5164-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_SMP=n, building a kernel for R-Car Gen2 fails with:

    arch/arm/mach-shmobile/setup-rcar-gen2.o: In function `rcar_gen2_timer_init':
    setup-rcar-gen2.c:(.init.text+0x30): undefined reference to `secure_cntvoff_init'

Indeed, on R-Car Gen2 SoCs, secure_cntvoff_init() is not only needed for
secondary CPUs, but also for the boot CPU.  This is most visible on SoCs
with Cortex A7 cores (e.g. R-Car E2, cfr. commit 9ce3fa6816c2fb59 ("ARM:
shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794")),
but Cortex A15 is affected, too.

Fix this by always providing secure_cntvoff_init().

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7c607944bc657616 ("ARM: smp: Add initialization of CNTVOFF")
Fixes: cad160ed0a94927e ("ARM: shmobile: Convert file to use cntvoff")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/common/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 1e9f7af8f70ff6ba..923a8d08be679399 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -3,14 +3,13 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				+= firmware.o
+obj-y				+= firmware.o secure_cntvoff.o
 
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
-obj-$(CONFIG_SMP)		+= secure_cntvoff.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
-- 
2.7.4
