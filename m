From: rjui@broadcom.com (Ray Jui)
Date: Wed, 14 Jan 2015 14:23:30 -0800
Subject: [PATCH v4 0/3] Add I2C support to Broadcom iProc
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1421274213-3544-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial I2C support for Broadcom iProc family of
SoCs.

The iProc I2C controller has separate internal TX and RX FIFOs, each has a
size of 64 bytes. The iProc I2C controller supports two bus speeds including
standard mode (100 kHz) and fast mode (400 kHz)

Changes from v3:
 - Add config dependency to COMPILE_TEST to allow the driver to be build tested
   by other platforms
 - Improve CPU utilization efficiency in the loop of waiting for bus to idle
 - Add more comment in the driver to clarify the way how the "start busy"
   interrupt is triggered from the I2C controller
 - Fix inconsistent coding style and format
 - Improve the bus speed validation logic in the driver
 - Add code to free the interrupt line in driver's remove function. Also
   change to use non-devm API to request the interrupt line
 - Other miscellaneous improvements and fixes

Changes from v2:
 - Have the I2C driver default to y so it does not need to be selected from
   ARCH_BCM_IPROC. This also helps to get rid of one patch. The driver still
   depends on ARCH_BCM_IPROC
 - Get rid of redundant check on resource returned by platform_get_resource

Changes from v1:
 - Fix function argument parenthesis
 - Get rid of redundant driver owner field

Ray Jui (3):
  i2c: iProc: define Broadcom iProc I2C binding
  i2c: iproc: Add Broadcom iProc I2C Driver
  ARM: dts: add I2C device nodes for Broadcom Cygnus

 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |   37 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   20 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  503 ++++++++++++++++++++
 5 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c

-- 
1.7.9.5
