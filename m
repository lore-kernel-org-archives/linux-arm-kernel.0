From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:02:17 +0100
Subject: [PATCH 00/16] ARM: various multi-mach patches
Message-ID: <20101215020216.GS15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set eliminates various dependencies on per-mach include
directories, with the end goal of being able to compile support for
multiple platforms into the same kernel image.

After this patch set, there are a bunch of such dependencies left,
which are addressed by other patches in my local tree that are to be
submitted shortly (possibly too late for the merge window, but that's
OK -- I can hold onto them for the next merge window).

Comments appreciated!



Eric Miao (1):
  ARM: Make PCIBIOS_* into global variables.

Lennert Buytenhek (15):
  ARM: Remove dependency of plat-orion time code on mach directory includes.
  ARM: Remove dependency of plat-orion GPIO code on mach directory includes.
  ARM: Remove various spurious mach dir includes.
  ARM: Dove: Remove PXA compatibility IRQ defines.
  ARM: Always reassign PCI bus numbers.
  ARM: iop13xx: Make PCIBIOS_MIN_* constants.
  ARM: at91: Switch over to gpiolib ->to_irq() and __gpio_to_irq().
  ARM: ep93xx: Switch over to gpiolib ->to_irq() and __gpio_to_irq().
  ARM: gemini: Switch over to gpiolib ->to_irq() and __gpio_to_irq().
  ARM: mxc: Switch over to gpiolib ->to_irq() and __gpio_to_irq().
  ARM: pxa: Provide gpiolib ->to_irq() implementation.
  ARM: mmp: Switch over to gpiolib's version of __gpio_to_irq().
  ARM: pxa: Switch over to gpiolib's version of __gpio_to_irq().
  ARM: sa1100: Switch over to gpiolib ->to_irq() and __gpio_to_irq().
  ARM: w90x900: Switch over to gpiolib ->to_irq() and __gpio_to_irq().

 arch/arm/include/asm/mach/pci.h                   |    2 +-
 arch/arm/include/asm/mc146818rtc.h                |    1 -
 arch/arm/include/asm/pci.h                        |    9 +-
 arch/arm/kernel/bios32.c                          |   12 +-
 arch/arm/mach-at91/gpio.c                         |    7 +
 arch/arm/mach-at91/include/mach/gpio.h            |    6 +-
 arch/arm/mach-bcmring/include/mach/hardware.h     |    2 -
 arch/arm/mach-cns3xxx/include/mach/hardware.h     |    6 +-
 arch/arm/mach-cns3xxx/pcie.c                      |    4 +-
 arch/arm/mach-dove/common.c                       |    5 +-
 arch/arm/mach-dove/include/mach/bridge-regs.h     |    4 -
 arch/arm/mach-dove/include/mach/dove.h            |    3 +-
 arch/arm/mach-dove/include/mach/gpio.h            |   40 --
 arch/arm/mach-dove/include/mach/hardware.h        |    5 +-
 arch/arm/mach-dove/include/mach/irqs.h            |    7 +-
 arch/arm/mach-dove/irq.c                          |   27 +-
 arch/arm/mach-dove/pcie.c                         |    3 +-
 arch/arm/mach-ep93xx/gpio.c                       |   31 +-
 arch/arm/mach-ep93xx/include/mach/gpio.h          |    8 +-
 arch/arm/mach-ep93xx/include/mach/hardware.h      |    2 -
 arch/arm/mach-ep93xx/include/mach/irqs.h          |    4 +
 arch/arm/mach-footbridge/cats-pci.c               |    8 +-
 arch/arm/mach-footbridge/ebsa285-pci.c            |    8 +-
 arch/arm/mach-footbridge/include/mach/hardware.h  |    6 +-
 arch/arm/mach-footbridge/netwinder-pci.c          |    8 +-
 arch/arm/mach-footbridge/personal-pci.c           |    8 +-
 arch/arm/mach-gemini/gpio.c                       |    6 +
 arch/arm/mach-gemini/include/mach/gpio.h          |    2 +-
 arch/arm/mach-integrator/include/mach/hardware.h  |    6 +-
 arch/arm/mach-integrator/pci.c                    |    8 +-
 arch/arm/mach-iop13xx/include/mach/hardware.h     |    8 +-
 arch/arm/mach-iop13xx/iq81340mc.c                 |    3 +-
 arch/arm/mach-iop13xx/iq81340sc.c                 |    3 +-
 arch/arm/mach-iop13xx/pci.c                       |    5 -
 arch/arm/mach-iop32x/em7210.c                     |    6 +-
 arch/arm/mach-iop32x/glantank.c                   |    6 +-
 arch/arm/mach-iop32x/include/mach/hardware.h      |    5 +-
 arch/arm/mach-iop32x/iq31244.c                    |    9 +-
 arch/arm/mach-iop32x/iq80321.c                    |    6 +-
 arch/arm/mach-iop32x/n2100.c                      |    6 +-
 arch/arm/mach-iop33x/include/mach/hardware.h      |    5 +-
 arch/arm/mach-iop33x/iq80331.c                    |    6 +-
 arch/arm/mach-iop33x/iq80332.c                    |    6 +-
 arch/arm/mach-ixp2000/enp2611.c                   |    6 +-
 arch/arm/mach-ixp2000/include/mach/hardware.h     |    6 +-
 arch/arm/mach-ixp2000/ixdp2400.c                  |    6 +-
 arch/arm/mach-ixp2000/ixdp2800.c                  |    4 +-
 arch/arm/mach-ixp2000/ixdp2x01.c                  |    6 +-
 arch/arm/mach-ixp23xx/include/mach/hardware.h     |    6 +-
 arch/arm/mach-ixp23xx/ixdp2351.c                  |    6 +-
 arch/arm/mach-ixp23xx/roadrunner.c                |    6 +-
 arch/arm/mach-ixp4xx/avila-pci.c                  |    7 +-
 arch/arm/mach-ixp4xx/common-pci.c                 |    4 +-
 arch/arm/mach-ixp4xx/coyote-pci.c                 |    7 +-
 arch/arm/mach-ixp4xx/dsmg600-pci.c                |    7 +-
 arch/arm/mach-ixp4xx/fsg-pci.c                    |    8 +-
 arch/arm/mach-ixp4xx/gateway7001-pci.c            |    7 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c                 |    8 +-
 arch/arm/mach-ixp4xx/gtwx5715-pci.c               |    6 +-
 arch/arm/mach-ixp4xx/include/mach/hardware.h      |   12 +-
 arch/arm/mach-ixp4xx/include/mach/io.h            |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-pci.c                |    7 +-
 arch/arm/mach-ixp4xx/ixdpg425-pci.c               |    7 +-
 arch/arm/mach-ixp4xx/nas100d-pci.c                |    7 +-
 arch/arm/mach-ixp4xx/nslu2-pci.c                  |    7 +-
 arch/arm/mach-ixp4xx/vulcan-pci.c                 |    8 +-
 arch/arm/mach-ixp4xx/wg302v2-pci.c                |    7 +-
 arch/arm/mach-kirkwood/common.c                   |    6 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    3 -
 arch/arm/mach-kirkwood/include/mach/gpio.h        |   29 --
 arch/arm/mach-kirkwood/include/mach/hardware.h    |    5 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |    2 +
 arch/arm/mach-kirkwood/irq.c                      |   22 +-
 arch/arm/mach-kirkwood/mpp.c                      |    3 -
 arch/arm/mach-kirkwood/pcie.c                     |    4 +-
 arch/arm/mach-ks8695/include/mach/hardware.h      |    6 +-
 arch/arm/mach-ks8695/pci.c                        |    3 +-
 arch/arm/mach-loki/common.c                       |    6 +-
 arch/arm/mach-loki/include/mach/bridge-regs.h     |    5 -
 arch/arm/mach-mmp/aspenite.c                      |    4 +-
 arch/arm/mach-mmp/flint.c                         |    4 +-
 arch/arm/mach-mmp/include/mach/gpio.h             |    3 +-
 arch/arm/mach-mmp/mmp2.c                          |    3 +-
 arch/arm/mach-mmp/pxa168.c                        |    3 +-
 arch/arm/mach-mmp/pxa910.c                        |    3 +-
 arch/arm/mach-mmp/tavorevb.c                      |    4 +-
 arch/arm/mach-mmp/teton_bga.c                     |    2 +-
 arch/arm/mach-mv78xx0/common.c                    |    5 +-
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  |    4 -
 arch/arm/mach-mv78xx0/include/mach/gpio.h         |   31 --
 arch/arm/mach-mv78xx0/include/mach/hardware.h     |    5 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h      |    1 +
 arch/arm/mach-mv78xx0/irq.c                       |   22 +-
 arch/arm/mach-mv78xx0/mpp.c                       |    3 -
 arch/arm/mach-mv78xx0/pcie.c                      |    4 +-
 arch/arm/mach-orion5x/common.c                    |    7 +-
 arch/arm/mach-orion5x/db88f5281-setup.c           |    7 +-
 arch/arm/mach-orion5x/dns323-setup.c              |    7 +-
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    6 +-
 arch/arm/mach-orion5x/include/mach/gpio.h         |   28 --
 arch/arm/mach-orion5x/include/mach/hardware.h     |    7 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h      |    1 +
 arch/arm/mach-orion5x/irq.c                       |   19 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c         |    4 +-
 arch/arm/mach-orion5x/mpp.c                       |    3 -
 arch/arm/mach-orion5x/mss2-setup.c                |    7 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c      |    4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c       |    4 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c           |    7 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c      |    4 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c    |    7 +-
 arch/arm/mach-orion5x/ts209-setup.c               |    7 +-
 arch/arm/mach-orion5x/ts409-setup.c               |    7 +-
 arch/arm/mach-orion5x/wnr854t-setup.c             |    7 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c          |    7 +-
 arch/arm/mach-pxa/capc7117.c                      |   12 +-
 arch/arm/mach-pxa/cm-x270.c                       |    2 +-
 arch/arm/mach-pxa/cm-x2xx-pci.c                   |    8 +-
 arch/arm/mach-pxa/colibri-pxa270.c                |    6 +-
 arch/arm/mach-pxa/colibri-pxa300.c                |    4 +-
 arch/arm/mach-pxa/colibri-pxa320.c                |    4 +-
 arch/arm/mach-pxa/corgi.c                         |    2 +-
 arch/arm/mach-pxa/hx4700.c                        |   18 +-
 arch/arm/mach-pxa/icontrol.c                      |    8 +-
 arch/arm/mach-pxa/include/mach/csb726.h           |    4 +-
 arch/arm/mach-pxa/include/mach/gpio.h             |    3 +-
 arch/arm/mach-pxa/include/mach/hardware.h         |    5 +-
 arch/arm/mach-pxa/littleton.c                     |    2 +-
 arch/arm/mach-pxa/magician.c                      |    8 +-
 arch/arm/mach-pxa/mioa701.c                       |    8 +-
 arch/arm/mach-pxa/mxm8x10.c                       |    4 +-
 arch/arm/mach-pxa/poodle.c                        |    2 +-
 arch/arm/mach-pxa/pxa25x.c                        |    6 +-
 arch/arm/mach-pxa/pxa27x.c                        |    3 +-
 arch/arm/mach-pxa/pxa3xx.c                        |    3 +-
 arch/arm/mach-pxa/raumfeld.c                      |    8 +-
 arch/arm/mach-pxa/saar.c                          |    6 +-
 arch/arm/mach-pxa/spitz.c                         |    2 +-
 arch/arm/mach-pxa/stargate2.c                     |    4 +-
 arch/arm/mach-pxa/tavorevb.c                      |    4 +-
 arch/arm/mach-pxa/tavorevb3.c                     |    2 +-
 arch/arm/mach-pxa/tosa.c                          |    4 +-
 arch/arm/mach-pxa/viper.c                         |   12 +-
 arch/arm/mach-pxa/vpac270.c                       |    4 +-
 arch/arm/mach-pxa/z2.c                            |    2 +-
 arch/arm/mach-pxa/zeus.c                          |   20 +-
 arch/arm/mach-sa1100/gpio.c                       |    9 +
 arch/arm/mach-sa1100/include/mach/gpio.h          |    3 +-
 arch/arm/mach-shark/include/mach/hardware.h       |    5 +-
 arch/arm/mach-shark/pci.c                         |    8 +-
 arch/arm/mach-tegra/include/mach/hardware.h       |    6 +-
 arch/arm/mach-tegra/pcie.c                        |    8 +-
 arch/arm/mach-versatile/include/mach/hardware.h   |    6 +-
 arch/arm/mach-versatile/pci.c                     |    4 +-
 arch/arm/mach-w90x900/gpio.c                      |    6 +
 arch/arm/mach-w90x900/include/mach/gpio.h         |    6 +-
 arch/arm/plat-mxc/gpio.c                          |    9 +
 arch/arm/plat-mxc/include/mach/gpio.h             |    2 +-
 arch/arm/plat-orion/gpio.c                        |  475 ++++++++++++++-------
 arch/arm/plat-orion/include/plat/gpio.h           |    5 +-
 arch/arm/plat-orion/include/plat/time.h           |    5 +-
 arch/arm/plat-orion/pcie.c                        |    1 -
 arch/arm/plat-orion/time.c                        |  123 ++++--
 arch/arm/plat-pxa/gpio.c                          |   19 +-
 arch/arm/plat-pxa/include/plat/gpio.h             |    5 +-
 165 files changed, 966 insertions(+), 743 deletions(-)
