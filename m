From: joelf@ti.com (Joel Fernandes)
Date: Wed, 20 Nov 2013 22:04:04 -0600
Subject: [PATCH] ARM: kernel: Detect DTB overwrite and error out
Message-ID: <1385006644-16024-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel can silenty fail for DT-boot after the decompression stage, if DTB is
overwritten. Instead of simply failing, we detect the condition and print an
error.

One may think that it is sufficient for the bootloader to place the DTB away
from kernel, but this is not the right fix because: (1) We add more dependence
to the bootloader's stupidity (2) the decompressed kernel end address is not
known to the loader. Also, we shouldn't depend on bootloader for silently
failing us, so we detect the condition and error out.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/kernel/devtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f35906b..96c6964 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -21,6 +21,7 @@
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/arch.h>
@@ -201,6 +202,13 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	devtree = phys_to_virt(dt_phys);
 
+	if ((char *)devtree <= _end) {
+		early_print("Error: Device tree overwritten by kernel image\n");
+		early_print("Please check your kernel config and/or bootloader\n");
+		while (true)
+			;
+	}
+
 	/* check device tree validity */
 	if (be32_to_cpu(devtree->magic) != OF_DT_HEADER)
 		return NULL;
-- 
1.8.1.2
