From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Apr 2015 15:33:45 -0700
Subject: [PATCH 0/7] ARM: BCM63xx: SMP support
Message-ID: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
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

Florian Fainelli (7):
  Documentation: DT: Add Broadcom BCM63138 PMB binding
  ARM: dts: BCM63xx: Add PMB busses nodes
  Documentation: DT: Document SMP DT nodes and properties for BCM63138
  ARM: dts: BCM63xx: Add SMP nodes and required properties
  ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
  ARM: BCM63xx: Add secondary CPU PMB initialization sequence
  ARM: BCM63xx: Add SMP support for BCM63138

 .../devicetree/bindings/arm/bcm/bcm63138.txt       |  42 ++++
 .../bindings/reset/brcm,bcm63138-pmb.txt           |  19 ++
 arch/arm/boot/dts/bcm63138.dtsi                    |  20 ++
 arch/arm/mach-bcm/Makefile                         |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S                |  23 +++
 arch/arm/mach-bcm/bcm63xx_pmb.c                    | 222 +++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.c                    | 171 ++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.h                    |   9 +
 include/linux/bcm63xx_pmb.h                        |  76 +++++++
 9 files changed, 588 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_pmb.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h
 create mode 100644 include/linux/bcm63xx_pmb.h

-- 
2.1.0
