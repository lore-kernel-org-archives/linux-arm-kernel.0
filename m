From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  7 Sep 2012 14:43:42 +0200
Subject: [PATCH v4 0/6] Add device tree support for on-chip SRAM 
Message-ID: <1347021828-23034-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support to configure on-chip SRAM via device-tree
node and to obtain the resulting genalloc pool from a phandle pointing
at the node.
This allows drivers to allocate SRAM with the genalloc API without
hard-coding the genalloc pool address.

The on-chip SRAM on i.MX53 and i.MX6q is registered via device tree and
changed to use the simple generic SRAM driver:

		ocram: ocram at 00900000 {
			compatible = "fsl,imx-ocram", "sram";
			reg = <0x00900000 0x3f000>;
 		};

A driver that needs to allocate SRAM buffers, like the video processing
unit on i.MX53, can retrieve the genalloc pool from a phandle in the
device tree using of_get_named_gen_pool(node, "iram", 0) from patch 1:

		vpu at 63ff4000 {
			/* ... */
			iram = <&ocram>;
 		};

Changes since v3:
 - Added devicetree binding documentation
 - Register platform driver early with postcore_initcall
 - Added optional SRAM clock support.

regards
Philipp

---
 Documentation/devicetree/bindings/misc/sram.txt |   17 ++++
 arch/arm/boot/dts/imx53.dtsi                    |    5 +
 arch/arm/boot/dts/imx6q.dtsi                    |    5 +
 arch/arm/mach-imx/clk-imx6q.c                   |    1 +
 arch/arm/plat-mxc/Kconfig                       |    4 -
 arch/arm/plat-mxc/Makefile                      |    1 -
 arch/arm/plat-mxc/include/mach/iram.h           |   41 --------
 arch/arm/plat-mxc/iram_alloc.c                  |   73 --------------
 drivers/misc/Kconfig                            |    9 ++
 drivers/misc/Makefile                           |    1 +
 drivers/misc/sram.c                             |  121 +++++++++++++++++++++++
 include/linux/genalloc.h                        |   14 +++
 lib/genalloc.c                                  |   67 +++++++++++++
 13 files changed, 240 insertions(+), 119 deletions(-)
