From: kapilh@broadcom.com (Kapil Hali)
Date: Fri, 4 Dec 2015 15:23:26 -0500
Subject: [PATCH v5 0/5] SMP support for Broadcom NSP
Message-ID: <1449260611-24417-1-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v5:
* Made 'enable-method' for SMP per 'cpu' core instead of 'cpus'
node, in the DT files for BCM NSP and BCM4708.

Change in v4:
* Cleaned up kona_smp.c and associated DT file.
* Corrected documentation for DT bindings.
* Corrected secondary-boot-reg entry for bcm4708 DT file.

Change in v3:
* Fixed patch subject from RESEND PATCH to PATCH
* Deleted arch/arm/mach-bcm/bcm_nsp.h file
* Removed inclusion of header file bcm_nsp.h in platsmp.c
* Removed unused variable 'timeout' in nsp_boot_secondary()

Changes in v2:
Removed the pen_holding method of SMP bringup for NSP SoC and
replaced it with simple wakeup of secondary core using ARM IPI.


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

The third patch, enables SMP on BCM NSP. It also consolidates
common SMP handling between BCM NSP and BCM Kona.

The final patch, enables SMP on BCM 4708 and this patch is pulled
in from Jon Mason's patch from the mailing list.

This patch series is constructed based on Linux v4.4-rc1.

The source code is available at GITHUB:
https://github.com/Broadcom/cygnus-linux/tree/nsp-smp-v2


Jon Mason (1):
  ARM: BCM: Add SMP support for Broadcom 4708

Kapil Hali (4):
  dt-bindings: add SMP enable-method for Broadcom NSP
  ARM: BCM: Clean up SMP support for Broadcom Kona
  ARM: dts: Add SMP support for Broadcom NSP
  ARM: BCM: Add SMP support for Broadcom NSP

 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       |  39 ++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  33 +++--
 arch/arm/boot/dts/bcm11351.dtsi                    |   2 +-
 arch/arm/boot/dts/bcm21664.dtsi                    |   2 +-
 arch/arm/boot/dts/bcm4708.dtsi                     |   2 +
 arch/arm/mach-bcm/Kconfig                          |   3 +
 arch/arm/mach-bcm/Makefile                         |  11 +-
 arch/arm/mach-bcm/{kona_smp.c => platsmp.c}        | 144 +++++++++++++++++----
 9 files changed, 193 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (63%)

-- 
2.1.0
