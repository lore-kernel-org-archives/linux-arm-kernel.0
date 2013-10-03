From: linux@roeck-us.net (Guenter Roeck)
Date: Wed,  2 Oct 2013 22:05:10 -0700
Subject: [PATCH] arm: Select NOP_USB_XCEIV if MACH_OMAP3EVM is enabled
Message-ID: <1380776710-27788-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm builds have been failing on and off with

arch/arm/mach-omap2/board-omap3evm.c:703: undefined reference to
`usb_nop_xceiv_register'

for several years. Current arm:allmodconfig build fails for this reason.

Problem is that board-omap3evm.c is always build into the kernel.
It calls usb_nop_xceiv_register(), which is built with NOP_USB_XCEIV,
which in turn can be configured as module. This results in the observed
build failure.

Fix the problem once and for all by selecting NOP_USB_XCEIV if MACH_OMAP3EVM
is enabled.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b5fb5f7..0bc2cf4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -265,6 +265,7 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select NOP_USB_XCEIV
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
-- 
1.7.9.7
