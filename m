From: kapilh@broadcom.com (Kapil Hali)
Date: Wed, 14 Oct 2015 13:46:57 -0400
Subject: [PATCH 0/3] SMP support for Broadcom NSP
Message-ID: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds SMP support for Broadcom's Northstar Plus SoC.

There are similar SMP enablement methods for many ARMv7 bsed SoCs.
BCM NSP SoC, has a typical such mechanism - after power-on, the
secondary core is held in a standby state, primary core provides a
startup address for the secondary core and wakes it up. Booting of
the secondary core is serialized using pen_release global variable.

The startup address is programmed at a special register location
which is defined in the device tree using a "secondary-boot-reg"
property in a node whose "enable-method" property matches.

The first patch adds cpu-enable-method in the device tree bindings
documentation. It also updates ARM CPU device tree documentation
with Broadcom Northstar Plus CPU details.

The second patch adds SMP support to the BCM NSP device tree file.

Finally, third patch, enables SMP on BCM NSP. It also consolidates
common SMP handling between BCM NSP and BCM Kona.

This patch series is constructed based on Linux v4.3-rc2.

The source code is available at GITHUB:
https://github.com/Broadcom/cygnus-linux/tree/nsp-smp-v1

Kapil Hali (3):
  dt-bindings: add SMP enable-method for Broadcom NSP
  ARM: dts: add SMP support for Broadcom NSP
  ARM: BCM: Add SMP support for Broadcom NSP

 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       |  36 ++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  33 +++--
 arch/arm/mach-bcm/Kconfig                          |   2 +
 arch/arm/mach-bcm/Makefile                         |   8 +-
 arch/arm/mach-bcm/bcm_nsp.h                        |  19 +++
 arch/arm/mach-bcm/headsmp.S                        |  37 ++++++
 arch/arm/mach-bcm/{kona_smp.c => platsmp.c}        | 142 +++++++++++++++++++--
 8 files changed, 255 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 create mode 100644 arch/arm/mach-bcm/bcm_nsp.h
 create mode 100644 arch/arm/mach-bcm/headsmp.S
 rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (63%)

-- 
2.1.0
