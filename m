From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:35:02 +0800
Subject: [PATCH 00/11] Add power management support for chipidea
Message-ID: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This serial adds power management (system & runtime) for chipidea core.
With this, the chipidea controller can be at low power mode when it is not in
use, and the chipidea controller can be the system wakeup source. 
It needs to depend on my patch[1], since [1] adds some common PHY APIs, and
this serial uses it.

It has been verified at Freescale i.mx6Q SabreSD platform, I will verify
it at other FSL platforms during the patch review.

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

Hi Shawn,

The last two are devicetree related to enable runtime pm.

Peter Chen (11):
  usb: chipidea: Add power management support
  usb: chipidea: imx: add power management support
  usb: chipidea: usbmisc_imx: remove the controller's clock information
  usb: chipidea: add wakeup interrupt handler
  usb: chipidea: usbmisc_imx: add set_wakup API
  usb: chipidea: imx: call set_wakeup when necessary
  usb: chipidea: host: add quirk for ehci operation
  usb: chipidea: host: add ehci quirk for imx controller
  usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK if the phy has
    notify APIs
  usb: chipidea: imx: add binding for supporting runtime pm
  ARM: dts: imx6qdl-sabresd: Enable runtime pm for usbotg and usb host
    1

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    2 +
 drivers/usb/chipidea/ci.h                          |    3 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  140 +++++++++++++++-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    1 +
 drivers/usb/chipidea/core.c                        |  139 +++++++++++++++
 drivers/usb/chipidea/host.c                        |  180 ++++++++++++++++++++
 drivers/usb/chipidea/otg.c                         |    5 +
 drivers/usb/chipidea/usbmisc_imx.c                 |   59 +++++--
 include/linux/usb/chipidea.h                       |    2 +
 10 files changed, 512 insertions(+), 21 deletions(-)

[1] Add power management support for MXS PHY:
http://marc.info/?l=linux-usb&m=138156975205686&w=2
