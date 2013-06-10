From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:28:57 +0900
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
Message-ID: <20130610092857.19175.25629.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This is V2 of the mach-shmobile uImage load address rework patch.

Rework the mach-shmobile uImage load address calculation by storing
the per-board load addresses in Makefile.boot. This removes the
CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
it possible to create safe kernel images that boot on multiple boards.

This is one of several series of code that reworks code not to rely on
CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

 Changes since V1:
 - On popular request, merged patch 5 and 14 and all other.
 - Updated the __ZRELADDR calculation, thanks Arnd!
 - Added Reviewed-by from Laurent and Morimoto-san, thanks!

 arch/arm/mach-shmobile/Makefile.boot |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-10 16:15:22.000000000 +0900
@@ -1,6 +1,22 @@
-__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
+# per-board load address for uImage
+loadaddr-y	:=
+loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
+loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
+loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
+loadaddr-$(CONFIG_MACH_BONITO) += 0x40008000
+loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
+loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
+loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
+loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
+loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
+loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
 
+__ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
 
 # Unsupported legacy stuff
