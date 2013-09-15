From: sre@debian.org (Sebastian Reichel)
Date: Sun, 15 Sep 2013 22:44:13 +0200
Subject: [RFCv2 0/3] OMAP SSI driver
Message-ID: <1379277856-24571-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second round of the OMAP SSI driver patches.

In this round I added/fixed:
- Usage of runtime PM
  Previously runtime PM was only used to enable/disable the involved
  clocks. Now the driver makes use of resume/suspend callbacks, which
  simplified its code (the driver did its own reference counting).
- Removal of deprecated IRQF_DISABLED flag from irq requests
- HWMOD: set SSI parent to L4-Core instead of L3
  I checked the public OMAP3 TRM, which assigns the address space used
  by the driver as reserved L4-Core address space.
- HWMOD: removed data, which will be specified via Device Tree
- Change omap_ssi_port.wktest and omap_ssi_port.wkin_cken from
  "unsigned int" to "bool"
- Change omap_ssi_port.wk_refcount from "int" to "unsigned int"
- Convert __raw_read* to read*_relaxed / write*_relaxed
- Removal of involved platform and board code
- Split driver into omap_ssi.c and omap_ssi_port.c
  This changes helps in making the DT interface cleaner.
- Creation & Documentation of DT bindings

TODO:
- Central Message Queue
  I did not yet implement a central message queue in the HSI framework.
  I would prefer to do this after SSI is working in the mainline kernel,
  since that makes testing easier.
- HSI client registration via DT
  This needs changes in the HSI framework, which currently assumes,
  that clients are registered via board support code. This is more
  or less independent of the controller and should be added in an
  independent patchset IMHO.

Version 1 (*) of the patchset: https://lkml.org/lkml/2013/8/11/67

(*) There have been patchsets send out by Carlos before my RFCv1,
    see RFCv1 for details.

-- Sebastian

Sebastian Reichel (3):
  ARM: OMAP2+: hwmod-data: Add SSI information
  ARM: OMAP2+: HSI: Introduce OMAP SSI driver
  ARM: dts: N900: Add SSI information

 Documentation/devicetree/bindings/hsi/omap_ssi.txt |   73 ++
 arch/arm/boot/dts/omap3-n900.dts                   |    8 +
 arch/arm/boot/dts/omap34xx.dtsi                    |   49 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   48 +
 drivers/hsi/Kconfig                                |    1 +
 drivers/hsi/Makefile                               |    1 +
 drivers/hsi/controllers/Kconfig                    |   20 +
 drivers/hsi/controllers/Makefile                   |    6 +
 drivers/hsi/controllers/omap_ssi.c                 |  585 +++++++++
 drivers/hsi/controllers/omap_ssi.h                 |  167 +++
 drivers/hsi/controllers/omap_ssi_port.c            | 1346 ++++++++++++++++++++
 drivers/hsi/controllers/omap_ssi_regs.h            |  172 +++
 12 files changed, 2476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hsi/omap_ssi.txt
 create mode 100644 drivers/hsi/controllers/Kconfig
 create mode 100644 drivers/hsi/controllers/Makefile
 create mode 100644 drivers/hsi/controllers/omap_ssi.c
 create mode 100644 drivers/hsi/controllers/omap_ssi.h
 create mode 100644 drivers/hsi/controllers/omap_ssi_port.c
 create mode 100644 drivers/hsi/controllers/omap_ssi_regs.h

-- 
1.8.4.rc3
