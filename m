From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 2 Nov 2015 16:19:37 +0100
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <56377E76.2080209@sigmadesigns.com>
References: <56377E76.2080209@sigmadesigns.com>
Message-ID: <56377F09.6050805@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Sigma Designs ARM-based Tango4 "Secure Media Processor"
platforms (i.e. smp8734, smp8756, smp8758, smp8759) built around the
Cortex-A9 MPCore r3p0 (dual-core SoCs, except the 8756).

Support for older MIPS-based platforms can be found elsewhere:
https://github.com/mansr/linux-tangox

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/Kconfig              |  2 ++
 arch/arm/Makefile             |  1 +
 arch/arm/mach-tangox/Kconfig  | 12 ++++++++++++
 arch/arm/mach-tangox/Makefile |  2 ++
 arch/arm/mach-tangox/setup.c  | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tangox/smc.S    |  9 +++++++++
 arch/arm/mach-tangox/smc.h    |  5 +++++
 7 files changed, 63 insertions(+)
 create mode 100644 arch/arm/mach-tangox/Kconfig
 create mode 100644 arch/arm/mach-tangox/Makefile
 create mode 100644 arch/arm/mach-tangox/setup.c
 create mode 100644 arch/arm/mach-tangox/smc.S
 create mode 100644 arch/arm/mach-tangox/smc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 774dc59650c5..d8f0c31f521f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -934,6 +934,8 @@ source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-prima2/Kconfig"
 
+source "arch/arm/mach-tangox/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7451b447cc2d..7fcb4c63cdf7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -203,6 +203,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_TANGOX)		+= tangox
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..cf814d7336f3
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,12 @@
+config ARCH_TANGOX
+	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
+	# Cortex-A9 MPCore r3p0, PL310 r3p2
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_775420
+	select ARM_GIC
+	select CLKSRC_TANGO_XTAL
+	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
diff --git a/arch/arm/mach-tangox/Makefile b/arch/arm/mach-tangox/Makefile
new file mode 100644
index 000000000000..0d7e2b5976e3
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile
@@ -0,0 +1,2 @@
+asflags-y += -mcpu=cortex-a9
+obj-y += setup.o smc.o
diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
new file mode 100644
index 000000000000..a90e04140a0e
--- /dev/null
+++ b/arch/arm/mach-tangox/setup.c
@@ -0,0 +1,32 @@
+#include <linux/smp.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "smc.h"
+
+static int tango4_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
+	tango_start_aux_core();
+	return 0;
+}
+
+static struct smp_operations tango4_smp_ops __initdata = {
+	.smp_boot_secondary	= tango4_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango4_smp_ops);
+
+static void tango_l2c_write(unsigned long val, unsigned int reg)
+{
+	pr_debug("%s: reg=0x%x val=0x%lx\n", __func__, reg, val);
+	if (reg == L2X0_CTRL)
+		tango_set_l2_control(val);
+}
+
+static const char *tango_dt_compat[] = { "sigma,tango4", NULL };
+
+DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
+	.dt_compat	= tango_dt_compat,
+	.l2c_aux_mask	= ~0,
+	.l2c_write_sec	= tango_l2c_write,
+MACHINE_END
diff --git a/arch/arm/mach-tangox/smc.S b/arch/arm/mach-tangox/smc.S
new file mode 100644
index 000000000000..35f9623aedb1
--- /dev/null
+++ b/arch/arm/mach-tangox/smc.S
@@ -0,0 +1,9 @@
+#include <linux/linkage.h>
+
+ENTRY(tango_smc)
+	push	{lr}
+	mov	ip, r1
+	dsb
+	smc	#0
+	pop	{pc}
+ENDPROC(tango_smc)
diff --git a/arch/arm/mach-tangox/smc.h b/arch/arm/mach-tangox/smc.h
new file mode 100644
index 000000000000..4e704dcf8da8
--- /dev/null
+++ b/arch/arm/mach-tangox/smc.h
@@ -0,0 +1,5 @@
+extern int tango_smc(unsigned int val, unsigned int service);
+
+#define tango_set_l2_control(val)	tango_smc(val, 0x102)
+#define tango_start_aux_core()		tango_smc(666, 0x104)
+#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
-- 
2.4.5
