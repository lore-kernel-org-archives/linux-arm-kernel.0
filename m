From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 10 Mar 2015 11:19:31 +0000
Subject: [PATCH v9 05/21] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <54FEA4CC.8090000@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-6-git-send-email-hanjun.guo@linaro.org>
 <20150305185117.GA17415@e102568-lin.cambridge.arm.com>
 <54FEA4CC.8090000@linaro.org>
Message-ID: <20150310111931.GU4278@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:01:16PM +0800, Hanjun Guo wrote:
> >>index 0000000..f052e7a
> >>--- /dev/null
> >>+++ b/arch/arm64/kernel/acpi.c
> >>@@ -0,0 +1,101 @@
> >>+/*
> >>+ *  ARM64 Specific Low-Level ACPI Boot Support
> >>+ *
> >>+ *  Copyright (C) 2013-2014, Linaro Ltd.
> >>+ *	Author: Al Stone <al.stone@linaro.org>
> >>+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> >>+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> >>+ *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>+ *	Author: Naresh Bhat <naresh.bhat@linaro.org>
> >>+ *
> >>+ *  This program is free software; you can redistribute it and/or modify
> >>+ *  it under the terms of the GNU General Public License version 2 as
> >>+ *  published by the Free Software Foundation.
> >>+ */
> >>+
> >>+#define pr_fmt(fmt) "ACPI: " fmt
> >>+
> >>+#include <linux/acpi.h>
> >>+#include <linux/bootmem.h>
> >>+#include <linux/cpumask.h>
> >>+#include <linux/init.h>
> >>+#include <linux/irq.h>
> >>+#include <linux/irqdomain.h>
> >>+#include <linux/memblock.h>
> >>+#include <linux/smp.h>
> >>+
> >>+int acpi_noirq;			/* skip ACPI IRQ initialization */
> >>+int acpi_disabled;
> >>+EXPORT_SYMBOL(acpi_disabled);
> >>+
> >>+int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
> >>+EXPORT_SYMBOL(acpi_pci_disabled);
> >>+
> >>+/*
> >>+ * __acpi_map_table() will be called before page_init(), so early_ioremap()
> >>+ * or early_memremap() should be called here to for ACPI table mapping.
> >>+ */
> >>+char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> >>+{
> >>+	if (!phys || !size)
> >
> >Is there a reason to rule out physical address 0x0 ?
> 
> No particular reasons, unless some arch/firmware limits, I'm
> not sure if we need this check (x86 needs it), I'm CC Leif
> to confirm.

Nothing in UEFI explicitly bans using physical address 0 for anything,
and nothing in the architecture reserves it. So I don't think this
check is necessary.

/
    Leif
