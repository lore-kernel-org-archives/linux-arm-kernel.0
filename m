From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 Aug 2017 11:37:44 -0700
Subject: [GIT PULL 2/6] Broadcom devicetree changes for 4.14
In-Reply-To: <20170817183748.1450-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
Message-ID: <20170817183748.1450-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/devicetree

for you to fetch changes up to 0173b2cd6948b5b96ac4e8dbc3bcb4dd0b45c296:

  ARM: BCM53573: Specify ports for USB LED for Tenda AC9 (2017-08-17 10:18:07 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes for
4.14, please pull the following:

- Eric moves the bcm2837 DT file from arm64 to arm because it created a maintenance
  problem and would have required either duplication or cross merges

- Stefan changes how the pinmuxing is defined and pushes it at the board level
  to support Raspberry Pi Zero Wireless. He then adds supports for the actual
  Raspberry Pi Zero Wireless board along with binding documentation. Stefan
  also defines a proper SMP enable-method property and binding for BCM2836
  (Raspbery Pi 2)

- Rafal describes the BCM5301X USB ports correctly in Device Tree such that
  it becomes possible to assign them to specific LED triggers (e.g: USB activity).
  He does the same thing for BCM53573 and defines default LED triggers for USB.

- Jon provides a fix for Northstar Plus which consists in correctly defining
  the "dma-coherent" property for peripherals which are DMA coherent. He also
  does a bit of re-arrangement of the USB DT nodes and finally adds USB 3 PHY
  and host controller support for NorthStar Plus

- Florian adds support for Broadcom's BCM947189ACDBMR reference board which is
  based on BCM47182/53573 and which supports external MoCA (BCM6802)

- Ray fixes the wrong UART2 base address for Cygnus

- Scott moves the v3d node in the proper unit address order and defines the correct
  UART alias for the BCM91130_entphn reference board to be UART3

- Jason adds the DT node for the Cygnus Cortex-A9 Performance Monitoring Unit

- Jonathan adds a bunch of additional peripherals to the Cygnus DTS include file:
  SDHCI, Keypad, SPI, DMA and pinmux configurations

- Raveendra adds the Cygnus OHCI and EHCI Device Tree nodes

----------------------------------------------------------------
Eric Anholt (1):
      ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64 to arm.

Florian Fainelli (3):
      ARM: dts: BCM53573: Add Broadcom BCM947189ACDBMR board support
      Merge tag 'bcm2835-dt-next-2017-08-07' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-08-15' into devicetree/next

Jason Uy (1):
      ARM: dts: cygnus: Enable Performance Monitoring Unit

Jon Mason (3):
      ARM: dts: NSP: Add dma-coherent to relevant DT entries
      ARM: dts: NSP: Rearrage USB entries
      ARM: dts: NSP: Add USB3 and USB3 PHY to NSP

Jonathan Richardson (1):
      ARM: dts: cygnus: Add additional peripherals to dtsi

Rafa? Mi?ecki (3):
      ARM: dts: BCM5301X: Specify USB ports for each controller
      ARM: dts: BCM5301X: Specify USB ports for USB LEDs of few devices
      ARM: BCM53573: Specify ports for USB LED for Tenda AC9

Raveendra Padasalagi (1):
      ARM: dts: cygnus: Add generic-ehci/ohci nodes

Ray Jui (1):
      ARM: dts: cygnus: Fix incorrect UART2 register base

Scott Branden (2):
      ARM: dts: cygnus: place v3d in proper address ordered location
      ARM: dts: cygnus: add serial0 alias for uart3 on bcm91130_entphn

Stefan Wahren (5):
      ARM: bcm283x: Define UART pinmuxing on board level
      dt-bindings: bcm: Add Raspberry Pi Zero W
      ARM: dts: bcm2835: Add Raspberry Pi Zero W
      dt-bindings: arm: add SMP enable-method for BCM2836
      ARM: dts: bcm283x: Add 32-bit enable method for SMP

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 149 +++++++++++++++++++--
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  59 ++++++--
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   6 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           | 139 +++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   6 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   6 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  52 ++++++-
 .../dts/broadcom => arm/boot/dts}/bcm2837.dtsi     |   1 +
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   3 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   6 +
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |   4 +
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   5 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   3 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |   3 +
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts           |   2 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  34 +++++
 arch/arm/boot/dts/bcm53573.dtsi                    |   4 +
 arch/arm/boot/dts/bcm911360_entphn.dts             |   7 +-
 arch/arm/boot/dts/bcm947189acdbmr.dts              |  97 ++++++++++++++
 arch/arm/boot/dts/bcm958522er.dts                  |   8 ++
 arch/arm/boot/dts/bcm958525er.dts                  |   8 ++
 arch/arm/boot/dts/bcm958525xmc.dts                 |   8 ++
 arch/arm/boot/dts/bcm958622hr.dts                  |   8 ++
 arch/arm/boot/dts/bcm958623hr.dts                  |   8 ++
 arch/arm/boot/dts/bcm958625hr.dts                  |   8 ++
 arch/arm/boot/dts/bcm958625k.dts                   |   8 ++
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi      |   1 -
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |  42 +-----
 .../boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi    |   1 -
 .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi    |   1 -
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi          |   1 -
 41 files changed, 651 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
 rename arch/{arm64/boot/dts/broadcom => arm/boot/dts}/bcm2837.dtsi (96%)
 create mode 100644 arch/arm/boot/dts/bcm947189acdbmr.dts
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
