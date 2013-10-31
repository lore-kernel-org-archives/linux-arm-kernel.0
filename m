From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 16:44:23 +0800
Subject: [PATCH] ARM: imx: v7_cpu_resume() is needed by imx6sl build
Message-ID: <1383209063-27549-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building a kernel with the following options,

  CONFIG_SMP=n
  CONFIG_PM=y
  CONFIG_SOC_IMX6SL=y
  CONFIG_SOC_IMX6Q=n

we will see the build error below.

  arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
  platform-spi_imx.c:(.text+0x2648): undefined reference to `v7_cpu_resume'
  make[1]: *** [vmlinux] Error 1

This is because that v7_cpu_resume() implemented in headsmp.S is also
needed by imx6sl build.  Let's build headsmp.S for CONFIG_SOC_IMX6SL as
well.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bbe1f5b..1789e2b 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -102,8 +102,8 @@ obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
-# i.MX6SL reuses pm-imx6q.c
-obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o
+# i.MX6SL reuses i.MX6Q code
+obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
 endif
 
 # i.MX5 based machines
-- 
1.7.9.5
