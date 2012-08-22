From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:07 +0200
Subject: [PATCH 3/6] ARM: imx: build pm-imx5 code only when PM is enabled
In-Reply-To: <1345648390-4234-1-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
Message-ID: <1345648390-4234-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the imx5 pm code out of the list of unconditionally
compiled files for imx5, mirroring what we already do for imx6
and how it was done before the code was move from mach-mx5 to
mach-imx in v3.3.

Without this patch, building with CONFIG_PM disabled results in:

arch/arm/mach-imx/pm-imx5.c:202:116: error: redefinition of 'imx51_pm_init'
arch/arm/mach-imx/include/mach-imx/common.h:154:91: note: previous definition of 'imx51_pm_init' was here
arch/arm/mach-imx/pm-imx5.c:209:116: error: redefinition of 'imx53_pm_init'
arch/arm/mach-imx/include/mach-imx/common.h:155:91: note: previous definition of 'imx53_pm_init' was here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 07f7c22..e08adb7 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
 obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
 
-obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
+imx5-pm-$(CONFIG_PM) += pm-imx5.o
+obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o $(imx5-pm-y) cpu_op-mx51.o
 
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 			    clk-pfd.o clk-busy.o
-- 
1.7.10
