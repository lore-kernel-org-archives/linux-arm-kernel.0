From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:15:54 -0400
Subject: [GIT PULL V5 0/7] ARM: kirkwood/dove/mvebu changes for v3.7
Message-ID: <20120922171554.GE5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Changes from V3/V4 (only one pullrq reached V4).
 - split kirkwood/dt into /dt and /drivers.
 - /drivers now holds pinctrl and gpio
 - dropped ehci-orion dt bindings until next window
 - reworked dependency matrix

Dep tree:

        /--kirkwood/addr_decode--kirkwood/drivers
        |
        |--kirkwood/dt--kirkwood/cleanup--kirkwood/platform_data
        |                                /
        /                 /-------------/
v3.6-rc5--kirkwood/boards-|
                          \--kirkwood/defconfig

Conflicts:
 - If kirkwood/platform_data causes conflicts with other work, it can be
   dropped.
 - When merging /drivers and /defconfig there is a conflict in
   arch/arm/Kconfig, resolution is in /drivers tag message:
    - keep MIGHT_HAVE_PCI
    - keep PLAT_ORION_LEGACY over PLAT_ORION
    - allow add USB_ARCH_HAS_EHCI
    - It should end up like so:

### start ###
config ARCH_DOVE
	bool "Marvell Dove"
	select CPU_V7
	select ARCH_REQUIRE_GPIOLIB
	select GENERIC_CLOCKEVENTS
	select MIGHT_HAVE_PCI
	select NEED_MACH_IO_H
	select PLAT_ORION_LEGACY
	select USB_ARCH_HAS_EHCI
	help
	  Support for the Marvell Dove SoC 88AP510
### end #####

Overall changes from v3.6-rc5:

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git tmp/merge_test

Alan M Butler (1):
      ARM: Kirkwood: Iomega ix2-200 DT support

Andrew Lunn (1):
      Crypto: CESA: Add support for DT based instantiation.

Arnaud Patard (2):
      ARM: Kirkwood: Describe iconnect keys in DT.
      ARM: Kirkwood: Describe iconnect nand in DT.

Jamie Lentin (3):
      hwmon: Add devicetree bindings to gpio-fan
      ARM: kirkwood: Use devicetree to define DNS-32[05] fan
      ARM: kirkwood: Trim excess #includes in board-dnskw.c

Jason Cooper (7):
      ARM: Kirkwood: update defconfig
      ARM: Kirkwood: add DT boards to defconfig
      Merge branch 'kirkwood/boards' into kirkwood/platform_data
      ARM: Kirkwood: board-dockstar: use linux/platform_data/mvsdio.h instead of plat/mvsdio.h   
      ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h
      Merge branch 'kirkwood/defconfig' into tmp/merge_test
      Merge branch 'kirkwood/platform_data' into tmp/merge_test

Russell King (1):
      ARM: Dove: allow PCI to be disabled

Sebastian Hesselbarth (11):
      ARM: kirkwood: DT board setup for Seagate FreeAgent Dockstar
      ARM: kirkwood: DT descriptor for Seagate FreeAgent Dockstar
      ARM: dove: unify clock setup
      ARM: dove: add clock gating control
      ARM: dove: add crypto engine
      ARM: dove: add device tree based machine descriptor
      ARM: dove: add device tree descriptors
      ARM: dove: SolidRun CuBox DT
      pinctrl: mvebu: pinctrl driver core
      pinctrl: mvebu: dove pinctrl driver
      pinctrl: mvebu: kirkwood pinctrl driver

Thomas Petazzoni (38):
      arm: add documentation describing Marvell families of SoC
      arm: mach-dove: use plus instead of or for address definitions
      arm: mach-kirkwood: use plus instead of or for address definitions
      arm: mach-mv78xx0: use plus instead of or for address definitions
      arm: mach-orion5x: use plus instead of or for address definitions
      arm: mach-dove: use IOMEM() for base address definitions
      arm: mach-kirkwood: use IOMEM() for base address definitions
      arm: mach-mv78xx0: use IOMEM() for base address definitions
      arm: mach-orion5x: use IOMEM() for base address definitions
      arm: mach-mvebu: use IOMEM() for base address definitions
      arm: plat-orion: use void __iomem pointers for UART registration functions
      arm: plat-orion: use void __iomem pointers for MPP functions
      arm: plat-orion: use void __iomem pointers for time functions
      arm: plat-orion: use void __iomem pointers for addr-map functions
      arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option
      arm: plat-orion: make bridge_virt_base non-const to support DT use case
      arm: mvebu: add basic address decoding support to Armada 370/XP
      arm: mvebu: add address decoding controller to the DT
      pinctrl: mvebu: add pinctrl driver for Armada 370
      pinctrl: mvebu: add pinctrl driver for Armada XP
      ARM: mvebu: Add pinctrl support to Armada XP SoCs
      ARM: mvebu: Add pinctrl support to Armada 370 SoC
      ARM: mvebu: adjust Armada XP evaluation board DTS
      arm: mvebu: split Kconfig options for Armada 370 and XP
      arm: mvebu: select the pinctrl drivers for Armada 370 and Armada XP platforms   
      gpio: introduce gpio-mvebu driver for Marvell SoCs
      Documentation: add description of DT binding for the gpio-mvebu driver
      arm: mvebu: use GPIO support now that a driver is available
      arm: mvebu: add DT information for GPIO banks on Armada 370 and XP
      arm: mvebu: add gpio support in defconfig
      sound: kirkwood: remove useless <plat/audio.h> include
      sound: kirkwood: move <plat/audio.h> to <linux/platform_data/kirkwood-audio.h>  
      usb: ehci-orion: move <plat/ehci-orion.h> to <linux/platform_data/ehci-orion.h> 
      mmc: mvsdio: move <plat/mvsdio.h> to <linux/platform_data/mvsdio.h>
      dma: mv_xor: move <plat/mv_xor.h> to <linux/platform_data/mv_xor.h>
      mtd: orion_nand: move <plat/orion_nand.h> to <linux/platform_data/orion_nand.h> 
      i2c: mv643xx: move <linux/mv643xx_i2c.h> to <linux/platform_data/mv643xx_i2c.h> 
      net: mv643xx_eth: move <linux/mv643xx_eth.h> to <linux/platform_data/mv643xx_eth.h>

