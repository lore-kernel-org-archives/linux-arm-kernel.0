From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 16:40:31 +0200
Subject: [PATCH v3] ARM: default machine descriptor for multiplatform
In-Reply-To: <201304191621.54681.arnd@arndb.de>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <20130419132848.GO14496@n2100.arm.linux.org.uk>
 <201304191621.54681.arnd@arndb.de>
Message-ID: <201304191640.32139.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now have default implementations for init_time and init_irq,
the init_machine callback is the only one that is not yet optional,
but since simple DT based platforms all have the same
of_platform_populate function call in there, we can consolidate them
as well, and then actually boot with a completely empty machine_desc.
Unofortunately we cannot just default to an empty init_machine: We
cannot call of_platform_populate before init_machine because that
does not work in case of auxdata, and we cannot call it after
init_machine either because the machine might need to run code
after adding the devices.

To take the final step, this adds support for booting without defining
any machine_desc whatsoever.

For the case that CONFIG_MULTIPLATFORM is enabled, it adds a
global machine descriptor that never matches any machine but is
used as a fallback if nothing else matches. We assume that without
CONFIG_MULTIPLATFORM, we only want to boot on the systems that the kernel
is built for, so we still retain the build-time warning for missing
machine descriptors and the run-time warning when the platform does not
match in that case.

In the case that we run on a multiplatform kernel and the machine
provides a fully populated device tree, we attempt to keep booting,
hoping that no machine specific callbacks are necessary.

Finally, this also removes the misguided "select ARCH_VEXPRESS" that
was only added to avoid a build error for allnoconfig kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Cc: Rob Herring <robherring2@gmail.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1cacda4..e67d49d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1014,7 +1014,6 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select ARCH_VEXPRESS
 	select CPU_V7
 
 config ARCH_MULTI_V6_V7
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 70f1bde..9038c9f 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -180,6 +180,13 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	unsigned long dt_root;
 	const char *model;
 
+	if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
+		DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
+		MACHINE_END
+
+		mdesc_best = (struct machine_desc *)&__mach_desc_GENERIC_DT;
+	}
+
 	if (!dt_phys)
 		return NULL;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d343a6c..9e0f43d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
+#include <linux/of_platform.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
@@ -660,9 +661,17 @@ struct screen_info screen_info = {
 
 static int __init customize_machine(void)
 {
-	/* customizes platform devices, or adds new ones */
+	/*
+	 * customizes platform devices, or adds new ones
+	 * On DT based machines, we fall back to populating the
+	 * machine from the device tree, if no callback is provided,
+	 * otherwise we would always need an init_machine callback.
+	 */
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
+	else
+		of_platform_populate(NULL, of_default_bus_match_table,
+					NULL, NULL);
 	return 0;
 }
 arch_initcall(customize_machine);
