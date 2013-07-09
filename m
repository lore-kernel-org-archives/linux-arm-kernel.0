From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 14:43:41 +0900
Subject: [PATCH 01/04] ARM: shmobile: Only build clocks when COMMON_CLK=n
In-Reply-To: <20130709054331.14007.66068.sendpatchset@w520>
References: <20130709054331.14007.66068.sendpatchset@w520>
Message-ID: <20130709054341.14007.99736.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move shared clock.c file and per-SoC clock-xxx.c files
to only build when CONFIG_COMMON_CLK != y.

The regular ARCH_SHMOBILE case with legacy SH clock framework
will build just as before with this patch applied, however
the case when COMMON_CLK=y will exclude all the clock files.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-09 12:21:29.000000000 +0900
@@ -3,17 +3,28 @@
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
+clk-y				:= clock.o
+clk-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
+clk-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
+clk-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
+clk-$(CONFIG_ARCH_R8A7740)	+= clock-r8a7740.o
+clk-$(CONFIG_ARCH_R8A7778)	+= clock-r8a7778.o
+clk-$(CONFIG_ARCH_R8A7779)	+= clock-r8a7779.o
+clk-$(CONFIG_ARCH_R8A7790)	+= clock-r8a7790.o
+clk-$(CONFIG_ARCH_EMEV2)	+= clock-emev2.o
 
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
@@ -53,3 +64,4 @@ obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= bo
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
+obj-y				+= $(clk-y$(CONFIG_COMMON_CLK))
