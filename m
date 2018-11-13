From: john.garry@huawei.com (John Garry)
Date: Wed, 14 Nov 2018 01:04:25 +0800
Subject: [PATCH] arm64: sunxi: Enable REGMAP_MMIO to fix linker error
Message-ID: <1542128665-78302-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following linker failure can be seen for a certain heavily reduced
defconfig:
drivers/soc/sunxi/sunxi_sram.o: In function `sunxi_sram_probe':
drivers/soc/sunxi/sunxi_sram.c:353: undefined reference to `__devm_regmap_init_mmio_clk'
drivers/soc/sunxi/sunxi_sram.c:353:(.text+0x3c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__devm_regmap_init_mmio_clk'

It would seem that the sunxi sram driver implicitly depended on config
REGMAP_MMIO.

To solve, select config REGMAP_MMIO for ARCH_SUNXI. This seems a better
option than selecting from the respective driver config as this just
defaults to ARCH_SUNXI.

Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479..c8a6ad3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -12,6 +12,7 @@ config ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
+	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
-- 
1.9.1
