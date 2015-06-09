From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  9 Jun 2015 10:46:58 +0200
Subject: [PATCH v4] Mediatek SCPSYS power domain support
Message-ID: <1433839623-10804-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the MediaTek SCPSYS unit.

The SCPSYS unit handles several power management related tasks such
as thermal measurement, DVFS, interrupt filter and low level sleep
control.

The initial support only contains the generic power domain handling.
This is needed to turn on power to the different power domains.

The driver is quite straight forward now. Due to the lack of a better
place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
several other tasks that also do not fit into some specific subsystem
this probably is a good place for this driver.

Patch 5/5 currently has a dependency on the patch adding the clocks
to the MT8173 dtsi file, the rest should be mergable as is.

Please review, any input welcome.

Sascha

Changes since v3:
- Drop unnecessary MODULE_* macros for builtin code
- introduce scpsys_domain_is_on() function instead of open coding this
  twice
- Drop unnecessary initialisation of power_o[ff|n]_latencies. The kernel
  updates them with the measured values anyway.

changes since v2:
- Add missing include/linux/soc/mediatek/infracfg.h file
- rename VDE -> VDEC, VEN -> VENC, DIS -> DISP and VEN2 -> VENC_LT
  to make the abbreviatons more clear
- make of_device_id const
- remove double loop
- fix hunk in wrong patch
- Fix order of domains. Some domains depend on other domains. Reorder
  the domains so that all domains can be turned on in order when
  CONFIG_PM is disabled. Also fixes earlier mixups in the domain array
- Do not allow compilation as modules. pm_domains cannot be removed, so
  compilation as module is not that useful
- reorder Kconfig items alphabetically
- reorder #includes alphabetically
- select MTK_INFRACFG instead of depending on it
- Use only two clocks as dependencies for the domains. The previously
  used 5 clocks are not necessary as confirmed by the hardware designers
- use 'genpd' as variable name for struct generic_pm_domain like done in
  other pm code

changes since v1:
- make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
- Add (now hopefully properly) infracfg register handling again
- Add clock handling
- Fix on/off mixup in error message
- Make readonly data const
- Fix MODULE_LICENSE to GPL v2

changes since RFC:

- add a commit log to driver patch
- drop manipulating infracfg registers for now, can be added (properly)
  later
- Add warning messages when errors occur
- add NULL pointer check for kmalloc

----------------------------------------------------------------
Sascha Hauer (5):
      soc: mediatek: Add infracfg misc driver support
      dt-bindings: soc: Add documentation for the MediaTek SCPSYS unit
      soc: Mediatek: Add SCPSYS power domain driver
      ARM64: MediaTek: Add generic pm domain support
      ARM64: MediaTek MT8173: Add SCPSYS device node

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  34 ++
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
 drivers/soc/mediatek/Kconfig                       |  18 +
 drivers/soc/mediatek/Makefile                      |   2 +
 drivers/soc/mediatek/mtk-infracfg.c                |  91 ++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 490 +++++++++++++++++++++
 include/dt-bindings/power/mt8173-power.h           |  15 +
 include/linux/soc/mediatek/infracfg.h              |  26 ++
 9 files changed, 687 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
 create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
 create mode 100644 include/dt-bindings/power/mt8173-power.h
 create mode 100644 include/linux/soc/mediatek/infracfg.h
