From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Dec 2016 13:58:06 +0900
Subject: [PATCH v2 0/5] arm64: dts: Enable bus frequency scaling on
 Exynos5433-based TM2 board
Message-ID: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add the AMBA bus Device-tree node unsing VDD_INT
to enable the bus frequency scaling on Exynos5433-based TM2 board.

There are two kind of bus device with devfreq framework.
- Parent bus device  : Change the frequency/voltage according to bus's utilization.
- Passive bus device : Change only frequency according to the new level
                       of parent bus device.

The VDD_INT regulator provides the power source to INT (Internal) block as
following. The sub-blocks in the INT block share the one power source.
	VDD_INT |--- G2D_400 (parent device)
		|--- G2D_266
		|--- GSCL
		|--- JPEG
		|--- HEVC
		|--- MFC
		|--- MSCL
		|--- NoC0
		|--- NoC1
		|--- NoC2
		|--- PERIS (Fixed clock rate)
		|--- PERIC (Fixed clock rate)
		|--- FSYS  (Fixed clock rate)

Each sub-block has the bus clock as following:
 - CLK_ACLK_G2D_{400|266} : Bus clock for G2D (2D graphic engine)
 - CLK_ACLK_MSCL_400      : Bus clock for MSCL (Memory to memory Scaler)
 - CLK_ACLK_GSCL_333      : Bus clock for GSCL (General Scaler)
 - CLK_SCLK_JPEG_MSCL     : Bus clock for JPEG
 - CLK_ACLK_MFC_400       : Bus clock for MFC (Multi Format Codec)
 - CLK_ACLK_HEVC_400      : Bus clock for HEVC (High Effective Video Codec)
 - CLK_ACLK_BUS0_400      : NoC(Network On Chip)'s bus clock for PERIC/PERIS/FSYS/MSCL
 - CLK_ACLK_BUS1_400      : NoC's bus clock for MFC/HEVC/G3D
 - CLK_ACLK_BUS2_400      : NoC's bus clock for GSCL/DISP/G2D/CAM0/CAM1/ISP

Changes from v1:
- Remove duplicate description of exynos5433-bus.dtsi
- Move the bus device-tree node under the 'soc'
- Modify the node name of bus from 'bus_xxx_xxx' to 'bus[number]'
- Reorder the bus device-tree node alpabetically
- Change the node name from 'bus_busX' to 'bus_nocX'
- Fix minor issue
- Add reviewed-by tag of Krzysztof Kozlowski for patch3/5

Chanwoo Choi (5):
  clk: samsung: exynos5433: Set NoC (Network On Chip) clocks as critical
  PM / devfreq: exynos-bus: Add the detailed correlation for Exynos5433
  arm64: dts: exynos5433: Add PPMU dt node
  arm64: dts: exynos5433: Add bus dt node using VDD_INT for Exynos5433
  arm64: dts: exynos5433: Add support of bus frequency using VDD_INT on TM2

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  15 ++
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 197 +++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  70 ++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  25 +++
 drivers/clk/samsung/clk-exynos5433.c               |   8 +-
 5 files changed, 311 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi

-- 
1.9.1
