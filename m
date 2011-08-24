From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 24 Aug 2011 13:04:32 +0800
Subject: [[PATCH v2 1/6] ARM: imx: Introduce generic function for displaying
	silicon revision
In-Reply-To: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
References: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314162277-2840-2-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently each i.MX processor has its own function for displaying the silicon
revision.

Introduce a generic function for this purpose, so that all i.MX processors can
reuse it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
V2: remove EXPORT_SYMBOL
---
 arch/arm/plat-mxc/cpu.c                 |    9 +++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/cpu.c b/arch/arm/plat-mxc/cpu.c
index 386e0d5..f5b7e0f 100644
--- a/arch/arm/plat-mxc/cpu.c
+++ b/arch/arm/plat-mxc/cpu.c
@@ -1,5 +1,6 @@
 
 #include <linux/module.h>
+#include <mach/hardware.h>
 
 unsigned int __mxc_cpu_type;
 EXPORT_SYMBOL(__mxc_cpu_type);
@@ -9,3 +10,11 @@ void mxc_set_cpu_type(unsigned int type)
 	__mxc_cpu_type = type;
 }
 
+void imx_print_silicon_rev(const char *cpu, int srev)
+{
+	if (srev == IMX_CHIP_REVISION_UNKNOWN)
+		pr_info("CPU identified as %s, unknown revision\n", cpu);
+	else
+		pr_info("CPU identified as %s, silicon rev %d.%d\n",
+				cpu, (srev >> 4) & 0xf, srev & 0xf);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..318e0da 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,4 +72,5 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void imx_print_silicon_rev(const char *cpu, int srev);
 #endif
-- 
1.7.4.1
