From: sguinot@lacie.com (Simon Guinot)
Date: Tue,  9 Feb 2010 21:20:55 +0100
Subject: [PATCH 1/2] [ARM] Kirkwood: add LaCie Internet Space v2 support
Message-ID: <1265746856-21930-1-git-send-email-sguinot@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Internet and Network Space v2 boards are very close. The only
difference is that there is no USB type B plug wired on the Internet
Space v2.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/Kconfig             |    6 ++++++
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   15 +++++++++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 4ac6f46..edc9aeb 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -69,6 +69,12 @@ config MACH_NETSPACE_V2
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Network Space v2 NAS.
 
+config MACH_INETSPACE_V2
+	bool "LaCie Internet Space v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Internet Space v2 NAS.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index df91d07..55b4ccf 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o
+obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index 9a06406..df1a99d 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -314,6 +314,7 @@ static void __init netspace_v2_init(void)
 		pr_err("netspace_v2: failed to configure power-off GPIO\n");
 }
 
+#ifdef CONFIG_MACH_NETSPACE_V2
 MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
 	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
@@ -323,3 +324,17 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &netspace_v2_timer,
 MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_INETSPACE_V2
+MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= netspace_v2_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &netspace_v2_timer,
+MACHINE_END
+#endif
+
-- 
1.6.3.1
