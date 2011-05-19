From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 May 2011 09:24:48 +0900
Subject: [PATCH] ARM: Enable GIC support when TWD is selected
Message-ID: <20110519002448.357.5477.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The TWD code in smp_twd.c has been calling gic_enable_ppi()
since ac61d143ffe2a6db4d4bcf47c21a5159d6a1b644.

Without this fix kernel configs with CONFIG_HAVE_ARM_TWD=y
and CONFIG_ARM_GIC=n results in the following build error:

arch/arm/kernel/built-in.o: In function `twd_timer_setup':
io.c:(.cpuinit.text+0x580): undefined reference to `gic_enable_ppi'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Or perhaps mach-shmobile should always select ARM_GIC even
 though some SoC parts do not include GIC hardware?

 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2011-05-03 10:40:26.000000000 +0900
@@ -1368,6 +1368,7 @@ config HAVE_ARM_TWD
 	bool
 	depends on SMP
 	select TICK_ONESHOT
+	select ARM_GIC
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
