From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2011 16:27:29 +0800
Subject: [PATCH 1/6] ARM: mxc: remove unnecessary header file inclusion from
	gpio.h
In-Reply-To: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310113654-25887-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/gpio.h is included by asm/gpio.h, and in turn it gets
included all over the place.  Including unnecessary headers there
brings indirect inclusion trouble.

As an example, spi-imx calls cpu_is_mx21() but never explicitly
includes mach/hardware.h.  However it works because the header is
included in mach/gpio.h.

The patch cleans the unnecessary header file from mach/gpio.h,
and includes headers explicitly where needed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/gpio.h |    2 --
 drivers/spi/spi-imx.c                 |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 31c820c..5bb02af 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_ARCH_MXC_GPIO_H__
 #define __ASM_ARCH_MXC_GPIO_H__
 
-#include <linux/spinlock.h>
-#include <mach/hardware.h>
 #include <asm-generic/gpio.h>
 
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 69d6dba..7097d43 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 
 #include <mach/spi.h>
+#include <mach/hardware.h>
 
 #define DRIVER_NAME "spi_imx"
 
-- 
1.7.4.1
