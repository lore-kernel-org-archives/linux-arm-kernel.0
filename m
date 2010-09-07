From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 17:05:19 +0530
Subject: [PATCH 07/74] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <20100902162744.GC28968@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b2e8b6b95ceff7d90032be8cd614787519b5c57c.1283161023.git.viresh.kumar@st.com>
	<20100902162744.GC28968@game.jcrosoft.org>
Message-ID: <4C862377.1080507@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 9:57 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 9295110..950c045 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -1144,11 +1144,13 @@ config SMP
>> >  	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
>> >  	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
>> >  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
>> > -		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
>> > +		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
>> > +		 ARCH_VEXPRESS_CA9X4)
> can we get rid of such long list by introducing a HAVE somthing
> etc....


I tried to do this, but have some doubts. With this change architectures
can not disable features selected using select statement.
So, if i want image without SMP for SPEAr13xx now, i can't do it.


Please correct me if this is not the right way of doing it.

regards,
viresh.
--------------------------------------

[PATCH] arch/arm/Kconfig: removing arch/machine dependencies from SMP, LOCAL_TIMERS, HAVE_ARM_SCU AND HAVE_ARM_TWD

Individual architectures/machines should select SMP, LOCAL_TIMERS, HAVE_ARM_SCU
AND HAVE_ARM_TWD from there config options

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig               |   30 +++++++++++++++++-------------
 arch/arm/mach-omap2/Kconfig    |    4 ++++
 arch/arm/mach-realview/Kconfig |    8 ++++++++
 arch/arm/mach-vexpress/Kconfig |    3 +++
 arch/arm/plat-spear/Kconfig    |    4 ++++
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f6ec629..4617efa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -238,6 +238,8 @@ config ARCH_REALVIEW
 	select PLAT_VERSATILE
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	help
 	  This enables support for ARM Ltd RealView boards.
 
@@ -261,6 +263,7 @@ config ARCH_VEXPRESS
 	select ARM_TIMER_SP804
 	select COMMON_CLKDEV
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_CLK
 	select ICST
 	select PLAT_VERSATILE
@@ -566,6 +569,10 @@ config ARCH_TEGRA
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
@@ -733,6 +740,10 @@ config ARCH_S5PV310
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select GENERIC_CLOCKEVENTS
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	help
 	  Samsung S5PV310 series based systems
 
@@ -779,6 +790,10 @@ config ARCH_U8500
 	select GENERIC_CLOCKEVENTS
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -1146,15 +1161,9 @@ source "kernel/time/Kconfig"
 
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
-		 ARCH_VEXPRESS_CA9X4)
+	depends on EXPERIMENTAL
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 ||\
-		 ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
-		 ARCH_VEXPRESS_CA9X4
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1222,13 +1231,8 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
-		ARCH_VEXPRESS_CA9X4)
+	depends on SMP
 	default y
-	select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 || \
-		ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..674bb71 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -43,6 +43,10 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b4575ae..30a06ff 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -11,6 +11,8 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select SMP
+	select LOCAL_TIMERS
 	help
 	  Enable support for the Cortex-A9MPCore tile on the Realview platform.
 
@@ -18,6 +20,8 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select SMP
+	select LOCAL_TIMERS
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
@@ -36,6 +40,8 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select SMP
+	select LOCAL_TIMERS
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
@@ -73,6 +79,8 @@ config MACH_REALVIEW_PBX
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
+	select SMP
+	select LOCAL_TIMERS
 	select ZONE_DMA if SPARSEMEM
 	help
 	  Include support for the ARM(R) RealView PBX platform.
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 3f19b66..8475646 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,5 +5,8 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
 
 endmenu
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index b8e4988..18e2229 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -13,6 +13,10 @@ config ARCH_SPEAR13XX
 	select ARM_GIC
 	select CPU_V7
 	select ARCH_SUPPORTS_MSI
+	select SMP
+	select HAVE_ARM_SCU if SMP
+	select LOCAL_TIMERS
+	select HAVE_ARM_TWD if LOCAL_TIMERS
 	help
 	  Supports for ARM's SPEAR13XX family
