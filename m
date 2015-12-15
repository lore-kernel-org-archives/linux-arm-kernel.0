From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 15 Dec 2015 10:41:13 +0100
Subject: [PATCH v11 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <566FDF53.3030004@sigmadesigns.com>
References: <566FDF53.3030004@sigmadesigns.com>
Message-ID: <566FE039.3020302@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Sigma Designs ARM-based (specifically, Cortex-A9 MPCore r3p0)
Tango4 "Secure Media Processor" platforms: smp8756, smp8758, smp8759
(8756 is single-core, the latter are dual-core).

Note: 8758 vs 8759: same chip, different package.

Support for older MIPS-based platforms can be found elsewhere:
https://github.com/mansr/linux-tangox

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 MAINTAINERS                  |  7 +++++++
 arch/arm/Kconfig             |  2 ++
 arch/arm/Makefile            |  1 +
 arch/arm/mach-tango/Kconfig  | 12 ++++++++++++
 arch/arm/mach-tango/Makefile |  2 ++
 arch/arm/mach-tango/setup.c  | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-tango/smc.S    |  9 +++++++++
 arch/arm/mach-tango/smc.h    |  5 +++++
 8 files changed, 69 insertions(+)
 create mode 100644 arch/arm/mach-tango/Kconfig
 create mode 100644 arch/arm/mach-tango/Makefile
 create mode 100644 arch/arm/mach-tango/setup.c
 create mode 100644 arch/arm/mach-tango/smc.S
 create mode 100644 arch/arm/mach-tango/smc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd2953678..3869a8053b82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1494,6 +1494,13 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/ata/ahci_st.c
 
+ARM/TANGO ARCHITECTURE
+M:	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	arch/arm/mach-tango/
+F:	arch/arm/boot/dts/tango*
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5c236f60e235..98cf131d9e08 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -934,6 +934,8 @@ source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-prima2/Kconfig"
 
+source "arch/arm/mach-tango/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47f10e7ad1f6..e85717823d38 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -205,6 +205,7 @@ machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_TANGO)		+= tango
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-tango/Kconfig b/arch/arm/mach-tango/Kconfig
new file mode 100644
index 000000000000..d6a3714b096e
--- /dev/null
+++ b/arch/arm/mach-tango/Kconfig
@@ -0,0 +1,12 @@
+config ARCH_TANGO
+	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
+	# Cortex-A9 MPCore r3p0, PL310 r3p2
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_775420
+	select ARM_GIC
+	select CLKSRC_TANGO_XTAL
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select TANGO_IRQ
diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
new file mode 100644
index 000000000000..0d7e2b5976e3
--- /dev/null
+++ b/arch/arm/mach-tango/Makefile
@@ -0,0 +1,2 @@
+asflags-y += -mcpu=cortex-a9
+obj-y += setup.o smc.o
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
new file mode 100644
index 000000000000..d86900550e63
--- /dev/null
+++ b/arch/arm/mach-tango/setup.c
@@ -0,0 +1,31 @@
+#include <linux/smp.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "smc.h"
+
+static int tango4_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
+	tango_start_aux_core(cpu);
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
+	if (reg == L2X0_CTRL)
+		tango_set_l2_control(val);
+}
+
+static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
+
+DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
+	.dt_compat	= tango_dt_compat,
+	.l2c_aux_mask	= ~0,
+	.l2c_write_sec	= tango_l2c_write,
+MACHINE_END
diff --git a/arch/arm/mach-tango/smc.S b/arch/arm/mach-tango/smc.S
new file mode 100644
index 000000000000..5d932ce3c1bd
--- /dev/null
+++ b/arch/arm/mach-tango/smc.S
@@ -0,0 +1,9 @@
+#include <linux/linkage.h>
+
+ENTRY(tango_smc)
+	push	{lr}
+	mov	ip, r1
+	dsb	/* This barrier is probably unnecessary */
+	smc	#0
+	pop	{pc}
+ENDPROC(tango_smc)
diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
new file mode 100644
index 000000000000..7a4af35cc390
--- /dev/null
+++ b/arch/arm/mach-tango/smc.h
@@ -0,0 +1,5 @@
+extern int tango_smc(unsigned int val, unsigned int service);
+
+#define tango_set_l2_control(val)	tango_smc(val, 0x102)
+#define tango_start_aux_core(val)	tango_smc(val, 0x104)
+#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
-- 
2.6.3
