From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Sep 2011 11:56:03 +0100
Subject: [RFC PATCH v3 1/3] ARM: SoC: Introduce per SoC descriptor
In-Reply-To: <1315824965-8485-1-git-send-email-marc.zyngier@arm.com>
References: <1315824965-8485-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1315824965-8485-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM core code expects the various SoCs to hide their
implementation differences behind a well established API.
The various sub-arch-specific bit are often either at
the machine descriptor level, or provided at link time
by the sub-arch code.

The SoC descriptor is a container that holds the SoC
specific bits that can be moved away from the machine
descriptor as well as an indirection point for the
global symbols (SMP and CPU hotplug support, for example).

This patch introduce this SoC descriptor, with the only field
being the name of the SoC.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/mach/arch.h |    2 ++
 arch/arm/include/asm/soc.h       |   21 +++++++++++++++++++++
 arch/arm/kernel/setup.c          |    9 +++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 727da11..82883ca 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -13,6 +13,7 @@
 struct tag;
 struct meminfo;
 struct sys_timer;
+struct arm_soc_desc;
 
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
@@ -34,6 +35,7 @@ struct machine_desc {
 	unsigned int		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned int		reserve_lp2 :1;	/* never has lp2	*/
 	unsigned int		soft_reboot :1;	/* soft reboot		*/
+	struct arm_soc_desc	*soc;		/* SoC descriptor	*/
 	void			(*fixup)(struct machine_desc *,
 					 struct tag *, char **,
 					 struct meminfo *);
diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
new file mode 100644
index 0000000..ce92784
--- /dev/null
+++ b/arch/arm/include/asm/soc.h
@@ -0,0 +1,21 @@
+/*
+ *  linux/arch/arm/include/asm/soc.h
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_SOC_H
+#define __ASM_ARM_SOC_H
+
+struct arm_soc_desc {
+	const char		*name;
+};
+
+extern const struct arm_soc_desc	*soc_desc;
+
+#endif	/* __ASM_ARM_SOC_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 192a24f..6bfa5f6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
 #include <asm/system.h>
+#include <asm/soc.h>
 
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
@@ -140,6 +141,8 @@ static const char *cpu_name;
 static const char *machine_name;
 static char __initdata cmd_line[COMMAND_LINE_SIZE];
 struct machine_desc *machine_desc __initdata;
+const struct arm_soc_desc *soc_desc;
+static struct arm_soc_desc __soc_desc __read_mostly;
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -909,6 +912,12 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	if (mdesc->soc) {
+		__soc_desc = *mdesc->soc;
+		soc_desc = &__soc_desc;
+		pr_info("SoC: %s\n", soc_desc->name);
+	} else
+		soc_desc = NULL;
 
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
-- 
1.7.0.4
