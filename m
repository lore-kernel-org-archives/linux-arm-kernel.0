From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 16 Feb 2014 16:26:34 +0800
Subject: [PATCH] ARM: imx6: build pm-imx6q.c independently of CONFIG_PM
Message-ID: <1392539194-23447-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel image with only CONFIG_CPU_IDLE but no CONFIG_PM,
we will get the following link error.

  LD      init/built-in.o
arch/arm/mach-imx/built-in.o: In function `imx6q_enter_wait':
platform-spi_imx.c:(.text+0x25c0): undefined reference to `imx6q_set_lpm'
platform-spi_imx.c:(.text+0x25d4): undefined reference to `imx6q_set_lpm'
arch/arm/mach-imx/built-in.o: In function `imx6q_cpuidle_init':
platform-spi_imx.c:(.init.text+0x75d4): undefined reference to `imx6q_set_chicken_bit'
make[1]: *** [vmlinux] Error 1

Since pm-imx6q.c has been a collection of library functions that access
CCM low-power registers used by not only suspend but also cpuidle and
other drivers, let's build pm-imx6q.c independently of CONFIG_PM to fix
above error.

Reported-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/Makefile |    2 --
 arch/arm/mach-imx/common.h |    4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index befcaf5..ec41964 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -101,11 +101,9 @@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
-ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
 # i.MX6SL reuses i.MX6Q code
 obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
-endif
 
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59c3b9b..baf439d 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -144,13 +144,11 @@ void imx6q_set_chicken_bit(void);
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
 
-#ifdef CONFIG_PM
 void imx6q_pm_init(void);
 void imx6q_pm_set_ccm_base(void __iomem *base);
+#ifdef CONFIG_PM
 void imx5_pm_init(void);
 #else
-static inline void imx6q_pm_init(void) {}
-static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
 static inline void imx5_pm_init(void) {}
 #endif
 
-- 
1.7.9.5
