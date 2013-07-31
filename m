From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 31 Jul 2013 14:14:41 +0000
Subject: [PATCH v13 00/14] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F691C8@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Alex, any comments, now it finished 3.11-rc4, I don't want this patchset missed at 3.11.

Please tell me which one is OK, and which one needs to be refined, thanks.

Best regards,
Peter
________________________________________
From: linux-usb-owner@vger.kernel.org [linux-usb-owner at vger.kernel.org] on behalf of Peter Chen [peter.chen at freescale.com]
Sent: Friday, July 26, 2013 5:18 PM
To: alexander.shishkin at linux.intel.com
Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; festevam at gmail.com; marex at denx.de; maxime.ripard at free-electrons.com; shawn.guo at linaro.org; kernel at pengutronix.de; mkl at pengutronix.de; m.grzeschik at pengutronix.de; gregkh at linuxfoundation.org; Li Frank-B20596
Subject: [PATCH v13 00/14] Add tested id switch and vbus connect detect support for Chipidea

This patchset adds tested otg id switch function and vbus connect
and disconnect detection for chipidea driver. And fix kinds of
bugs found at chipidea drivers after enabling id and vbus detection.

This patch are fully tested at imx6 sabresd and imx28evk platform by me.
Besides, marek tested it on two STMP3780-based boards (not yet mainline)
and two MX28-based boards.

My chipidea repo: https://github.com/hzpeterchen/linux-usb.git

Chagnes for v13:
- Add Tested-by: Marek Vasut <marex@denx.de>
- [Sascha's comments]: Add return value check for devm_regulator_get. [3/14]
- [Marc's comments]: Change timeout usage at hw_wait_reg. [11/14]
- [Alex's comments]: Using platdata flag to indicate dual role but not
OTG controller. [7/14]

Changes for v12:
- Rebased greg's usb-next tree (3.10.0-rc7+)
- Split more small patches for single function and fix.

Changes for v11:
- mark ci_handle_vbus_change as static as it is only used at core.c
[3/9]
- Move the vbus operation for platform code to host code, as vbus
operation is common operation, and host is the only user for vbus.
When it is host mode, we need to open vbus, when it is out of host
mode, we need to close vbus. [6/9] [8/9]
- Delete the delayed work at core.c as it is not needed. [7/9]

Changes for v10:
- Delete [8/9] at v9, ci core's drvdata must be set for further operation.
[8/8]

Changes for v9:
- Some small comments from Alex like: variable comment for otg event
additional newline. [3/9]
- Import function tell show if the controller has otg capable, if
the controller supports both host and device, we think it is otg
capable, and can read OTGSC. [3/9]
- Merge two otg patches [v8 3/8] and [v8 4/8] to one [v9 3/9]. [3/9]
- Add inline to ci_hdrc_gadget_destroy if CONFIG_USB_CHIPIDEA_UDC
is not defined, it can fix one build warning "defined but not used"
[3/9]
- One comment from Felipe about changing calling gadget disconnect
API at chipidea's udc driver. I move calling ci->driver->disconnect
from _gadget_stop_activity to which calls _gadget_stop_activity except
ci13xxx_stop, as udc core will call disconnect when do rmmod gadget. [7/9]
- Add ci core probe's return value to ci's platform_data, we do this
for getting core's probe's result at platform layer, and quit it
if the core's probe fails. [8/9] [9/9]

Changes for v8:
- Add ci_supports_gadget helper to know if the controller
supports gadget, if the controller supports gadget, it
needs to read otgsc to know the vbus value, basically,
if the controller supports gadget, it will support host
as well [3/8]
- At ci_hdrc_probe, it needs to add free memory at error path
[3/8]
- Cosolidate ci->driver = NULL at ci13xxx_stop
[8/8]

Changes for v7:
For Patch 8/8, we only need to set ci->driver to NULL when usb cable
is not connected, for other changes, it will case some runtime pm
unmatch and un-align with udc-core & composite driver problems.

Changes for v6:
- Add Alex comments for init/destroy function [3/8] [4/8]
- Remove memset(&ci->gadget, 0, sizeof(ci->gadget)) at destory function [4/8]
- Add Kishon's comment: Change the format of struct usb_otg otg at drivers/usb/chipidea/ci.h
[1/8]
- Add comments for CI_VBUS_STABLE_TIMEOUT [3/8]
- Change the otg_set_peripheral return value check as the fully
chipidea driver users don't need it. [4/8]
- Fix one bug that the oops when re-plug in usb cable after
rmmod gadget [8/8]

Peter Chen (14):
  usb: chipidea: add vbus regulator control
  usb: chipidea: imx: remove vbus regulator operation
  usb: chipidea: imx: add return value check for devm_regulator_get
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
  usb: chipidea: udc: fix the oops when plugs in usb cable after rmmod
    gadget

 drivers/usb/chipidea/Makefile      |    2 +-
 drivers/usb/chipidea/bits.h        |   10 ++
 drivers/usb/chipidea/ci.h          |    8 ++
 drivers/usb/chipidea/ci_hdrc_imx.c |   40 ++++-----
 drivers/usb/chipidea/core.c        |  161 ++++++++++++++++++++++++------------
 drivers/usb/chipidea/host.c        |   30 +++++++-
 drivers/usb/chipidea/host.h        |    6 ++
 drivers/usb/chipidea/otg.c         |  135 ++++++++++++++++++++++++++++++
 drivers/usb/chipidea/otg.h         |   22 +++++
 drivers/usb/chipidea/udc.c         |   72 ++++++++++++----
 drivers/usb/chipidea/udc.h         |    6 ++
 include/linux/usb/chipidea.h       |    6 ++
 12 files changed, 402 insertions(+), 96 deletions(-)
 create mode 100644 drivers/usb/chipidea/otg.c
 create mode 100644 drivers/usb/chipidea/otg.h


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
