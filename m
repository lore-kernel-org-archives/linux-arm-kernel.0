From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:13 +0200
Subject: [PATCH 00/17] Suspend to RAM support for Armada XP
Message-ID: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches implement suspend to RAM for the Marvell Armada XP
platform, and specifically for the Armada XP GP board. For now, it
does not implement suspend/resume for all device drivers, it only
implements the core of the suspend/resume functionality: enough to
make sure that the system can enter suspend and resume from suspend,
restart all CPUs, and get back to a shell prompt. Additional work in
individual device drivers will be needed as follow-up patches.

There are two important things to understand about the hardware before
reading this patch series:

 - The Armada XP SoC cannot put itself into a suspend to RAM state. It
   requires an external circuit, which in most cases, is a PIC
   micro-controller, to turn off the SoC. This PIC is connected to the
   SoC using a set of GPIOs, which allow the SoC to talk to the PIC
   and request certain things to be done.

   This means that the Armada XP suspend/resume logic has some
   board-specific code, which is fairly uncommon for suspend/resume
   code in the ARM world.

   We have chosen to represent the PIC and the fact that it's
   connected to the SoC using 3 GPIOs in the Device
   Tree.

 - When exiting from suspend, the SoC is actually powered up again
   completely from scratch, so it goes through the bootloader. The
   kernel has to fill a bootloader-specific structure at a fixed
   physical address to pass information to the bootloader that will
   tell the bootloader to do a resume and therefore jump back directly
   into the kernel resume entry point, instead of doing a normal boot.

 - The bootloader has to reconfigure the DRAM controller, which
   involves executing some DDR3 training code that has the unfortunate
   side effect of overwriting the first 10 KB of each DRAM
   chip-select. We therefore have to ensure that the kernel does not
   use the first 10 KB of each DRAM chip select.

So, in sequence:

 * PATCH 1 to 3 are mainly preparation patches: Device Tree binding
   documentation, fixing an errata of the Armada XP, doing a minor
   improvement in the irqchip driver.

 * PATCH 4 to 9 add suspend/resume support to some core drivers:
   irqchip, clocksource, gpio, mvebu-mbus and clock.

 * PATCH 10 implements the core of the SoC suspend/resume logic.

 * PATCH 11 makes sure the first 10 KB of each DRAM chip select isn't
   used by the kernel.

 * PATCH 12 implements the board-specific suspend/resume logic,
   especially talking with the PIC micro-controller over GPIOs.

 * PATCH 13 and 14 make some other additional changes to the Armada XP
   SoC support to make suspend/resume work properly.

 * PATCH 15 to 17 modify the Armada XP and Armada XP GP Device Tree
   description to add the relevant hardware blocks that are needed for
   suspend/resume: description of the PIC micro-controller and the 3
   GPIOs connecting it to the SoC, an additional set of the register
   for mvebu-mbus, and the registers for the SDRAM controller.

Best regards,

Thomas

Nadav Haklai (1):
  ARM: mvebu: enable strex backoff delay

Thomas Petazzoni (16):
  Documentation: dt-bindings: minimal documentation for MVEBU SDRAM
    controller
  irqchip: irq-armada-370-xp: use proper return value for
    ->set_affinity()
  irqchip: irq-armada-370-xp: suspend/resume support
  clocksource: time-armada-370-xp: add suspend/resume support
  gpio: mvebu: add suspend/resume support
  bus: mvebu-mbus: suspend/resume support
  bus: mvebu-mbus: provide a mechanism to save SDRAM window
    configuration
  clk: mvebu: add suspend/resume for gatable clocks
  ARM: mvebu: implement suspend/resume support for Armada XP
  ARM: mvebu: reserve the first 10 KB of each memory bank for
    suspend/resume
  ARM: mvebu: Armada XP GP specific suspend/resume code
  ARM: mvebu: make sure MMU is disabled in armada_370_xp_cpu_resume
  ARM: mvebu: synchronize secondary CPU clocks on resume
  ARM: mvebu: add suspend/resume DT information for Armada XP GP
  ARM: mvebu: adjust mbus controller description on Armada 370/XP
  ARM: mvebu: add SDRAM controller description for Armada XP

 .../devicetree/bindings/bus/mvebu-mbus.txt         |  17 +-
 .../memory-controllers/mvebu-sdram-controller.txt  |  21 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   3 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |  19 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   5 +
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/board-v7.c                     |  51 +++++
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/platsmp.c                      |  31 ++-
 arch/arm/mach-mvebu/pm-board.c                     | 134 +++++++++++++
 arch/arm/mach-mvebu/pm.c                           | 220 +++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   1 +
 arch/arm/mach-mvebu/pmsu_ll.S                      |   8 +
 arch/arm/mm/proc-v7.S                              |   2 -
 drivers/bus/mvebu-mbus.c                           | 181 ++++++++++++++++-
 drivers/clk/mvebu/common.c                         |  30 ++-
 drivers/clocksource/time-armada-370-xp.c           |  25 +++
 drivers/gpio/gpio-mvebu.c                          |  99 ++++++++++
 drivers/irqchip/irq-armada-370-xp.c                |  54 ++++-
 include/linux/mbus.h                               |   1 +
 20 files changed, 871 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
 create mode 100644 arch/arm/mach-mvebu/pm-board.c
 create mode 100644 arch/arm/mach-mvebu/pm.c

-- 
2.0.0
