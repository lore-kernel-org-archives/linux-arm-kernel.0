From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Feb 2011 13:33:10 -0500 (EST)
Subject: [PATCH 1/2] ARM: ignore mdesc->boot_params if out of range
Message-ID: <alpine.LFD.2.00.1102121330490.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The initial MMU table created in head.S contains a 1 MB mapping at the
start of memory to let the early kernel boot code access the boot params
specified by mdesc->boot_params.

When using CONFIG_ARM_PATCH_PHYS_VIRT it is possible for the kernel to
have a different idea of where the start of memory is at run time, making
the compile-time determined mdesc->boot_params pointing to a memory area
which is not mapped.  Any access to the boot params in that case will
fault and silently hang the kernel at that point.  It is therefore a
better idea to simply ignore mdesc->boot_params in that case and give
the kernel a chance to print some diagnostic on the console later.

If the bootloader provides a valid pointer in r2 to the kernel then this
is used instead of mdesc->boot_params, and an explicit mapping is already
created in the initial MMU table for it.  It is therefore a good idea to
use that facility when using a relocated kernel.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/setup.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 056bf18..729994c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -853,8 +853,25 @@ void __init setup_arch(char **cmdline_p)
 
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
-	else if (mdesc->boot_params)
-		tags = phys_to_virt(mdesc->boot_params);
+	else if (mdesc->boot_params) {
+#ifdef CONFIG_MMU
+		/*
+		 * We still are executing with a minimal MMU mapping created
+		 * with the presumption that the machine default for this
+		 * is located in the first MB of RAM.  Anything else will
+		 * fault and silently hang the kernel at this point.
+		 */
+		if (mdesc->boot_params < PHYS_OFFSET ||
+		    mdesc->boot_params >= PHYS_OFFSET + SZ_1M) {
+			printk(KERN_WARNING
+			       "Default boot params at physical 0x%08lx out of reach\n", 
+			       mdesc->boot_params);
+		} else
+#endif
+		{
+			tags = phys_to_virt(mdesc->boot_params);
+		}
+	}
 
 #if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 	/*
-- 
1.7.4
