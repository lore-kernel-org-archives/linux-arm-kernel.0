From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 14:24:11 +0900
Subject: [PATCH 1/4] ARM: shmobile: Only build clocks when COMMON_CLK=n
In-Reply-To: <cover.1375161473.git.horms+renesas@verge.net.au>
References: <cover.1375161473.git.horms+renesas@verge.net.au>
Message-ID: <a360feb9e9e6cc36d61e683c03dc13974663298b.1375161473.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move shared clock.c file and per-SoC clock-xxx.c files
to only build when CONFIG_COMMON_CLK != y.

The regular ARCH_SHMOBILE case with legacy SH clock framework
will build just as before with this patch applied, however
the case when COMMON_CLK=y will exclude all the clock files.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e8d0a2c..5884bea 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,17 +3,30 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o
+obj-y				:= timer.o console.o
 
 # CPU objects
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
-obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o clock-r8a73a4.o
-obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
-obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o clock-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o clock-r8a7790.o
-obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
+obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
+obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o intc-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
+obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o intc-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
+obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
+
+# Clock objects
+ifndef CONFIG_COMMON_CLK
+obj-y				+= clock.o
+obj-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
+obj-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
+obj-$(CONFIG_ARCH_R8A7740)	+= clock-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7778)	+= clock-r8a7778.o
+obj-$(CONFIG_ARCH_R8A7779)	+= clock-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7790)	+= clock-r8a7790.o
+obj-$(CONFIG_ARCH_EMEV2)	+= clock-emev2.o
+endif
 
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
-- 
1.8.3.2
