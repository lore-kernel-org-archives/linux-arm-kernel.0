From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:49 +0000
Subject: [RFC v2 PATCH 07/23] ARM: NOMMU: fix head-nommu build for pre-ARMv7
 CPUs
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for pre-ARMv7 CPUs with ARM_MPU enabled following error
shows up:

  AS      arch/arm/kernel/head-nommu.o
arch/arm/kernel/head-nommu.S: Assembler messages:
arch/arm/kernel/head-nommu.S:223: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:231: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:235: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:244: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:248: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:258: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:265: Error: selected processor does not support ARM mode `isb'
make[1]: *** [arch/arm/kernel/head-nommu.o] Error 1

MPU setup code is available for ARMv7 only, but head-nommu.S is
generic, so build head-nommu.S with -march=armv7-a (and armv7-m for
M-calss to avoid "Conflicting architecture profiles M/A" link time)
flag; in case pre-ARMv7 it detects there there is no MPU is avaliable,
so it will never reach those instructions.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8..6da8b04 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -84,6 +84,11 @@ endif
 obj-$(CONFIG_PARAVIRT)	+= paravirt.o
 
 head-y			:= head$(MMUEXT).o
+ifeq ($(CONFIG_CPU_V7M),y)
+AFLAGS_head-nommu.o     :=-Wa,-march=armv7-m
+else
+AFLAGS_head-nommu.o     :=-Wa,-march=armv7-a
+endif
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
-- 
1.7.9.5
