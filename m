From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 12:01:11 -0700
Subject: [GIT PULL 1/2] Broadcom soc changes for 4.15 (part 1)
Message-ID: <20170925190112.3915-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/soc

for you to fetch changes up to c14963521502b237a6817aceda6f3379296db75c:

  ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping (2017-09-25 11:56:04 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC/Kconfig changes for 4.15
please pull the following:

- Danilo removes the clock provider driver stubs which are no longer needed
  now that we have a proper CPRMAN clock provider driver

- Stefan moves the SMP startup code for BCM2836 from the interrupt controller
  driver down to where it belongs in the architecture code, this was requested
  by Marc Zyngier before comitting any fixes to that code

- Phil provides a fix for a future Raspberry Pi firmware which will make the
  secondary cores wait for an event and therefore requires the CPU onlining
  other cores to send such event (along with the appropriate barrier)

- Florian fixes the BRCMSTB UART debug stub to work correctly when using an
  ARM BE8 kernel since there were some missing register read swapping needed

----------------------------------------------------------------
Danilo Krummrich (1):
      clk: bcm2835: remove remains from stub clk driver

Florian Fainelli (2):
      Merge tag 'bcm2835-soc-next-2017-08-24' into soc/next
      ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping

Phil Elwell (1):
      ARM: bcm2836: Send event when onlining other cores

Stefan Wahren (1):
      irqchip: bcm2836: Move SMP startup code to arch/arm (v2)

 arch/arm/include/debug/brcmstb.S    |  3 ++
 arch/arm/mach-bcm/Makefile          |  5 +++
 arch/arm/mach-bcm/board_bcm2835.c   | 11 ++----
 arch/arm/mach-bcm/platsmp.c         | 38 ++++++++++++++++++
 arch/arm/mach-bcm/platsmp.h         | 10 +++++
 drivers/clk/bcm/clk-bcm2835-aux.c   |  1 -
 drivers/clk/bcm/clk-bcm2835.c       | 30 --------------
 drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
 include/linux/clk/bcm2835.h         | 24 -----------
 include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
 10 files changed, 132 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/mach-bcm/platsmp.h
 delete mode 100644 include/linux/clk/bcm2835.h
 create mode 100644 include/linux/irqchip/irq-bcm2836.h
