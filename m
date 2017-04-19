From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 19:35:36 +0200
Subject: [PATCH] arm64: sunxi: always enable reset controller
Message-ID: <20170419173601.3773999-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi clk driver causes a link error when the reset controller
subsystem is disabled:

drivers/clk/built-in.o: In function `sun4i_ve_clk_setup':
:(.init.text+0xd040): undefined reference to `reset_controller_register'
drivers/clk/built-in.o: In function `sun4i_a10_display_init':
:(.init.text+0xe5e0): undefined reference to `reset_controller_register'
drivers/clk/built-in.o: In function `sunxi_usb_clk_setup':
:(.init.text+0x10074): undefined reference to `reset_controller_register'

We already force it to be enabled on arm32 and some other arm64 platforms,
but not on arm64/sunxi. This adds the respective Kconfig statements to
also select it here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

I'd suggest we can pick this up in arm-soc as a non-urgent bugfix for 4.12

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b3a1fb8df925..4afcffcb46cb 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,8 +2,10 @@ menu "Platform selection"
 
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
+	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
+	select RESET_CONTROLLER
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.9.0
