From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Sep 2013 11:49:35 +0200
Subject: [PATCH 1/3] ARM: drop !ARCH_MULTIPLATFORM dependency of XIP_KERNEL
In-Reply-To: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380534577-15076-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling XIP_KERNEL requires specifying the physical address of the readonly
memory. As these addresses vary among different SoCs and even machines with
the same SoC enabling XIP_KERNEL might restrict the set of machines that can
run the resulting kernel to a subset of the configured in machines.

Still allowing XIP_KERNEL for a MULTIPLATFORM kernel makes sense as for some
platforms MULTIPLATFORM is mandatory (e.g. bcm, highbank or imx). So to
allow compiling a XIP kernel for these platforms, allow selecting XIP in the
presence of ARCH_MULTIPLATFORM.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This patch might be problematic for compile coverage testing according to
Arnd. Still I need XIP for my efm32 machine as it only features 4 MiB of
RAM.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 22efc5d..0f63a70 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2092,7 +2092,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ZBOOT_ROM && !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ZBOOT_ROM && !ARM_LPAE
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
1.8.4.rc3
