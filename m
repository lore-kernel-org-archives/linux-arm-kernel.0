From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Feb 2013 11:52:27 +0100
Subject: [PATCH 0/4] otg-for-v3.10-v2: separate phy code and add DT helper
Message-ID: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series depends on the bugfix patch "USB otg: use try_module_get in all
usb_get_phy functions and add missing module_put" (a.k.a tags/otg-for-v3.9-v1)
posted earlier and is inteded for v3.10. It separates the phy from the otg code
and adds DT helper functions. In mxs-phy the {read,write}l_relaxed() functions
are replaced by the non _relaxed version to improve compile time coverage.
Further mxs-phy makes now use of the new usb_add_phy_dev() function to register
it's phy.

regards,
Marc

---

changes since v1:
- fix compile time breakage on non DT platforms (tnx, Alexander)
- convert mxs-phy to non _relaxed {read,write}l_relaxed() functions
  (as requested by Alexander)

---

The following changes since commit 6bef020b4aebd7886281fb7fb37c788d5a365eea:

  USB otg: use try_module_get in all usb_get_phy functions and add missing module_put (2013-02-27 12:53:15 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/mkl/linux.git tags/otg-for-v3.10-v2

for you to fetch changes up to f5678b135967ea98256ee5df9a360b5769861d23:

  USB mxs-phy: Register phy with framework (2013-02-28 11:36:45 +0100)

----------------------------------------------------------------
USB otg, phy: separate phy and add DT helper

Move phy related code into separate file and add device tree helper functions.

----------------------------------------------------------------
Marc Kleine-Budde (1):
      USB mxs-phy: use readl(), writel() instead of the _relaxed() versions

Michael Grzeschik (1):
      USB: add devicetree helpers for determining dr_mode and phy_type

Sascha Hauer (2):
      USB: move bulk of otg/otg.c to phy/phy.c
      USB mxs-phy: Register phy with framework

 drivers/usb/otg/mxs-phy.c |   41 +++--
 drivers/usb/otg/otg.c     |  427 -------------------------------------------
 drivers/usb/phy/Makefile  |    2 +
 drivers/usb/phy/of.c      |   47 +++++
 drivers/usb/phy/phy.c     |  438 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/usb-common.c  |   37 ++++
 include/linux/usb/of.h    |   28 +++
 include/linux/usb/otg.h   |    8 +
 include/linux/usb/phy.h   |    9 +
 9 files changed, 594 insertions(+), 443 deletions(-)
 create mode 100644 drivers/usb/phy/of.c
 create mode 100644 drivers/usb/phy/phy.c
 create mode 100644 include/linux/usb/of.h
