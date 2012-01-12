From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 11:31:14 -0600
Subject: [PATCH v2 5/7] ARM: imx: remove incorrect BSYM usage
In-Reply-To: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326389476-11569-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

BSYM macro is only needed for assembly files and its usage in c files is
wrong, so remove it. The linker will correctly set bit 0 for Thumb2
kernels.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/src.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 4bde04f..29bd124 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
-#include <asm/unified.h>
 
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
@@ -43,7 +42,7 @@ void imx_enable_cpu(int cpu, bool enable)
 void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
 	cpu = cpu_logical_map(cpu);
-	writel_relaxed(BSYM(virt_to_phys(jump_addr)),
+	writel_relaxed(virt_to_phys(jump_addr),
 		       src_base + SRC_GPR1 + cpu * 8);
 }
 
-- 
1.7.5.4
