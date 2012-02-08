From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:45 +0000
Subject: [PATCH v6 01/15] ARM: SoC: Introduce per SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-2-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/include/asm/soc.h       |   19 +++++++++++++++++++
 arch/arm/kernel/setup.c          |    7 +++++++
 3 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index d7692ca..cf7ef91 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -14,6 +14,7 @@ struct tag;
 struct meminfo;
 struct sys_timer;
 struct pt_regs;
+struct arm_soc_desc;
 
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
@@ -35,6 +36,7 @@ struct machine_desc {
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
+	struct arm_soc_desc	*soc;		/* SoC descriptor	*/
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
new file mode 100644
index 0000000..2d73e35
--- /dev/null
+++ b/arch/arm/include/asm/soc.h
@@ -0,0 +1,19 @@
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
+	const char			*name;
+};
+
+#endif	/* __ASM_ARM_SOC_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a255c39..69ac002 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
 #include <asm/system.h>
+#include <asm/soc.h>
 
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
@@ -141,6 +142,7 @@ static const char *cpu_name;
 static const char *machine_name;
 static char __initdata cmd_line[COMMAND_LINE_SIZE];
 struct machine_desc *machine_desc __initdata;
+static const struct arm_soc_desc *soc_desc __initdata;
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -922,6 +924,11 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	if (mdesc->soc) {
+		soc_desc = mdesc->soc;
+		pr_info("SoC: %s\n", soc_desc->name);
+	} else
+		soc_desc = NULL;
 
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
-- 
1.7.3.4
