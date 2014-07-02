From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Jul 2014 11:57:23 +0200
Subject: [PATCH 3/3] ARM: only select ARM_PATCH_PHYS_VIRT if MMU is enabled
In-Reply-To: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1404295043-6661-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning:

	warning: (ARCH_MULTIPLATFORM && ARCH_INTEGRATOR && ARCH_SHMOBILE_LEGACY) selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU && (!ARCH_REALVIEW || !SPARSEMEM))

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
I'm not sure why ARCH_MULTIPLATFORM appears here. It depends on MMU,
isn't selectable at the same time as ARCH_REALVIEW and XIP_KERNEL
depends on !ARCH_MULTIPLATFORM.

An alternative for ARCH_SHMOBILE_LEGACY is to let it depend on MMU, too.

*shrug*
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6dab0604b911..ecfaf489cc95 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -320,7 +320,7 @@ config ARCH_MULTIPLATFORM
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
@@ -665,7 +665,7 @@ config ARCH_MSM
 config ARCH_SHMOBILE_LEGACY
 	bool "Renesas ARM SoCs (non-multiplatform)"
 	select ARCH_SHMOBILE
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
-- 
2.0.0
