From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:38 +0100
Subject: [PATCH v3 00/10] Add DT support for ohci-da8xx
Message-ID: <20161107203948.28324-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch series is to add DT support for the davinci
ohci driver.

To be able to use device tree to probe the driver, we need to remove
the platform callbacks that are handling vbus and over current.

The first four patches prepare the stage by allowing to use a regulator
instead of the callbacks.

The next three patches convert the callback users to use a regulator
instead and then remove the callbacks from the driver and platform code.

Finally, we add device tree bindings and support in the driver.

DEPENDENCIES:
This series has depends on some patches currently under review
but mostly accepted:
1. [PATCH 0/3] fix ohci phy name [1] (accepted)
2. [PATCH/RFC v2 0/3] regulator: handling of error conditions for usb drivers [2] (accepted)
3. [PATCH] gpio: davinci: Use unique labels for each gpio chip [3] (review pending)

Also the current davinci baranches soon to be pulled to linux-next:
davinci-for-v4.10/soc
davinci-for-v4.10/dt
davinci-for-v4.10/defconfig
davinci-for-v4.10/cleanup

A branch with all the dependencies can be found here [4].

Changes form v2->v3
* drop patches that have been integrated to arch/arm
* drop regulator patches which will be integrated through regulator tree
* use of the accepted regulator API to get over current status
* better patch separation with the use of wrappers

Changes from v1->v2
* Rebased and added patch to make ohci a separate driver
* Use a regulator instead of handling Gpios (David Lechner)
* Add an over current mode to regulator framework
* Fixed regulator is able to register for and over current irq
* Added patch by Alexandre to remove build warnings
* Moved global variables into private hcd structure.

[1] https://lkml.org/lkml/2016/11/2/208
[2] https://lkml.org/lkml/2016/11/3/188
[3] http://www.spinics.net/lists/linux-gpio/msg17710.html
[4] https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v3

Axel Haslam (10):
  USB: ohci: da8xx: use ohci priv data instead of globals
  USB: ohci: da8xx: Prepare to remove platform callbacks
  USB: ohci: da8xx: Allow a regulator to handle VBUS
  ARM: davinci: da830: Handle vbus with a regulator
  ARM: davinci: hawk: Remove vbus and over current gpios
  USB: ohci: da8xx: Remove ohci platform callbacks
  USB: ohci: da8xx: use a flag instead of mask for ocic
  USB: ohci: da8xx: Add devicetree bindings
  USB: ohci: da8xx: Allow probing from DT
  ARM: dts: da850: add usb device node

 .../devicetree/bindings/usb/ohci-da8xx.txt         |  39 ++++
 arch/arm/boot/dts/da850-lcdk.dts                   |   8 +
 arch/arm/boot/dts/da850.dtsi                       |   8 +
 arch/arm/mach-davinci/board-da830-evm.c            | 108 ++++-----
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  99 +-------
 arch/arm/mach-davinci/include/mach/da8xx.h         |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c                  |   3 +-
 drivers/usb/host/ohci-da8xx.c                      | 253 +++++++++++++++------
 include/linux/platform_data/usb-davinci.h          |  20 --
 9 files changed, 283 insertions(+), 257 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

-- 
2.10.1
