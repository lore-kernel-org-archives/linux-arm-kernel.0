From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:06:26 +0100
Subject: [PATCH 8/8] ARM: shmobile: emev2: Move declaration of emev2_smp_ops
 to emev2.h
In-Reply-To: <cover.1455303757.git.horms+renesas@verge.net.au>
References: <cover.1455303757.git.horms+renesas@verge.net.au>
Message-ID: <9c9c1320111449c770a51488ca74a5902835e227.1455303757.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

make C=1:

    arch/arm/mach-shmobile/smp-emev2.c:51:29: warning: symbol 'emev2_smp_ops' was not declared. Should it be static?

To fix this, move the forward declaration of emev2_smp_ops to a header
file, and include it where appropriate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/emev2.h       | 6 ++++++
 arch/arm/mach-shmobile/setup-emev2.c | 4 ++--
 arch/arm/mach-shmobile/smp-emev2.c   | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/emev2.h

diff --git a/arch/arm/mach-shmobile/emev2.h b/arch/arm/mach-shmobile/emev2.h
new file mode 100644
index 000000000000..916d25f6780e
--- /dev/null
+++ b/arch/arm/mach-shmobile/emev2.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_EMEV2_H__
+#define __ASM_EMEV2_H__
+
+extern const struct smp_operations emev2_smp_ops;
+
+#endif /* __ASM_EMEV2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 0829d0215c38..3c99aaf65325 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -18,15 +18,15 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+
 #include "common.h"
+#include "emev2.h"
 
 static const char *const emev2_boards_compat_dt[] __initconst = {
 	"renesas,emev2",
 	NULL,
 };
 
-extern const struct smp_operations emev2_smp_ops;
-
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.init_early	= shmobile_init_delay,
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 4dfafd845452..3a732199cf5e 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -21,7 +21,9 @@
 #include <linux/delay.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+
 #include "common.h"
+#include "emev2.h"
 
 #define EMEV2_SCU_BASE 0x1e000000
 #define EMEV2_SMU_BASE 0xe0110000
-- 
2.7.0.rc3.207.g0ac5344
