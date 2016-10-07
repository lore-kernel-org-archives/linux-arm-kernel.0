From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:45 +0200
Subject: [PATCH/RFT 00/12] Add DT support for ohci-da8xx
Message-ID: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The purpose of this patch series is to add DT support to the ohci-da8xx
glue driver without breaking the non-DT boot, which is still used in
unconverted davinci devices.

To Achieve this, the first 8 patches make sure that the non-DT based
enumeration works, and prepares the stage for a DT migration by removing
dependencies on the board files (moving VBUS, and over current
handling to the driver). The last 4 patches actually add the DT
documentation and bindings for the ohci-da8xx driver.

Testing was done on a omap138-lcdk board, using DT, and non-DT boot,
and checking that in both cases the hub, usb mass storage and an input
device are correctly enumerated and working.

Since there have been some recent and ongoing efforts from David Lechner
to clean up davinci-mach code and the ochi-da8xx driver, this series
builds upon that work. Specifically:

* the accepted but soon to be reposted patch to remove mach code form
the ohci driver[1].

* The patch series to add phy nodes, and move usb clocks to a common
file [2].

A git branch based on tag: next-20161004 with the dependencies patches is
available in my github here [3].

The omap138-lcdk does not have gpios to control vbus and get over current
interrupt notifications, hence i was not able to test these and added
the RFT tag. If anyone has a da830-evm based board and could
confirm that ohci is correctly working, i would appreciate it.
(the OHCI option needs to be enabled in menuconfig)

P.D: It seems that the davinci-gpio driver is broken for DT based boot
and any gpio > 32. (luckly none of the DT based boards use gpios yet)
The probelm is that we have 144 gpios in the gpio controller as correctly
declared on the DT (they are not separate gpio controllers as in am3xx),
but the driver creates several gpio chips of 32 pins each, confusing the
"gpio chip to pin" matching logic of gpiolib-of. I think we might need to
fix this by creating a single gpio chip in gpio-davinci.c

[1] [PATCH v6 1/3] usb: ohci-da8xx: Remove code that references mach
    http://www.gossamer-threads.com/lists/linux/kernel/2518807
[2] [PATCH v5 0/5] da8xx USB PHY platform devices and clocks (was "da8xx UBS clocks")
    http://www.spinics.net/lists/linux-usb/msg140568.html
[3] github branch with all dependante patches
    https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt

Axel Haslam (12):
  ARM: davinci: da8xx: Enable the usb20 "per" clk on phy_clk_enable
  ARM: davinci: hawk: add full constraints for ohci plat boot
  ARM: davinci: rename root_hub to platform_data
  USB: ohci-da8xx: Divide power up time in the ohci driver
  USB: ohci-da8xx: Fix probe for devices with no vbus/oci gpio
  ARM: davinci: hawk: Remove oci and vbus gpios
  USB: ohci-da8xx: Request gpios and handle interrupt in the driver
  ARM: davinci: register the usb20_phy clock on the SoC file
  usb: host: ohci-da8xx: Add devicetree bindings documentation
  USB: ohci-da8xx: Add device tree support
  ARM: dts: da850: Add the usb ohci device node
  ARM: dts: da850-lcdk: enable ohci usb

 .../devicetree/bindings/usb/ohci-da8xx.txt         |  32 +++++
 arch/arm/boot/dts/da850-lcdk.dts                   |   9 ++
 arch/arm/boot/dts/da850.dtsi                       |   8 ++
 arch/arm/mach-davinci/board-da830-evm.c            |  75 +---------
 arch/arm/mach-davinci/board-omapl138-hawk.c        | 105 +-------------
 arch/arm/mach-davinci/da850.c                      |   2 +
 arch/arm/mach-davinci/include/mach/da8xx.h         |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c                  |  15 +-
 drivers/usb/host/ohci-da8xx.c                      | 158 +++++++++++++++++----
 include/linux/platform_data/usb-davinci.h          |  22 ++-
 10 files changed, 218 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

-- 
2.7.1
