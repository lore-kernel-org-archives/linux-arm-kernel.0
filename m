From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:17:27 +0530
Subject: [PATCH 00/13] clk: Add non CONFIG_HAVE_CLK routines
Message-ID: <cover.1335008617.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many drivers are shared between architectures that may or may not have HAVE_CLK
selected for them. To remove compilation errors for them we enclose clk_*()
calls in these drivers within #ifdef CONFIG_HAVE_CLK, #endif.

This patchset removes the need of these CONFIG_HAVE_CLK statements, by
introducing dummy routines when HAVE_CLK is not selected by platforms. So,
definition of these routines will always be available. These calls will return
error for platforms that don't select HAVE_CLK.

Viresh Kumar (13):
  clk: Add non CONFIG_HAVE_CLK routines
  clk: Remove redundant depends on from drivers/Kconfig
  clk: CLK_PREPARE must depend on HAVE_CLK
  ata/pata_arasan: Remove conditional compilation of clk code
  ata/sata_mv: Remove conditional compilation of clk code
  i2c/i2c-pxa: Remove conditional compilation of clk code
  net/c_can: Remove conditional compilation of clk code
  net/stmmac: Remove conditional compilation of clk code
  gadget/m66592: Remove conditional compilation of clk code
  gadget/r8a66597: Remove conditional compilation of clk code
  usb/host/r8a66597: Remove conditional compilation of clk code
  usb/marvell: Remove conditional compilation of clk code
  usb/musb: Remove conditional compilation of clk code

 drivers/ata/pata_arasan_cf.c                      |   39 ++---
 drivers/ata/sata_mv.c                             |   10 --
 drivers/clk/Kconfig                               |    3 +-
 drivers/i2c/busses/i2c-pxa.c                      |    7 -
 drivers/net/can/c_can/c_can_platform.c            |   28 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   40 -----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   34 +++--
 drivers/usb/gadget/m66592-udc.c                   |   19 +--
 drivers/usb/gadget/m66592-udc.h                   |    5 -
 drivers/usb/gadget/r8a66597-udc.c                 |   21 +--
 drivers/usb/gadget/r8a66597-udc.h                 |    5 -
 drivers/usb/host/r8a66597-hcd.c                   |   28 ++---
 drivers/usb/host/r8a66597.h                       |    5 -
 drivers/usb/musb/musb_core.h                      |    8 -
 include/linux/clk.h                               |  160 +++++++++++++--------
 include/linux/platform_data/mv_usb.h              |    9 --
 16 files changed, 171 insertions(+), 250 deletions(-)

-- 
1.7.9
