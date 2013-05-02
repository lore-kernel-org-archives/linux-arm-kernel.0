From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:51 +0200
Subject: [PATCH 2/9] ARM: OMAP: build SMP code only for OMAP4/5
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP platform code assumes that SMP is only ever enabled when
CONFIG_ARCH_OMAP4 or CONFIG_SOC_OMAP5 is enabled, which is not
necessarirly true in a multiplatform configuration.

arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
 :(.init.text+0x413c): undefined reference to `omap_get_wakeupgen_base'
 :(.init.text+0x415c): undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
 :(.cpuinit.text+0x28): undefined reference to `omap_get_wakeupgen_base'
 :(.cpuinit.text+0x3c): undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
 :(.ref.text+0x8): undefined reference to `omap_get_wakeupgen_base'
 :(.ref.text+0x10): undefined reference to `omap_secure_apis_support'
 :(.ref.text+0x4c): undefined reference to `omap4_hotplug_cpu'
 :(.ref.text+0x50): undefined reference to `omap_secure_apis_support'

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e50b6da..f2d19af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -32,12 +32,12 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # SMP support ONLY available for OMAP4
 
-obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
+smp-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
+smp-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
 					   sleep44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
-obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common)
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common) $(smp-y)
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y)
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
-- 
1.8.1.2
