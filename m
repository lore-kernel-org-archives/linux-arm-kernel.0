From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:54 +0200
Subject: [PATCH 5/9] ARM: imx: reset_controller may be disabled
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new reset controller API is optional, so if that is disabled,
we must not call it from platform code.

arch/arm/mach-imx/built-in.o: In function
 `imx_src_init': /git/arm-soc/arch/arm/mach-imx/src.c:144:
	undefined reference to `reset_controller_register'

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/src.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index dc101898..10a6b1a 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -141,7 +141,8 @@ void __init imx_src_init(void)
 	WARN_ON(!src_base);
 
 	imx_reset_controller.of_node = np;
-	reset_controller_register(&imx_reset_controller);
+	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
+		reset_controller_register(&imx_reset_controller);
 
 	/*
 	 * force warm reset sources to generate cold reset
-- 
1.8.1.2
