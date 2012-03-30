From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 30 Mar 2012 22:29:20 +0200
Subject: [PATCH] ARM: davinci/da850-evm: fix section mismatch
Message-ID: <1333139360-6791-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:
	WARNING: arch/arm/mach-davinci/built-in.o(.text+0x2d84): Section mismatch in reference from the function da850_evm_ui_expander_setup() to the (unknown reference) .init.data:(unknown)
	The function da850_evm_ui_expander_setup() references
	the (unknown reference) __initdata (unknown).
	This is often because da850_evm_ui_expander_setup lacks a __initdata
	annotation or the annotation of (unknown) is wrong.

Note this is a real issue because if the tca6416 driver only binds when
the init sections are already discarded da850_evm_ui_expander_setup is
called when da850_evm_devices might already be overwritten.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-davinci/board-da850-evm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a70de24..09f6107 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -284,7 +284,7 @@ static struct platform_device da850_evm_nandflash_device = {
 	.resource	= da850_evm_nandflash_resource,
 };
 
-static struct platform_device *da850_evm_devices[] __initdata = {
+static struct platform_device *da850_evm_devices[] = {
 	&da850_evm_nandflash_device,
 	&da850_evm_norflash_device,
 };
-- 
1.7.9.5
