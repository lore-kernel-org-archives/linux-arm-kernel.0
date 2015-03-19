From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:11 +0800
Subject: [PATCH 00/12] USB: chipidea: patchset for performance improvement
Message-ID: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In this patch set, I add some interfaces for tuning the performance
of chipidea usb driver. With this set, the USB performance can be improved
at some user cases with suitable parameters. The main changes:

- Interface to tune interrupt threshold control, and set
'Immediate' for default value
- The glue layer can disable stream mode according to USB role
- Interface to tune AHB burst configuration at SBUSCFG
- Interface to tune tx/rx burst size
- i.mx changes for achieving better performance, it can reduce
  the latecy between bus and USB FIFO, and reduce the overrun
  and underrun occurrences, it is useful for the system bus is busy.
  we see great improvement for ISO transfer, eg, high resolution
  USB camera when the bus is busy.

Below are some test results at imx6sx sdb board
(set ehci_hcd.park=3 at bootargs), the tests are done
at v4.0 kernel, no other bus loading during the tests,
so we have not seen performance change for some use cases.

USB Mass Storage (Host mode)
With Patch Set		Without Patch Set
R: 26.9 MB/s		27 MB/s
W: 25.2 MB/s		24.5 MB/s

1G USB Ethernet Card
With Patch Set		Without Patch Set
TX: 186 Mb/s		185 Mb/s
RX: 219 Mb/s		216 Mb/s

g_ncm (Device Mode)
With Patch Set		Without Patch Set
TX: 166MB/s		163MB/s
RX: 230MB/s		184MB/s

Peter Chen (12):
  Doc: usb: ci-hdrc-imx: add gadget-itc-setting for binding doc
  usb: chipidea: set ITC to 0 for device mode
  usb: chipidea: define stream mode disable for both roles
  usb: chipidea: imx: add stream mode enable for device mode at
    imx6sl/imx6sx
  usb: chipidea: introduce ci_platform_config
  Doc: usb: ci-hdrc-imx: add ahb-burst-config for binding doc
  ARM: imx6: set ahb-burst-config as 0 for USB
  usb: chipidea: add ahb burst configuration
  usb: chipidea: usbmisc_imx: add unburst setting for imx6
  Doc: usb: ci-hdrc-imx: add tx(rx)-burst-config-dword for binding doc
  ARM: imx6: change default burst size for USB
  usb: chipidea: add burst size configuration interface

 .../devicetree/bindings/usb/ci-hdrc-imx.txt        |  12 +++
 arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +++
 arch/arm/boot/dts/imx6sl.dtsi                      |   9 ++
 arch/arm/boot/dts/imx6sx.dtsi                      |   9 ++
 drivers/usb/chipidea/bits.h                        |   7 ++
 drivers/usb/chipidea/ci.h                          |   3 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  14 ++-
 drivers/usb/chipidea/core.c                        | 119 +++++++++++++++++++--
 drivers/usb/chipidea/host.c                        |   6 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |  12 ++-
 include/linux/usb/chipidea.h                       |  11 +-
 11 files changed, 191 insertions(+), 23 deletions(-)

-- 
1.9.1
