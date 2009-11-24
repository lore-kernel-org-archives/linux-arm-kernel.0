From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 13:55:33 +0000
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
In-Reply-To: <f2235a630911240535u4c75914buad3cb1239d5bb598@mail.gmail.com>
References: <1259014663.2742.3.camel@vinay-desktop>
	<f2235a630911240411x67ad7e05k218b32e8d732dd0c@mail.gmail.com>
	<1259022908.2742.9.camel@vinay-desktop>
	<f2235a630911240535u4c75914buad3cb1239d5bb598@mail.gmail.com>
Message-ID: <1259070933.16239.7.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 13:35 +0000, Surinder P Singh wrote:
> On Tue, Nov 24, 2009 at 6:05 AM, srinidhi kasagar
> <srinidhi.kasagar@stericsson.com> wrote:
> 
> >> 2 points:
> >>
> >> 1. Since this code is also valid for devices based on pre-ARMv6, maybe
> >> making this code conditional for >=ARMv6 would be cleaner ?
> > rather it depends on l2 controller being used. L210 controllers
> > do not have such restrictions whereas l220/pl310 have such kind
> > of secure/non-secure restrictions. So would it be better to keep
> > condition based on l2 controller being used?
> >
> 
> Thats probably better. You can read the L2 cache ID register to figure
> out if its a L210/220 or PL310 and so on. You can couple this check
> with the cpu secure/non-secure state before deciding to write to the
> registers.

I don't think it's worth the hassle. Just always check whether it is
already enabled without additional ifdefs. IIRC, L210 is used on
RealView PB1176 (not entirely sure).

I had a similar patch in my tree but haven't pushed it because it
required an additional fix for SMP platforms. Basically the secondary
CPUs use uncached accesses and the primary one would need to flush the
outer cache as well during the booting protocol. The platform init
function (e.g. realview_eb_init) was called too late in the process, so
I had to move the L2 initialisation to an early_init call. See below for
the RealView patch, something similar may be needed for other SMP
platforms:


RealView: Initialise the L2 cache via early_initcall

From: Catalin Marinas <catalin.marinas@arm.com>

This is required on SMP systems where the L2 cache is already enabled
when the kernel is started (e.g. in non-secure mode) and
boot_secondary() needs to call outer_clean_range().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/platsmp.c         |    3 +++
 arch/arm/mach-realview/realview_eb.c     |   24 ++++++++++++++++--------
 arch/arm/mach-realview/realview_pb11mp.c |   22 ++++++++++++++++------
 arch/arm/mach-realview/realview_pbx.c    |   15 ++++++++++-----
 4 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index bf42167..ff59e75 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -127,8 +127,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Note that "pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
+	flush_cache_all();
+	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 	pen_release = cpu;
 	flush_cache_all();
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
 
 	/*
 	 * XXX
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index c20fbef..fee0adc 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -364,20 +364,28 @@ static struct sys_timer realview_eb_timer = {
 	.init		= realview_eb_timer_init,
 };
 
+#ifdef CONFIG_CACHE_L2X0
+static int __init realview_eb_l2x0_init(void)
+{
+	if (machine_is_realview_eb_mp())
+		/*
+		 * 1MB (128KB/way), 8-way associativity, evmon/parity/share
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE),
+			  0x00790000, 0xfe000fff);
+	return 0;
+}
+early_initcall(realview_eb_l2x0_init);
+#endif
+
 static void __init realview_eb_init(void)
 {
 	int i;
 
-	if (core_tile_eb11mp() || core_tile_a9mp()) {
+	if (core_tile_eb11mp() || core_tile_a9mp())
 		realview_eb11mp_fixup();
 
-#ifdef CONFIG_CACHE_L2X0
-		/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
-		 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
-		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
-#endif
-	}
-
 	realview_flash_register(&realview_eb_flash_resource, 1);
 	platform_device_register(&realview_i2c_device);
 	eth_device_register();
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index ea1e60e..75b3ecf 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -282,16 +282,26 @@ static struct sys_timer realview_pb11mp_timer = {
 	.init		= realview_pb11mp_timer_init,
 };
 
+#ifdef CONFIG_CACHE_L2X0
+static int __init realview_pb11mp_l2x0_init(void)
+{
+	if (machine_is_realview_pb11mp()) {
+		/*
+		 * 1MB (128KB/way), 8-way associativity, evmon/parity/share
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE),
+			  0x00790000, 0xfe000fff);
+	}
+	return 0;
+}
+early_initcall(realview_pb11mp_l2x0_init);
+#endif
+
 static void __init realview_pb11mp_init(void)
 {
 	int i;
 
-#ifdef CONFIG_CACHE_L2X0
-	/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
-	 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
-	l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE), 0x00790000, 0xfe000fff);
-#endif
-
 	realview_flash_register(realview_pb11mp_flash_resource,
 				ARRAY_SIZE(realview_pb11mp_flash_resource));
 	realview_eth_register(NULL, realview_pb11mp_smsc911x_resources);
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index e9d461f..0241ee1 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -289,12 +289,10 @@ static struct sys_timer realview_pbx_timer = {
 	.init		= realview_pbx_timer_init,
 };
 
-static void __init realview_pbx_init(void)
-{
-	int i;
-
 #ifdef CONFIG_CACHE_L2X0
-	if (core_tile_pbxa9mp()) {
+static int __init realview_pbx_l2x0_init(void)
+{
+	if (machine_is_realview_pbx() && core_tile_pbxa9mp()) {
 		void __iomem *l2x0_base =
 			__io_address(REALVIEW_PBX_TILE_L220_BASE);
 
@@ -306,8 +304,15 @@ static void __init realview_pbx_init(void)
 		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... .... */
 		l2x0_init(l2x0_base, 0x02520000, 0xc0000fff);
 	}
+	return 0;
+}
+early_initcall(realview_pbx_l2x0_init);
 #endif
 
+static void __init realview_pbx_init(void)
+{
+	int i;
+
 	realview_flash_register(realview_pbx_flash_resources,
 				ARRAY_SIZE(realview_pbx_flash_resources));
 	realview_eth_register(NULL, realview_pbx_smsc911x_resources);


-- 
Catalin
