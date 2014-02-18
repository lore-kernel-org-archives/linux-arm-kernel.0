From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 18 Feb 2014 18:34:57 +0100
Subject: [PATCH] arm: socfpga: reserve the region at start of phys mem
Message-ID: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMP bringup code copies trampline code to the physical location 0x0.
If somebody allocated memory from this location then it will be
overwritten.
This patch reserves the few bytes so that it won't be used by the memory
allocator.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-socfpga/socfpga.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index a9050e6..2ba992a 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -26,6 +26,7 @@
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
 #include <linux/sys_soc.h>
+#include <linux/memblock.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
@@ -315,6 +316,17 @@ static void __init socfpga_cyclone5_init(void)
 	socfpga_soc_device_init();
 }
 
+static void __init socfmpga_smp_reserve(void)
+{
+#ifdef CONFIG_SMP
+	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int ret;
+
+	ret = memblock_reserve(0, trampoline_size);
+	WARN_ON(ret);
+#endif
+}
+
 static const char *altera_dt_match[] = {
 	"altr,socfpga",
 	NULL
@@ -327,4 +339,5 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
+	.reserve	= socfmpga_smp_reserve,
 MACHINE_END
-- 
1.9.0.rc3
