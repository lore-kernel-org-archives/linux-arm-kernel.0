From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:34 +0200
Subject: [PATCH 3/5] soc: r9a06g032: don't build SMP files for non-SMP config
In-Reply-To: <cover.1532087129.git.horms+renesas@verge.net.au>
References: <cover.1532087129.git.horms+renesas@verge.net.au>
Message-ID: <c83e9c4873d34aa8d9bbb90345fee0757b6233ef.1532087129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_SMP, we get a build failure:

In file included from include/linux/byteorder/little_endian.h:5,
                 from arch/arm/include/uapi/asm/byteorder.h:22,
                 from include/asm-generic/bitops/le.h:6,
                 from arch/arm/include/asm/bitops.h:342,
                 from include/linux/bitops.h:18,
                 from include/linux/kernel.h:11,
                 from include/asm-generic/bug.h:18,
                 from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/io.h:23,
                 from drivers/soc/renesas/r9a06g032-smp.c:11:
drivers/soc/renesas/r9a06g032-smp.c: In function 'r9a06g032_smp_boot_secondary':
drivers/soc/renesas/r9a06g032-smp.c:43:21: error: 'secondary_startup' undeclared (first use in this function)
  writel(__pa_symbol(secondary_startup), cpu_bootaddr);
                     ^~~~~~~~~~~~~~~~~

This makes the compilation of that file conditional on SMP support.
It would probably be better for consistency to leave that file
in arch/arm/mach-shmobile/, matching what we do for all other smp
operations.

Fixes: cde4f86f9249 ("arm: shmobile: Add the R9A06G032 SMP enabler driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 44a0d6b10192..c37b0803c1b6 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -18,7 +18,9 @@ obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
 obj-$(CONFIG_SYSC_R8A77990)	+= r8a77990-sysc.o
 obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
+ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
+endif
 
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
-- 
2.11.0
