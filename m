From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  1 Feb 2013 08:52:03 +0100
Subject: [PATCH v3] USB: add devicetree helpers for determining dr_mode and
 phy_type
Message-ID: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resend because I got the linux-usb address wrong)

Here's another round of the dr_mode/phy_type patches. I think they should
be ready for merging now. Greg, will you apply them should there be no
problems anymore?

Sascha

changes since v2:

- fix adding of GPL Header was in wrong patch
- add missing hunk for new file of.c

changes since v1:
- move phy specific of helper to drivers/usb/phy/of.c
- use strcmp instead of strcasecmp for matching property values
- change usb_phy_dr_mode to usb_dr_mode
- change USBPHY_INTERFACE_MODE_NA to USBPHY_INTERFACE_MODE_UNKNOWN
- add copyright header to new files
- chipidea: drop mdelay at end of PTS/PTW setup
- chipidea: implement lpm core type handling for PTS/PTW

The following changes since commit 7b8bc3aad0deabf3bc50cd2fe29bce29be5681fe:

  USB: chipidea: ci13xxx_imx: Remove sparse warning (2013-01-30 00:17:39 -0500)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-for-next

for you to fetch changes up to b82b92ba281add3e4d67bf6704052c0fd8c5c7f0:

  USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-01-31 12:27:36 +0100)

----------------------------------------------------------------
USB Chipidea patches for v3.9

These add OF helpers for handling the dr_mode and phy_type property
and makes use of them in the chipidea driver.

----------------------------------------------------------------
Michael Grzeschik (3):
      USB: add devicetree helpers for determining dr_mode and phy_type
      USB: chipidea: ci13xxx-imx: create dynamic platformdata
      USB: chipidea: add PTW and PTS handling

Sascha Hauer (6):
      USB: move bulk of otg/otg.c to phy/phy.c
      USB chipidea: introduce dual role mode pdata flags
      USB chipidea i.MX: introduce dr_mode property
      como fec wip
      USB mxs-phy: Register phy with framework
      USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy

 Documentation/devicetree/bindings/net/fsl-fec.txt  |   20 +
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +
 drivers/net/ethernet/freescale/fec.c               |   77 ++--
 drivers/net/ethernet/freescale/fec.h               |    1 +
 drivers/usb/chipidea/bits.h                        |   14 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   60 ++-
 drivers/usb/chipidea/core.c                        |   60 ++-
 drivers/usb/otg/mxs-phy.c                          |    9 +
 drivers/usb/otg/otg.c                              |  423 -------------------
 drivers/usb/phy/Makefile                           |    2 +
 drivers/usb/phy/of.c                               |   47 +++
 drivers/usb/phy/phy.c                              |  434 ++++++++++++++++++++
 drivers/usb/usb-common.c                           |   36 ++
 include/linux/usb/chipidea.h                       |    3 +-
 include/linux/usb/of.h                             |   27 ++
 include/linux/usb/otg.h                            |    7 +
 include/linux/usb/phy.h                            |    9 +
 17 files changed, 742 insertions(+), 493 deletions(-)
 create mode 100644 drivers/usb/phy/of.c
 create mode 100644 drivers/usb/phy/phy.c
 create mode 100644 include/linux/usb/of.h
