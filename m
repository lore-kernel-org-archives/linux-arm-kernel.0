From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 16:51:22 +0530
Subject: [PATCH V3 00/12] clk: Add non CONFIG_HAVE_CLK routines
Message-ID: <cover.1335266056.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many drivers are shared between architectures that may or may not have HAVE_CLK
selected for them. To remove compilation errors for them we enclose clk_*()
calls in these drivers within #ifdef CONFIG_HAVE_CLK, #endif.

This patchset removes the need of these CONFIG_HAVE_CLK statements, by
introducing dummy routines when HAVE_CLK is not selected by platforms. So,
definition of these routines will always be available. These calls will return
error for platforms that don't select HAVE_CLK.

I hope i don't break anything now. ;)

V2->V3:
- Dummy routines now return NULL or 0.
- All user drivers must fail if clk_get returned error other than NULL.
- All user drivers don't need to validate their clk pointer before every call to
  clk_*() routines.
- Patches dropped earlier are again taken back, as they were following similar
  approach to what is implemented now.

V1->V2:
- Removed few patches as they might break working drivers
- Updated 1st patch, as it doesn't apply cleanly on latest linux-next after this
  got applied.

	commit a8a97db984bdc5e89d42e41891543d2daaf314cb
	Author: Mark Brown <broonie@sirena.org.uk>
	Date:   Thu Apr 5 11:42:09 2012 +0100
	
	ARM: 7376/1: clkdev: Implement managed clk_get()

- Similarly, updated stmmac patch as there were updates for it too.

Viresh Kumar (12):
  clk: Add non CONFIG_HAVE_CLK routines
  clk: Remove redundant depends on from drivers/Kconfig
  i2c/i2c-pxa: Remove conditional compilation of clk code
  usb/marvell: Remove conditional compilation of clk code
  usb/musb: Remove conditional compilation of clk code
  ata/pata_arasan: Remove conditional compilation of clk code
  ata/sata_mv: Remove conditional compilation of clk code
  net/c_can: Remove conditional compilation of clk code
  net/stmmac: Remove conditional compilation of clk code
  gadget/m66592: Remove conditional compilation of clk code
  gadget/r8a66597: Remove conditional compilation of clk code
  usb/host/r8a66597: Remove conditional compilation of clk code

 drivers/ata/pata_arasan_cf.c                      |   14 +--
 drivers/ata/sata_mv.c                             |   32 ++---
 drivers/clk/Kconfig                               |    2 -
 drivers/i2c/busses/i2c-pxa.c                      |    7 -
 drivers/net/can/c_can/c_can_platform.c            |    8 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   41 -----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   33 ++--
 drivers/usb/gadget/m66592-udc.c                   |    9 +-
 drivers/usb/gadget/m66592-udc.h                   |    5 -
 drivers/usb/gadget/r8a66597-udc.c                 |   11 +-
 drivers/usb/gadget/r8a66597-udc.h                 |    5 -
 drivers/usb/host/r8a66597-hcd.c                   |   12 --
 drivers/usb/host/r8a66597.h                       |    5 -
 drivers/usb/musb/musb_core.h                      |    8 -
 include/linux/clk.h                               |  168 +++++++++++++-------
 include/linux/platform_data/mv_usb.h              |    9 -
 16 files changed, 141 insertions(+), 228 deletions(-)

-- 
1.7.9
