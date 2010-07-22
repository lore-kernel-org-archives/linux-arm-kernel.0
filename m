From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 22 Jul 2010 18:22:47 +0900
Subject: [PATCH v4 1/7] ARM: S5PV210: Allow to probe whether workaround codes
	are required.
In-Reply-To: <1279790573-24179-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279790573-24179-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279790573-24179-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early products of S5PV210 had several errata that require kernel to
avoid using some parts/instructions of the CPU or to add protection
instructions. There are products with such early production CPUs;
thus, we want to distinguish them in kernel. This patch is to
distinguish such products.

Include <mach/hardware.h> and call s5pv210_workaround()

For example,

	if (s5pv210_workaround()) {
		... execute workaround code ...
	} else {
		... execute normal code ...
	}

Where we can identify whether such workaround codes are required or not,
call set_s5pv210_workaround_required() is it's needed. Note that in this
system, it can be identified at board support file
(arch/arm/mach-s5pv210/mach-*.c), not at the cpe file
(arch/arm/mach-s5pv210/cpu.c). It is because we cannot determine based
on the CPU_ID or PRODUCT_ID only; board revision number is required to
determine.

For Aquila machine. (mach-aquila.c)

Part of Aquila machines have the early production CPUs that require
to address errata issues. Note that we don't do this for GONI machines
because they have never used early production CPUs with errata. Besides,
please note that there are other boards that use such early produces
other than Aquila. However, those boards/machines are not registered at
the /linux/arch/arm/tools/mach-types, yet; thus, we have omitted them
in this patch.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/cpu.c                   |   33 +++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/hardware.h |    3 +-
 arch/arm/mach-s5pv210/mach-aquila.c           |    4 +++
 3 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 94c632b..b9fe38e 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <asm/mach-types.h>
 #include <asm/proc-fns.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
@@ -128,6 +129,38 @@ static struct sys_device s5pv210_sysdev = {
 	.cls	= &s5pv210_sysclass,
 };
 
+/* See if workaround to avoid errata of earlier revisions */
+static bool s5pv210_workaround_required;
+
+bool s5pv210_workaround(void)
+{
+	return s5pv210_workaround_required;
+}
+
+void set_s5pv210_workaround(unsigned int board_rev)
+{
+	s5pv210_workaround_required = false;
+
+	if (machine_is_aquila()) {
+		if (board_rev & 0x0800) {
+			if ((board_rev & 0xF) < 8)
+				s5pv210_workaround_required = true;
+		} else if (board_rev & 0x2000) {
+			s5pv210_workaround_required = true;
+		}
+	}
+
+	/*
+	 * When machine_is_goni(), always false
+	 *
+	 * When machine_arch_number is 3260 and board_rev&0xF is 5,
+	 *      always true. But, omitted as it's not registered at
+	 *      mach_types, yet.
+	 * When machine_arch_number is 3104 and board_rev&0xF is 0,
+	 *      always true, as well. Omitted by the same reason.
+	 */
+}
+
 static int __init s5pv210_core_init(void)
 {
 	return sysdev_class_register(&s5pv210_sysclass);
diff --git a/arch/arm/mach-s5pv210/include/mach/hardware.h b/arch/arm/mach-s5pv210/include/mach/hardware.h
index fada7a3..0c41852 100644
--- a/arch/arm/mach-s5pv210/include/mach/hardware.h
+++ b/arch/arm/mach-s5pv210/include/mach/hardware.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H __FILE__
 
-/* currently nothing here, placeholder */
+extern bool s5pv210_workaround(void);
+extern void set_s5pv210_workaround(unsigned int);
 
 #endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 46d5c7e..85024af 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -30,6 +30,7 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-fb.h>
 #include <mach/gpio.h>
+#include <mach/hardware.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
@@ -536,6 +537,9 @@ static void __init aquila_map_io(void)
 
 static void __init aquila_machine_init(void)
 {
+	/* Determine whether we need workaround codes */
+	set_s5pv210_workaround(system_rev);
+
 	/* PMIC */
 	aquila_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
-- 
1.6.3.3
