From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:25 +0200
Subject: [PATCH 02/11] ARM: kirkwood: move qnap_tsx1x_register_flash() to
	.init.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

qnap_tsx1x_register_flash is only called by qnap_ts219_init and
qnap_ts41x_init which both live in .init.text, too.  So the move is OK.

This fixes the following warning in kirkwood_defconfig:
	WARNING: vmlinux.o(.text+0x9334): Section mismatch in reference from the function qnap_tsx1x_register_flash() to the variable .init.data:qnap_tsx1x_spi_slave_info
	The function qnap_tsx1x_register_flash() references
	the variable __initdata qnap_tsx1x_spi_slave_info.
	This is often because qnap_tsx1x_register_flash lacks a __initdata
	annotation or the annotation of qnap_tsx1x_spi_slave_info is wrong.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-kirkwood/tsx1x-common.c |    2 +-
 arch/arm/mach-kirkwood/tsx1x-common.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c b/arch/arm/mach-kirkwood/tsx1x-common.c
index 7221c20..f781164 100644
--- a/arch/arm/mach-kirkwood/tsx1x-common.c
+++ b/arch/arm/mach-kirkwood/tsx1x-common.c
@@ -77,7 +77,7 @@ struct spi_board_info __initdata qnap_tsx1x_spi_slave_info[] = {
 	},
 };
 
-void qnap_tsx1x_register_flash(void)
+void __init qnap_tsx1x_register_flash(void)
 {
 	spi_register_board_info(qnap_tsx1x_spi_slave_info,
 				ARRAY_SIZE(qnap_tsx1x_spi_slave_info));
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.h b/arch/arm/mach-kirkwood/tsx1x-common.h
index 9a59296..7fa0373 100644
--- a/arch/arm/mach-kirkwood/tsx1x-common.h
+++ b/arch/arm/mach-kirkwood/tsx1x-common.h
@@ -1,7 +1,7 @@
 #ifndef __ARCH_KIRKWOOD_TSX1X_COMMON_H
 #define __ARCH_KIRKWOOD_TSX1X_COMMON_H
 
-extern void qnap_tsx1x_register_flash(void);
+extern void __init qnap_tsx1x_register_flash(void);
 extern void qnap_tsx1x_power_off(void);
 
 #endif
-- 
1.7.1
