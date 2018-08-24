From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 24 Aug 2018 22:04:24 +0000
Subject: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river for
 ZynqMP core
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
Message-ID: <CY1PR02MB213840050AB61B70F3C2CC6FB8360@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Please review below patch series. It addresses all your pending comments for clock driver.

Thanks,
Jolly Shah

> -----Original Message-----
> From: Jolly Shah [mailto:jolly.shah at xilinx.com]
> Sent: Friday, August 03, 2018 10:53 AM
> To: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; Michal Simek <michals@xilinx.com>;
> robh+dt at kernel.org; mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river for
> ZynqMP core
> 
> This patchset is adding communication layer with firmware and clock driver who
> uses those APIs to communicate with PMU.
> Firmware driver provides an interface to firmware APIs.Interface APIs can be
> used by any driver to communicate to PMUFW(Platform Management Unit). All
> requests go through ATF.
> This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries
> supported clock information from firmware and regiters pll and output clocks
> with CCF.
> 
> v11:
>  - Removed "Reveiwed-by:Stephen Boyd" tag from firmware binding
>  - Updated clock and firmware driver to use probe method instead of init
>  - Marked PMU payload arguments with __le32 for proper endienness code
> 
> v10:
>  - Incorporated code review comments from v9 patch series. Discussed below:
> 	https://patchwork.kernel.org/patch/10478575/
> 	https://patchwork.kernel.org/patch/10478457/
> 	https://patchwork.kernel.org/patch/10478461/
> 	https://patchwork.kernel.org/patch/10478463/
> 
> v9:
>  - Fixed minor typo comments
> 
> v8:
>  - Corrected typo in clk Kconfig
> 
> v7:
>  - Removed xilinx specific clock debugfs API support
>  - Added reviewed-by tags for FW and clock bindings
>  - Updated clock node name to clock-controller
> 
> v6:
>  - Broke patch series to have base FW driver and Clock driver user
>  - Incorporated code review comments from last FW and Clock driver patch
> series. Discussed below:
> 	https://patchwork.kernel.org/patch/10230759/
> 	https://patchwork.kernel.org/patch/10250047/
> 
> v5:
>  - Added ATF version check support
>  - Updated some functions to be static
>  - Minor function name corrections
> 
> v4:
>  - Changed clock setrate/getrate API prototype to support 64 bit rate
>  - Defined macros for get_node_status return values
>  - Moved DT node as a child of firmware
>  - Changed debugfs APIs to return data to debugfs buffer instead of dumping to
> kernel log
>  - Minor changes to incorporate other review comments from v3 patch series
> 
> v3:
>  - added some fixes to firmware-ggs.c
>  - updated pinmux get/set function argument names to specify function id
> instead of node id
>  - added new pinctrl query macros
>  - incorporated review comments from v2 patch series
> 
> v2:
>  - change SPDX-License-Identifier license text style
>  - split patch into multiple patches
>  - Updated copyrights
>  - Added ABI documentation
>  - incorporated logical review comments from previuos patch. Discussed below:
> 	https://patchwork.kernel.org/patch/10150665/
> 
> Jolly Shah (1):
>   drivers: clk: Add ZynqMP clock driver
> 
> Rajan Vaja (10):
>   dt-bindings: firmware: Add bindings for ZynqMP firmware
>   firmware: xilinx: Add Zynqmp firmware driver
>   firmware: xilinx: Add zynqmp IOCTL API for device control
>   firmware: xilinx: Add query data API
>   firmware: xilinx: Add clock APIs
>   firmware: xilinx: Add debugfs interface
>   firmware: xilinx: Add debugfs for IOCTL API
>   firmware: xilinx: Add debugfs for query data API
>   dt-bindings: clock: Add bindings for ZynqMP clock driver
>   firmware: xilinx: Replace init call with probe method
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
>  arch/arm64/Kconfig.platforms                       |   1 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/zynqmp/Kconfig                         |  10 +
>  drivers/clk/zynqmp/Makefile                        |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
>  drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
>  drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
>  drivers/clk/zynqmp/divider.c                       | 217 +++++++
>  drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/xilinx/Kconfig                    |  23 +
>  drivers/firmware/xilinx/Makefile                   |   5 +
>  drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
>  drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
>  drivers/firmware/xilinx/zynqmp.c                   | 535 +++++++++++++++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
>  include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
>  21 files changed, 2788 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>  create mode 100644 drivers/clk/zynqmp/Kconfig  create mode 100644
> drivers/clk/zynqmp/Makefile  create mode 100644 drivers/clk/zynqmp/clk-gate-
> zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h  create mode 100644
> drivers/clk/zynqmp/clkc.c  create mode 100644 drivers/clk/zynqmp/divider.c
> create mode 100644 drivers/clk/zynqmp/pll.c  create mode 100644
> drivers/firmware/xilinx/Kconfig  create mode 100644
> drivers/firmware/xilinx/Makefile  create mode 100644
> drivers/firmware/xilinx/zynqmp-debug.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode 100644
> include/dt-bindings/clock/xlnx,zynqmp-clk.h
>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
> 
> --
> 2.7.4
