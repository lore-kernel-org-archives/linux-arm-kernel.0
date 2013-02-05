From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Feb 2013 16:00:07 +0800
Subject: [PATCH v8 0/8] Add tested id switch and vbus connect detect support
 for Chipidea
Message-ID: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v7:
- Add ci_supports_gadget helper to know if the controller
supports gadget, if the controller supports gadget, it
needs to read otgsc to know the vbus value, basically,
if the controller supports gadget, it will support host
as well [3/8]
- At ci_hdrc_probe, it needs to add free memory at error path
[3/8]
- Cosolidate ci->driver = NULL at ci13xxx_stop
[8/8]

Changes for v6:
For Patch 8/8, we only need to set ci->driver to NULL when usb cable
is not connected, for other changes, it will case some runtime pm
unmatch and un-align with udc-core & composite driver problems.

Changes for v5:
- Add Alex comments for init/destroy function [3/8] [4/8]
- Remove memset(&ci->gadget, 0, sizeof(ci->gadget)) at destory function [4/8]
- Add Kishon's comment: Change the format of struct usb_otg otg at drivers/usb/chipidea/ci.h
[1/8]
- Add comments for CI_VBUS_STABLE_TIMEOUT [3/8]
- Change the otg_set_peripheral return value check as the fully
chipidea driver users don't need it. [4/8]
- Fix one bug that the oops when re-plug in usb cable after
rmmod gadget [8/8]

Anyone who has tested this patchset, please give a tested-by, thanks.

This patchset adds tested otg id switch function and
vbus connect/disconnect detection for chipidea driver.
The mainly design of id/vbus handling follows msm otg driver.
I hope the msm usb maintainer can have a look of this patchset,
and give some comments, and move the whole msm usb driver to
chipidea framework if possible in the future.

This patch is fully tested at imx6 sabrelite platform.
My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
which is rebased of Sascha's git
(git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-otg-for-next)

At sascha's tag, it finishes some dr_mode and phy_type patches,
in that way, we can choose host-only and gadget-only function at
dts file as well as we can choose different phy setting.

Besides sascha's work, there are some Michael Grzeschik/Marc Kleine-Budde
usbmisc patch, imx chipidea suspend/resume patch, and one pin control
patch for imx6

Peter Chen (8):
  Revert "USB: chipidea: add vbus detect for udc"
  usb: chipidea: add otg file
  usb: chipidea: add otg id switch and vbus connect/disconnect detect
  usb: chipidea: consolidate kinds of APIs for both roles
  usb: chipidea: udc: add pullup/pulldown dp at hw_device_state
  usb: chipidea: udc: retire the flag CI13_PULLUP_ON_VBUS
  usb: chipidea: imx: add internal vbus regulator control
  usb: chipidea: udc: fix the oops when plugs in usb cable after rmmod
    gadget

 drivers/usb/chipidea/Makefile      |    2 +-
 drivers/usb/chipidea/bits.h        |   10 ++
 drivers/usb/chipidea/ci.h          |   12 ++-
 drivers/usb/chipidea/ci13xxx_imx.c |   80 ++++++++++++----
 drivers/usb/chipidea/ci13xxx_msm.c |    1 -
 drivers/usb/chipidea/core.c        |  189 ++++++++++++++++++++++++++++++++----
 drivers/usb/chipidea/host.c        |    6 +
 drivers/usb/chipidea/host.h        |    4 +-
 drivers/usb/chipidea/otg.c         |   68 +++++++++++++
 drivers/usb/chipidea/otg.h         |    9 ++
 drivers/usb/chipidea/udc.c         |  112 ++++++++++------------
 drivers/usb/chipidea/udc.h         |    4 +-
 include/linux/usb/chipidea.h       |    1 -
 13 files changed, 390 insertions(+), 108 deletions(-)
 create mode 100644 drivers/usb/chipidea/otg.c
 create mode 100644 drivers/usb/chipidea/otg.h
