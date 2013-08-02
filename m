From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 2 Aug 2013 16:33:53 +0800
Subject: [PATCH v14 00/12] Add tested id switch and vbus connect detect
 support for Chipidea
Message-ID: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds tested otg id switch function and vbus connect
and disconnect detection for chipidea driver. And fix kinds of 
bugs found at chipidea drivers after enabling id and vbus detection.

This patch are fully tested at imx6 sabresd and imx28evk platform by me.
Besides, marek tested it on two STMP3780-based boards (not yet mainline)
and two MX28-based boards.

My chipidea repo: https://github.com/hzpeterchen/linux-usb.git

Changes for v14:
- This patchset is based on below recent chipidea patches and newest
usb-next, it can decrease rebase effort.

Fabio Estevam (3):
  chipidea: ci_hdrc_imx: Remove unused variable 'res'
  chipidea: core: Move hw_phymode_configure() into probe
  chipidea: Remove previous MODULE_ALIAS

Lothar Wa??mann (3):
  usb: chipidea: improve kconfig 2.0
  usb: chipidea: don't clobber return value of ci_role_start()
  usb: chipidea: ci_hdrc_imx: remove an unsolicited module_put() call
    from ci_hdrc_imx_remove()

Peter Chen (1):
  usb: chipidea: fix the build error with randconfig

- [Michael comments]: move vbus operation to core, and squash two vbus
patches. [1/12], [2/12]
- [Michael comments]: move out non vbus and non id related patches. [14/14 at v13]

Chagnes for v13:
- Add Tested-by: Marek Vasut <marex@denx.de>
- [Sascha's comments]: Add return value check for devm_regulator_get. [3/14]
- [Marc's comments]: Change timeout usage at hw_wait_reg. [11/14]
- [Alex's comments]: Using platdata flag to indicate dual role but not 
OTG controller. [7/14]

Changes for v12:
- Rebased greg's usb-next tree (3.10.0-rc7+)
- Split more small patches for single function and fix.

Peter Chen (12):
  usb: chipidea: move vbus regulator operation to core
  usb: chipidea: host: add vbus regulator control
  usb: chipidea: udc: otg_set_peripheral is useless for some chipidea
    users
  usb: chipidea: otg: Add otg file used to access otgsc
  usb: chipidea: Add role init and destory APIs
  usb: chipidea: add flag CI_HDRC_DUAL_ROLE_NOT_OTG
  usb: chipidea: disable all interrupts and clear all interrupts status
  usb: chipidea: move otg relate things to otg file
  usb: chipidea: add vbus interrupt handler
  usb: chipidea: add wait vbus lower than OTGSC_BSV before role starts
  usb: chipidea: udc: misuse flag CI_HDRC_REGS_SHARED and
    CI_HDRC_PULLUP_ON_VBUS
  usb: chipidea: udc: .pullup is valid when vbus is on at
    CI_HDRC_PULLUP_ON_VBUS

 drivers/usb/chipidea/Makefile      |    2 +-
 drivers/usb/chipidea/bits.h        |   10 ++
 drivers/usb/chipidea/ci.h          |    8 ++
 drivers/usb/chipidea/ci_hdrc_imx.c |   26 +-----
 drivers/usb/chipidea/core.c        |  184 +++++++++++++++++++++++++-----------
 drivers/usb/chipidea/host.c        |   30 ++++++-
 drivers/usb/chipidea/host.h        |    6 +
 drivers/usb/chipidea/otg.c         |  135 ++++++++++++++++++++++++++
 drivers/usb/chipidea/otg.h         |   22 +++++
 drivers/usb/chipidea/udc.c         |   59 +++++++++---
 drivers/usb/chipidea/udc.h         |    6 +
 include/linux/usb/chipidea.h       |    6 +
 12 files changed, 401 insertions(+), 93 deletions(-)
 create mode 100644 drivers/usb/chipidea/otg.c
 create mode 100644 drivers/usb/chipidea/otg.h
