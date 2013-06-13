From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 15:59:39 +0900
Subject: [PATCH 01/15] ARM: shmobile: uImage load address rework
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106793-25071-2-git-send-email-horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile.boot | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 498efd9..6b147ea 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
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
-- 
1.8.2.1
