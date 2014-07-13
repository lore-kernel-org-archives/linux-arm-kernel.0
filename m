From: mollie.wu@linaro.org (Mollie Wu)
Date: Sun, 13 Jul 2014 14:27:13 +0800
Subject: [PATCH 0/8] Support for Fujitsu MB86S7X SoCs
Message-ID: <1405232833-4531-1-git-send-email-mollie.wu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Fujitsu have a series of SoC already shipping based around
variations of 2 A15 + 2 A7 big.LITTLE architecture, and we would like
to upstream the basic support in this series.

  MB86S70 is a bigLITTLE platform with 2xCA7+2xCA15 and an additional
CM3 as the master. In this initial series we support boot from the A7 cluster, 
we will provide patches later to implement full big.LITTLE. 
MB86S73 is a simple 2xCA7 and an additional CM3 master.

  The following series has dependencies on Jassi Brar's Mailbox series.
[PATCHv8 0/2] Common Mailbox Framework : 
http://www.spinics.net/lists/kernel/msg1783170.html

  And some additional SDHCI quirks from Vincent Yang.
[PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP : 
http://article.gmane.org/gmane.linux.kernel.mmc/27904

We welcome any comments or questions.
Thanks.

Mollie Wu (8):
  ARM: Add platform support for Fujitsu MB86S7X SoCs
  mmc: sdhci: host: add new f_sdh30
  mmc: core: add manual resume capability
  clk: Add clock driver for mb86s7x
  pinctrl: add driver for MB86S7x
  net: ethernet driver: Fujitsu OGMA
  mailbox: f_mhu: add driver for Fujitsu MHU controller
  of: add Fujitsu vendor prefix

 .../bindings/arm/fujistu/power_domain.txt          |   22 +
 .../bindings/clock/fujitsu,mb86s7x_clk.txt         |   32 +
 .../bindings/gpio/fujitsu,mb86s7x-gpio.txt         |   22 +
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |   36 +
 .../devicetree/bindings/net/fujitsu-ogma.txt       |   43 +
 .../bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt   |   30 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/mb86s70.dtsi                     |  635 ++++++++++
 arch/arm/boot/dts/mb86s70eb.dts                    |   38 +
 arch/arm/boot/dts/mb86s73.dtsi                     |  910 ++++++++++++++
 arch/arm/boot/dts/mb86s73eb.dts                    |   73 ++
 arch/arm/configs/fujitsu_defconfig                 |  156 +++
 arch/arm/mach-mb86s7x/Kconfig                      |   18 +
 arch/arm/mach-mb86s7x/Makefile                     |    2 +
 arch/arm/mach-mb86s7x/board.c                      |   65 +
 arch/arm/mach-mb86s7x/iomap.h                      |   34 +
 arch/arm/mach-mb86s7x/mcpm.c                       |  293 +++++
 arch/arm/mach-mb86s7x/pm_domains.c                 |  237 ++++
 arch/arm/mach-mb86s7x/scb_mhu.c                    |  447 +++++++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-mb86s7x.c                          |  352 ++++++
 drivers/mailbox/Kconfig                            |    7 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/f_mhu.c                            |  227 ++++
 drivers/mmc/core/core.c                            |    4 +
 drivers/mmc/core/sd.c                              |    4 +
 drivers/mmc/host/Kconfig                           |    7 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   |  469 +++++++
 drivers/net/ethernet/fujitsu/Kconfig               |   12 +
 drivers/net/ethernet/fujitsu/Makefile              |    1 +
 drivers/net/ethernet/fujitsu/ogma/Makefile         |    6 +
 drivers/net/ethernet/fujitsu/ogma/ogma.h           |  380 ++++++
 .../ethernet/fujitsu/ogma/ogma_desc_ring_access.c  |  627 ++++++++++
 drivers/net/ethernet/fujitsu/ogma/ogma_ethtool.c   |   95 ++
 .../net/ethernet/fujitsu/ogma/ogma_gmac_access.c   |  295 +++++
 drivers/net/ethernet/fujitsu/ogma/ogma_netdev.c    |  592 +++++++++
 drivers/net/ethernet/fujitsu/ogma/ogma_platform.c  |  333 +++++
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-mb86s7x.c                  | 1281 ++++++++++++++++++++
 include/linux/mmc/host.h                           |   14 +
 include/linux/platform_data/mb86s7x_mbox.h         |  249 ++++
 46 files changed, 8063 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s7x_clk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 Documentation/devicetree/bindings/net/fujitsu-ogma.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/configs/fujitsu_defconfig
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile
 create mode 100644 arch/arm/mach-mb86s7x/board.c
 create mode 100644 arch/arm/mach-mb86s7x/iomap.h
 create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
 create mode 100644 arch/arm/mach-mb86s7x/pm_domains.c
 create mode 100644 arch/arm/mach-mb86s7x/scb_mhu.c
 create mode 100644 drivers/clk/clk-mb86s7x.c
 create mode 100644 drivers/mailbox/f_mhu.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/Makefile
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma.h
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma_desc_ring_access.c
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma_ethtool.c
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma_gmac_access.c
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma_netdev.c
 create mode 100644 drivers/net/ethernet/fujitsu/ogma/ogma_platform.c
 create mode 100644 drivers/pinctrl/pinctrl-mb86s7x.c
 create mode 100644 include/linux/platform_data/mb86s7x_mbox.h

-- 
1.8.1.2
