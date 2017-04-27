From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 13:02:31 +0200
Subject: [PATCH] clk: sunxi-ng: always select CCU_GATE
Message-ID: <20170427110239.2389266-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the base driver is enabled but all SoC specific drivers are turned
off, we now get a build error after code was added to always refer to the
clk gates:

drivers/clk/built-in.o: In function `ccu_pll_notifier_cb':
:(.text+0x154f8): undefined reference to `ccu_gate_helper_disable'
:(.text+0x15504): undefined reference to `ccu_gate_helper_enable'

This changes the Kconfig to always require the gate code to be built-in
when CONFIG_SUNXI_CCU is set.

Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/sunxi-ng/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 64088e599404..b0d551a8efe4 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -16,7 +16,7 @@ config SUNXI_CCU_FRAC
 	bool
 
 config SUNXI_CCU_GATE
-	bool
+	def_bool y
 
 config SUNXI_CCU_MUX
 	bool
-- 
2.9.0
