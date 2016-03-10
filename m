From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:41 -0800
Subject: [PATCH 00/18] ARM: vf610: Suspend/resume with self-refresh mode
Message-ID: <1457576219-7971-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a reworked and extended respin of an older patchset posted
back in 2014:
http://lkml.iu.edu/hypermail/linux/kernel/1409.2/03734.html

This implementation supports Vybrids STOP (standby) and LPSTOP2
mode (mem). Only the latter puts the memory in self-refresh mode
and the SoC in a deep sleep state. However, self-refresh is only
supported if external pull-ups/downs are populated (which not
all hardware revisions have in place), therefor this patchset also
introduces a device tree property to denote whether memory can be
put into self-refresh mode or not.

The LPSTOP2 implementation is similar to the i.MX 6 implementation:
Entering and resuming from self-refresh mode is implemented in
assembler, and the function is copied to SRAM while entering suspend
mode.

There are several fixes and extensions necessary to make suspend
actually working, mainly because most blocks loose its state in
LPSTOP2 mode.

Feedback welcome! Especially the linking between the GPIOs of the 
WKPU unit (which allows to use some GPIOs as wake-up source) and
the regular GPIO block seems rather hacky...

The code has been tested on a Colibri VF50 and VF61. Currently
there is an issue with USB Host not correctly restoring after
resume which could not yet been resolved.

Stefan Agner (18):
  irqchip: vf610-gpc: add Vybrid GPC IRQ controller
  ARM: dts: vf610: add GPC as new interrupt parent
  ARM: dts: vf610-colibri: GPIO wakeup key
  ARM: dts: vf610: add on-chip SRAM
  ARM: dts: vf610: add modules required for PM
  ARM: imx: clk-gate2: allow custom gate configuration
  ARM: imx: clk-vf610: leave DDR clock on
  ARM: clk: add WKPU unit
  ARM: vf610: clk: add suspend/resume support
  tty: serial: fsl_lpuart: support suspend/resume
  pinctrl: pinctrl-imx: implement suspend/resume
  gpio: vf610: add system PM suspend/resume
  ARM: dts: vf610: add WKPU connection to GPIO
  gpio: vf610: add support for WKPU unit
  ARM: vf610: PM: initial suspend/resume support
  ARM: vf610: PM: enable Suspend-to-RAM only if hardware fixes are in
    place
  Documentation: dt: add Vybrid DDR memory controller bindings
  ARM: vf610: PM: enable SNVS access

 .../bindings/arm/freescale/fsl,vf610-ddrmc.txt     |  23 +
 .../devicetree/bindings/gpio/gpio-vf610.txt        |   6 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  22 +
 arch/arm/boot/dts/vfxxx.dtsi                       |  74 ++-
 arch/arm/mach-imx/Makefile                         |   3 +
 arch/arm/mach-imx/common.h                         |  10 +
 arch/arm/mach-imx/mach-vf610.c                     |   8 +
 arch/arm/mach-imx/pm-vf610.c                       | 649 +++++++++++++++++++++
 arch/arm/mach-imx/suspend-vf610.S                  | 448 ++++++++++++++
 drivers/clk/imx/clk-gate2.c                        |   7 +-
 drivers/clk/imx/clk-vf610.c                        |  83 ++-
 drivers/clk/imx/clk.h                              |  13 +-
 drivers/gpio/gpio-vf610.c                          | 188 ++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-vf610-gpc.c                    | 138 +++++
 drivers/pinctrl/freescale/pinctrl-imx.c            |  63 ++
 drivers/pinctrl/freescale/pinctrl-imx.h            |   3 +
 drivers/pinctrl/freescale/pinctrl-vf610.c          |   6 +
 drivers/tty/serial/fsl_lpuart.c                    |  16 +-
 include/dt-bindings/clock/vf610-clock.h            |   4 +-
 20 files changed, 1750 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-ddrmc.txt
 create mode 100644 arch/arm/mach-imx/pm-vf610.c
 create mode 100644 arch/arm/mach-imx/suspend-vf610.S
 create mode 100644 drivers/irqchip/irq-vf610-gpc.c

-- 
2.7.2
