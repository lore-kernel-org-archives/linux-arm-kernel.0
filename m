From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:22:16 +0100
Subject: [PATCH] ARM: fix ARMv4+Feroceon multiplatform build
Message-ID: <1811247.REIIfdW143@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The feroceon copypage implementation cannot be built when targetting an
ARMv4 CPU, so we need to pass the march=armv5te flag manually to gcc
when building this file. This is obviously safe since that code will
not be executed on ARMv4.

/tmp/ccEtc0pF.s: Assembler messages:
/tmp/ccEtc0pF.s:59: Error: selected processor does not support ARM mode `pld [lr,#32]'
/tmp/ccEtc0pF.s:60: Error: selected processor does not support ARM mode `pld [lr,#64]'
/tmp/ccEtc0pF.s:61: Error: selected processor does not support ARM mode `pld [lr,#96]'
/tmp/ccEtc0pF.s:62: Error: selected processor does not support ARM mode `pld [lr,#128]'
/tmp/ccEtc0pF.s:63: Error: selected processor does not support ARM mode `pld [lr,#160]'
/tmp/ccEtc0pF.s:64: Error: selected processor does not support ARM mode `pld [lr,#192]'
/tmp/ccEtc0pF.s:65: Error: selected processor does not support ARM mode `pld [lr,#224]'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index d3afdf9eb65a..39a44bb84edf 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -55,6 +55,8 @@ obj-$(CONFIG_CPU_XSCALE)	+= copypage-xscale.o
 obj-$(CONFIG_CPU_XSC3)		+= copypage-xsc3.o
 obj-$(CONFIG_CPU_COPY_FA)	+= copypage-fa.o
 
+CFLAGS_copypage-feroceon.o := -march=armv5te
+
 obj-$(CONFIG_CPU_TLB_V4WT)	+= tlb-v4.o
 obj-$(CONFIG_CPU_TLB_V4WB)	+= tlb-v4wb.o
 obj-$(CONFIG_CPU_TLB_V4WBI)	+= tlb-v4wbi.o
