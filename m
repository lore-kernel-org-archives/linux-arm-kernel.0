From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:27:06 +0100
Subject: [PATCH v5 0/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
Message-ID: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, this is the 5th round of Sascha's patch series, rebased to Greg's
usb-next.

Please consider to apply.

regards,
Marc

changes since v4:
- add support for USB_DR_MODE_DUAL_ROLE in dt helper

changes since v3:

- add phy patches (which were accidently already part of v2)
- Use OP_DEVLC instead of OP_PORTSC for lpm case
- Use enum usb_dr_mode ub ci_hdrc_probe()

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


The following changes since commit 74e1a2a39355b2d3ae8c60c78d8add162c6d7183:

  Merge tag 'usb-3.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2013-02-21 12:20:00 -0800)

are available in the git repository at:


  git://git.pengutronix.de/git/mkl/linux.git tags/usb-chipidea-for-next-v5

for you to fetch changes up to 1065bb064c06565cc0b86337d52977ab5afc3e90:

  USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-02-27 12:54:13 +0100)

----------------------------------------------------------------
USB: chipidea patches for v3.10

These add OF helpers for handling the dr_mode and phy_type property and makes
use of them in the chipidea driver.

----------------------------------------------------------------
Marc Kleine-Budde (1):
      USB otg: use try_module_get in all usb_get_phy functions and add missing module_put

Michael Grzeschik (3):
      USB: add devicetree helpers for determining dr_mode and phy_type
      USB chipidea: ci13xxx-imx: create dynamic platformdata
      USB chipidea: add PTW and PTS handling

Sascha Hauer (5):
      USB: move bulk of otg/otg.c to phy/phy.c
      USB chipidea: introduce dual role mode pdata flags
      USB chipidea i.MX: introduce dr_mode property
      USB mxs-phy: Register phy with framework
      USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +
 drivers/usb/chipidea/bits.h                        |   14 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   67 +--
 drivers/usb/chipidea/core.c                        |   61 ++-
 drivers/usb/otg/mxs-phy.c                          |    9 +
 drivers/usb/otg/otg.c                              |  423 -------------------
 drivers/usb/phy/Makefile                           |    2 +
 drivers/usb/phy/of.c                               |   47 +++
 drivers/usb/phy/phy.c                              |  438 ++++++++++++++++++++
 drivers/usb/usb-common.c                           |   37 ++
 include/linux/usb/chipidea.h                       |    3 +-
 include/linux/usb/of.h                             |   27 ++
 include/linux/usb/otg.h                            |    8 +
 include/linux/usb/phy.h                            |    9 +
 14 files changed, 689 insertions(+), 462 deletions(-)
 create mode 100644 drivers/usb/phy/of.c
 create mode 100644 drivers/usb/phy/phy.c
 create mode 100644 include/linux/usb/of.h
