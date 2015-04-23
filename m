From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:09:53 -0700
Subject: [PATCH v2 0/9] ARM: BCM63xx: SMP support (v2)
Message-ID: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series implements SMP support on the Broadcom BCM63138 DSL platform.

There is a number of decisions being made here to simplify things:

- the power on sequence for the secondary CPU is a bit of low-level code that
  uses the on-chip PMB bus, which will later be supported as a proper reset
  controller driver, it was considered first to use a reset controller for
  that, but this was later dropped because:
	- reset controllers cannot be utilized at SMP init time (too early)
	- moving reset controllers init earlier has been rejected
	- the second CPU power on sequence is fairly specific, even within
	  the context of the BCM63138 SoC, no other peripheral has that
	  level of detail

- VFP needs to be disabled when SMP is used because the second CPU does not
  have any VFP unit and will just hang doing a VFP/NEON operation

Changes in v2:

- introduced a helper function: vfp_disable() as recommended by Russell
- fixed the DT binding for the PMB controllers to account for the number
  of zones as a second cell, and drop the bus identifier since it is
  implicit with the phandle already


Let me know how you would want to approach the merge of the ARM VFP parts
if that is okay to get them merged via my tree and submitted as a Broadcom
pull request later on.

Florian Fainelli (9):
  Documentation: DT: Add Broadcom BCM63138 PMB binding
  ARM: dts: BCM63xx: Add PMB busses nodes
  Documentation: DT: Document SMP DT nodes and properties for BCM63138
  ARM: dts: BCM63xx: Add SMP nodes and required properties
  ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
  ARM: BCM63xx: Add secondary CPU PMB initialization sequence
  ARM: vfp: Add include guards
  ARM: vfp: Add vfp_disable for problematic platforms
  ARM: BCM63xx: Add SMP support for BCM63138

 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  |  42 ++++
 .../bindings/reset/brcm,bcm63138-pmb.txt           |  19 ++
 arch/arm/boot/dts/bcm63138.dtsi                    |  20 ++
 arch/arm/include/asm/vfp.h                         |   9 +
 arch/arm/mach-bcm/Makefile                         |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S                |  23 +++
 arch/arm/mach-bcm/bcm63xx_pmb.c                    | 221 +++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.c                    | 170 ++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.h                    |   9 +
 arch/arm/vfp/vfpmodule.c                           |  13 ++
 include/linux/bcm63xx_pmb.h                        |  76 +++++++
 11 files changed, 608 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_pmb.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h
 create mode 100644 include/linux/bcm63xx_pmb.h

-- 
2.1.0
