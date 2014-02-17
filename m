From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Mon, 17 Feb 2014 11:02:08 +0100
Subject: [PATCH v7 0/8] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
Message-ID: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
The following patchset adds support for the SD/MMC host found in the Allwinner SoCs.
It contains all the necessary modifications for clock environment and also the device
tree script modification which add it to all the boards using it.
The clock environment function needed for phase offset configuration has
been proposed and implemented by Emilio.
A lot of work and cleanup has been done by Hans de Goede. Special thanks to him!
This patchset is the 4th attempt to send this driver upstream.

Changes since v1:
-Using mmc_of_parse instead of diy dt parsing
-Adding nodes for all mmc controller to the dtsi files,
 including sofar unused controllers
-Using generic GPIO slot library for WP/CD
-Adding additional MMC device nodes into DTSI files

Changes since v2:
-Add missing Signed-off-by tags
-Stop using __raw_readl / __raw_writel so that barriers are properly used
-Adding missing new lines
-Adding missing patch for automatic reparenting of clocks

Changes since v3:
-Move clk_enable / disable into host_init / exit (Hans)
-Fix hang on boot caused by irq storm (Hans)

Changes since v4:
-moving sunxi-mci.{c/h} to sunxi-mmc.{c/h}
-removing camel cases from the defines in  sunxi-mmc.h
-moving defines out of the struct definition
 since this is bad coding style
-adding documentation for the device tree binding

Changes since v5:
-adding host initialization for when the sdio irq is enabled
 (just to make sure having a defined state at all time)
-add mmc support fixup: set pullup on cd pins
-fixup: Don't set MMC_CAP_NEEDS_POLL /  MMC_CAP_4_BIT_DATA

Changes since v6:
-fixing copyright info in sunxi-mmc.*
-s/__SUNXI_MCI_H__/__SUNXI_MMC_H__/g
-s/SDXC_RESPONSE_/SDXC_RESP_/g
-s/define/definitions <- Comment from Priit Laes

---

David Lanzend?rfer (5):
      ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs
      ARM: dts: sun7i: Add support for mmc
      ARM: dts: sun4i: Add support for mmc
      ARM: dts: sun5i: Add support for mmc
      ARM: sunxi: Add documentation for driver for SD/MMC hosts found on Allwinner sunxi SoCs

Emilio L?pez (2):
      clk: sunxi: factors: automatic reparenting support
      clk: sunxi: Implement MMC phase control

Hans de Goede (1):
      ARM: sunxi: clk: export clk_sunxi_mmc_phase_control


 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   32 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |    8 
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |    8 
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   54 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   30 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   44 +
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |   15 
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   15 
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   37 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |    8 
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |    8 
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   23 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   61 +
 drivers/clk/sunxi/clk-factors.c                    |   36 +
 drivers/clk/sunxi/clk-sunxi.c                      |   35 +
 drivers/mmc/host/Kconfig                           |    7 
 drivers/mmc/host/Makefile                          |    2 
 drivers/mmc/host/sunxi-mmc.c                       |  876 ++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.h                       |  239 +++++
 include/linux/clk/sunxi.h                          |   22 +
 20 files changed, 1560 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
 create mode 100644 drivers/mmc/host/sunxi-mmc.c
 create mode 100644 drivers/mmc/host/sunxi-mmc.h
 create mode 100644 include/linux/clk/sunxi.h

-- 
Signature
