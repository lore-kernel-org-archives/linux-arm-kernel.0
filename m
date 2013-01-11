From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 22:20:58 +0800
Subject: [PATCH] ARM: imx: fix build error with !CONFIG_SMP
Message-ID: <1357914058-24712-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68b2532 (ARM: imx: select HAVE_IMX_SRC when SMP is enabled)
introduces a build error with imx_v6_v7_defconfig when CONFIG_SMP is
deselected.

  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
arch/arm/mach-imx/built-in.o: In function `imx6q_restart':
platform-ahci-imx.c:(.text+0x448c): undefined reference to `imx_src_prepare_restart'
arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
platform-ahci-imx.c:(.text+0x4544): undefined reference to `imx_set_cpu_jump'
arch/arm/mach-imx/built-in.o: In function `imx6q_init_irq':
platform-ahci-imx.c:(.init.text+0xbef0): undefined reference to `imx_src_init'
make[1]: *** [vmlinux] Error 1

While the commit adds 'def_bool y if SMP' for HAVE_IMX_SRC, it should
not remove 'select HAVE_IMX_SRC' from SOC_IMX6Q, as the IMX6Q UP build
also needs HAVE_IMX_SRC.  Add the HAVE_IMX_SRC select back for SOC_IMX6Q
to fix above build error.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1ad0d76..8e2f292 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -853,6 +853,7 @@ config SOC_IMX6Q
 	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
+	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
 	select PINCTRL
-- 
1.7.9.5