Valentin Longchamp (1):
      ARM: initial DTS support for km_kirkwood

 Documentation/arm/Marvell/README                   |  232 ++++++
 .../devicetree/bindings/crypto/mv_cesa.txt         |   20 +
 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |   53 ++
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   95 +++
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |  100 +++
 .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   72 ++
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |  279 ++++++++
 .../bindings/pinctrl/marvell,mvebu-pinctrl.txt     |   46 ++
 arch/arm/Kconfig                                   |   18 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/armada-370.dtsi                  |   44 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |    4 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   57 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   70 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   70 ++
 arch/arm/boot/dts/dove-cm-a510.dts                 |   38 +
 arch/arm/boot/dts/dove-cubox.dts                   |   42 ++
 arch/arm/boot/dts/dove-dove-db.dts                 |   38 +
 arch/arm/boot/dts/dove.dtsi                        |  143 ++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   10 +
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   57 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   50 ++-
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  105 +++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   29 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   12 +-
 arch/arm/configs/kirkwood_defconfig                |   38 +-
 arch/arm/configs/mvebu_defconfig                   |    2 +
 arch/arm/mach-dove/Kconfig                         |    7 +
 arch/arm/mach-dove/Makefile                        |    4 +-
 arch/arm/mach-dove/Makefile.boot                   |    4 +
 arch/arm/mach-dove/cm-a510.c                       |    2 +-
 arch/arm/mach-dove/common.c                        |  164 ++++-
 arch/arm/mach-dove/common.h                        |    4 +
 arch/arm/mach-dove/dove-db-setup.c                 |    2 +-
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   16 +-
 arch/arm/mach-dove/include/mach/dove.h             |  130 ++--
 arch/arm/mach-dove/include/mach/pm.h               |   54 +-
 arch/arm/mach-dove/irq.c                           |   10 +-
 arch/arm/mach-dove/pcie.c                          |    6 +-
 arch/arm/mach-kirkwood/Kconfig                     |   21 +
 arch/arm/mach-kirkwood/Makefile                    |    3 +
 arch/arm/mach-kirkwood/Makefile.boot               |    3 +
 arch/arm/mach-kirkwood/addr-map.c                  |    3 +-
 arch/arm/mach-kirkwood/board-dnskw.c               |   37 +-
 arch/arm/mach-kirkwood/board-dockstar.c            |   61 ++
 arch/arm/mach-kirkwood/board-dreamplug.c           |    4 +-
 arch/arm/mach-kirkwood/board-dt.c                  |   14 +-
 arch/arm/mach-kirkwood/board-goflexnet.c           |    4 +-
 arch/arm/mach-kirkwood/board-ib62x0.c              |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c            |   49 +--
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |   57 ++
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |   57 ++
 arch/arm/mach-kirkwood/board-lsxl.c                |    2 +-
 arch/arm/mach-kirkwood/board-ts219.c               |    2 +-
 arch/arm/mach-kirkwood/common.c                    |   24 +-
 arch/arm/mach-kirkwood/common.h                    |   18 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c            |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |    4 +-
 arch/arm/mach-kirkwood/dockstar-setup.c            |    4 +-
 arch/arm/mach-kirkwood/guruplug-setup.c            |    4 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   20 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |  116 ++--
 arch/arm/mach-kirkwood/irq.c                       |    9 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c     |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c         |    2 +-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c          |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c              |    4 +-
 arch/arm/mach-kirkwood/pcie.c                      |   12 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c       |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c           |    4 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c          |    4 +-
 arch/arm/mach-kirkwood/t5325-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c               |    5 +-
 arch/arm/mach-mv78xx0/addr-map.c                   |    6 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |   10 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |    2 +-
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   12 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h       |   88 ++--
 arch/arm/mach-mv78xx0/irq.c                        |    9 +-
 arch/arm/mach-mv78xx0/pcie.c                       |   12 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |    2 +-
 arch/arm/mach-mvebu/Kconfig                        |   18 +-
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/addr-map.c                     |  134 ++++
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +-
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h   |    2 +-
 arch/arm/mach-mvebu/include/mach/gpio.h            |    1 +
 arch/arm/mach-orion5x/addr-map.c                   |    3 +-
 arch/arm/mach-orion5x/common.c                     |   14 +-
 arch/arm/mach-orion5x/d2net-setup.c                |    2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |    4 +-
 arch/arm/mach-orion5x/dns323-setup.c               |    4 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    2 +-
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   20 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h       |   60 +-
 arch/arm/mach-orion5x/irq.c                        |    5 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c              |    2 +-
 arch/arm/mach-orion5x/pci.c                        |    6 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c                |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c                |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |    2 +-
 arch/arm/mach-orion5x/tsx09-common.c               |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |    2 +-
 arch/arm/plat-orion/Makefile                       |    9 +-
 arch/arm/plat-orion/addr-map.c                     |   11 +-
 arch/arm/plat-orion/common.c                       |   20 +-
 arch/arm/plat-orion/include/plat/addr-map.h        |    4 +-
 arch/arm/plat-orion/include/plat/audio.h           |    7 -
 arch/arm/plat-orion/include/plat/common.h          |   10 +-
 arch/arm/plat-orion/include/plat/mpp.h             |    2 +-
 arch/arm/plat-orion/include/plat/time.h            |    4 +-
 arch/arm/plat-orion/mpp.c                          |    6 +-
 arch/arm/plat-orion/time.c                         |    8 +-
 drivers/crypto/mv_cesa.c                           |   17 +-
 drivers/dma/mv_xor.c                               |    2 +-
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-mvebu.c                          |  679 ++++++++++++++++++
 drivers/hwmon/gpio-fan.c                           |  120 ++++
 drivers/i2c/busses/i2c-mv64xxx.c                   |    2 +-
 drivers/mmc/host/mvsdio.c                          |    2 +-
 drivers/mtd/nand/orion_nand.c                      |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    2 +-
 drivers/pinctrl/Kconfig                            |   22 +
 drivers/pinctrl/Makefile                           |    5 +
 drivers/pinctrl/pinctrl-armada-370.c               |  421 +++++++++++
 drivers/pinctrl/pinctrl-armada-xp.c                |  468 ++++++++++++
 drivers/pinctrl/pinctrl-dove.c                     |  620 ++++++++++++++++
 drivers/pinctrl/pinctrl-kirkwood.c                 |  472 ++++++++++++
 drivers/pinctrl/pinctrl-mvebu.c                    |  754 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-mvebu.h                    |  192 +++++
 drivers/usb/host/ehci-orion.c                      |    2 +-
 include/linux/mv643xx.h                            |    4 +-
 .../linux/platform_data}/ehci-orion.h              |    6 +-
 include/linux/platform_data/kirkwood-audio.h       |    7 +
 include/linux/{ => platform_data}/mv643xx_eth.h    |    4 +-
 include/linux/{ => platform_data}/mv643xx_i2c.h    |    4 +-
 .../plat => include/linux/platform_data}/mv_xor.h  |    6 +-
 .../plat => include/linux/platform_data}/mvsdio.h  |    6 +-
 .../linux/platform_data}/orion_nand.h              |    6 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c                |    1 -
 158 files changed, 6508 insertions(+), 587 deletions(-)
 create mode 100644 Documentation/arm/Marvell/README
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78230.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78260.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78460.dtsi
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cubox.dts
 create mode 100644 arch/arm/boot/dts/dove-dove-db.dts
 create mode 100644 arch/arm/boot/dts/dove.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-dockstar.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-km_kirkwood.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
 create mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
 create mode 100644 arch/arm/mach-mvebu/addr-map.c
 create mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-orion/include/plat/audio.h
 create mode 100644 drivers/gpio/gpio-mvebu.c
 create mode 100644 drivers/pinctrl/pinctrl-armada-370.c
 create mode 100644 drivers/pinctrl/pinctrl-armada-xp.c
 create mode 100644 drivers/pinctrl/pinctrl-dove.c
 create mode 100644 drivers/pinctrl/pinctrl-kirkwood.c
 create mode 100644 drivers/pinctrl/pinctrl-mvebu.c
 create mode 100644 drivers/pinctrl/pinctrl-mvebu.h
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/ehci-orion.h (78%)
 create mode 100644 include/linux/platform_data/kirkwood-audio.h
 rename include/linux/{ => platform_data}/mv643xx_eth.h (96%)
 rename include/linux/{ => platform_data}/mv643xx_i2c.h (89%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mv_xor.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mvsdio.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/orion_nand.h (82%)
