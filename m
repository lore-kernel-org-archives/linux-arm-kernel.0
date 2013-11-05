From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:15 +0800
Subject: [PATCH v3 00/10] Add power management support for chipidea
Message-ID: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This serial adds power management (system & runtime) for chipidea core.
With this, the chipidea controller can be at low power mode when it is not in
use, and the chipidea controller can be the system wakeup source.
It needs to depend on my patch[1], since [1]-"Add power management support for MXS PHY"
adds some common PHY APIs, and this serial uses it.

It has been verified at Freescale i.mx6Q/DL SabreSD, i.mx28 evk platform
(no runtime pm support), I will verify it at other FSL platforms during
the patch review.

Hi Alan,

Due to chipidea core and imx concontroller needs some special operations
during the standard ehci routine, I override .hub_control, .bus_suspend,
and .bus_resume.

There is one special thing is I use flag ehci->bus_suspended to know it
was a global suspend before due to I need to notify PHY when the suspend
has finished (portsc.suspendM is set) and the resume signal has finished
(portsc.fpr is cleared) for high speed device, but there are two places
will send suspend/resume, and I don't want to patch ehci-hub.c (if you think
patch ehci-hub.c is a good way, I can do it).

The related host patches:

usb: chipidea: host: add quirk for ehci operation
usb: chipidea: host: add ehci quirk for imx controller

My github tree: https://github.com/hzpeterchen/linux-usb
branch: master
It is based on linux-next-1029.

Changes for v3:
- Using flag bit to indicate SoC features/bugs [7/10][10/10]

Changes for v2:
- Do not use atomic_read and atomic_set for ci->in_lpm
- Do not use "supports_runtime_pm" as DT property due to it is
not a hardware feature, instead of it, we use compatible string
to enable it.

Peter Chen (10):
  usb: chipidea: Add power management support
  usb: chipidea: imx: add power management support
  usb: chipidea: add wakeup interrupt handler
  usb: chipidea: usbmisc_imx: remove the controller's clock information
  usb: chipidea: usbmisc_imx: add set_wakup API
  usb: chipidea: imx: call set_wakeup when necessary
  usb: chipidea: imx: Enable runtime pm support for imx6q
  usb: chipidea: host: add quirk for ehci operation
  usb: chipidea: host: add ehci quirk for imx controller
  usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK

 drivers/usb/chipidea/ci.h          |    3 +
 drivers/usb/chipidea/ci_hdrc_imx.c |  156 ++++++++++++++++++++++++++++++-
 drivers/usb/chipidea/ci_hdrc_imx.h |    1 +
 drivers/usb/chipidea/core.c        |  139 +++++++++++++++++++++++++++
 drivers/usb/chipidea/host.c        |  180 ++++++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/otg.c         |    5 +
 drivers/usb/chipidea/usbmisc_imx.c |   59 ++++++++----
 include/linux/usb/chipidea.h       |    2 +
 8 files changed, 522 insertions(+), 23 deletions(-)

[1] http://marc.info/?l=linux-usb&m=138361739523355&w=2
