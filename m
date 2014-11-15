From: amstan@chromium.org (Alexandru M Stan)
Date: Fri, 14 Nov 2014 16:00:02 -0800
Subject: [PATCH v2 0/2] Add support for the rockchip mmc clock phases using
 the framework
Message-ID: <1416009604-31545-1-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now all I have is the getter and setter for the phase, nothing that uses it
(that is ready). You can test the getter like this:
localhost ~ # cat /sys/kernel/debug/clk/clk_summary|grep sample -C 1
    sclk_sdio1                            0            0    24000000          0 0
       sdio1_sample                       0            0    12000000          0 0
       sdio1_drv                          0            0    12000000          0 90
--
          sclk_sdmmc                      1            1   297000000          0 0
             sdmmc_sample                 0            0   148500000          0 134
             sdmmc_drv                    0            0   148500000          0 90
--
          sclk_sdio0                      1            1   100000000          0 0
             sdio0_sample                 0            0    50000000          0 0
             sdio0_drv                    0            0    50000000          0 90
          sclk_emmc                       1            1   100000000          0 0
             emmc_sample                  0            0    50000000          0 0
             emmc_drv                     0            0    50000000          0 180

Next thing that will come is some dts changes that will make use of these new
clocks, and eventually mmc code will be changed to tune with these clocks.

Changes in v2:
- fixed my cc/to list
- removed dangling #DEFINE DEBUG

Alexandru M Stan (2):
  clk: rockchip: add bindings for the mmc clock phases
  clk: rockchip: Add support for the mmc clock phases using the
    framework

 drivers/clk/rockchip/Makefile          |   1 +
 drivers/clk/rockchip/clk-mmc-phase.c   | 149 +++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3288.c      |  12 +++
 drivers/clk/rockchip/clk.c             |   8 ++
 drivers/clk/rockchip/clk.h             |  23 +++++
 include/dt-bindings/clock/rk3288-cru.h |  10 +++
 6 files changed, 203 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-mmc-phase.c

-- 
2.1.0.rc2.206.gedb03e5
