From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Tue,  8 Dec 2015 11:41:35 -0500
Subject: [PATCH v8 0/3] Add board support for TS-4800
Message-ID: <1449592898-24049-1-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch serie adds support for TS-4800 board. This board,                                                                              
manufactured by Technologic Systems, is based on an IMX515.

The first stage bootloader, called TS-BOOTROM, enables the watchdog,
so a watchdog driver is required to prevent board from rebooting. It is
handled in a separate patchset.

The current device tree is minimal but it allows to get a shell on the
board.

Changes in v8:
 - Split the serie into two parts, watchdog and dts, because there are
   no build dependencies between the two, and the syscon patch has been
   separately applied in Lee Jones' tree.
 - As a consequence, I dropped the patch which enabled the watchdog in
   imx_v6_v7_defconfig to ease the integration.

Changes in v7:
 - syscon: change bus-width DT property to reg-io-width
 - watchdog: add dependency on HAS_IOMEM (spotted by a 0-day build) 

Changes in v6:
 - vendor prefix: reorder to sort alphabetically (wrong order since v3)
 - split commit adding device tree into two patches: one for the doc, one for
   the bindings

Changes in v5:
 - watchdog: changed iteration stop condition in set_timeout to be less
   error prone

Changes in v4:
 - syscon: rewrite DT property reading to be clearer
 - watchdog: made fixes suggested by Guenter (now uses
   watchdog_init_timeout, u32 instead of u16, fixed error checking in
   probe, cleaned set_timeout)

Changes in v3:
 - Rebased on v4.3
 - Changed vendor prefix from "ts" to "technologic"
 - Added a DT option to generic syscon driver to allow regmap configuration
 - Dropped custom mfd driver, use generic syscon driver instead.

Changes in v2:
 - Added a mfd driver to handle syscon registers
 - The watchdog driver now uses the regmap (created by the mfd driver)
   to access the feed register
 - Remove watchdog's dependency on SOC_IMX51


Damien Riegel (3):
  of: add vendor prefix for Technologic Systems
  of: documentation: add bindings documentation for TS-4800
  ARM: dts: TS-4800: add basic device tree

 .../devicetree/bindings/arm/technologic.txt        |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 | 190 +++++++++++++++++++++
 4 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts

-- 
2.5.0
