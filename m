From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  6 Jul 2018 14:54:48 +0200
Subject: [PATCH] ARM: imx: fix i.MX6SLL build
Message-ID: <20180706125523.3480661-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6SLL cpuidle support reuses the i.MX6SX implementation, but
the Makefile accidentally enables the i.MX6SL one as well, which
then fails with a link error unless the kernel also enables the
the i.MX6SL clock driver:

arch/arm/mach-imx/cpuidle-imx6sl.o: In function `imx6sl_enter_wait':
cpuidle-imx6sl.c:(.text+0x24): undefined reference to `imx6sl_set_wait_clk'

This changes the two lines that were just modified again, hopefully
getting every case right this time.

Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 146ebf97b7eb..bae179af21f6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
-obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
-- 
2.9.0
