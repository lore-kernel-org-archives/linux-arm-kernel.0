From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Sep 2010 17:46:02 +0100
Subject: [PATCH 3/3] ARM: vexpress: add support for CPU hotplug
	to	ct-ca9x4 tile
In-Reply-To: <20100908143700.GB32659@n2100.arm.linux.org.uk>
References: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
	<1282060684-27761-2-git-send-email-will.deacon@arm.com>
	<1282060684-27761-3-git-send-email-will.deacon@arm.com>
	<1282060684-27761-4-git-send-email-will.deacon@arm.com>
	<20100908143700.GB32659@n2100.arm.linux.org.uk>
Message-ID: <000301cb4f75$52e66570$f8b33050$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Tue, Aug 17, 2010 at 04:58:04PM +0100, Will Deacon wrote:
> > The Versatile Express platform can support a quad-core Cortex-A9 tile running
> > SMP Linux.
> >
> > This patch adds support for CPU hotplug when running in this configuration.
> 
> This ties the core tile support into the generic versatile express code,
> something which the current code structure is careful to avoid.  Please
> ensure that we continue to avoid making the generic code rely upon
> CA9x4 code.

The cpu_{enter,leave}_lowpower functions are implemented in the tile code
so they should be ok. I suppose the problem is that we might be able to do
better than a WFI on some tiles. How about this?:


diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
new file mode 100644
index 0000000..672e434
--- /dev/null
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -0,0 +1,47 @@
+/*
+ *  linux/arch/arm/mach-vexpress/hotplug.c
+ *
+ *  Copyright (C) 2010 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <plat/hotplug.h>
+
+extern volatile int pen_release;
+
+/* CPU-specific functions implemented in the tile support code */
+extern void cpu_enter_lowpower(void);
+extern int cpu_do_lowpower(void);
+extern void cpu_leave_lowpower(void);
+
+void __ref platform_do_lowpower(unsigned int cpu)
+{
+       cpu_enter_lowpower();
+
+       if (cpu_do_lowpower() == -ENODEV) {
+               /*
+                * Tile does not have any low-power hardware so we
+                * put the core into a WFI.
+                */
+               for (;;) {
+                       asm volatile("wfi" : : : "memory");
+
+                       if (pen_release == cpu)
+                               break;
+
+#ifdef DEBUG
+                       printk("CPU%u: spurious wakeup call\n", cpu);
+#endif
+               }
+       }
+
+       cpu_leave_lowpower();
+}


The alternative would be to merge all the cpu_* functions into one, but
then we'd end up replicating the wfi code across all the tiles without
additional power-saving hardware.

Cheers,

Will
