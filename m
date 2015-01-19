From: rjui@broadcom.com (Ray Jui)
Date: Mon, 19 Jan 2015 11:23:45 -0800
Subject: [PATCH v6 0/3] Add I2C support to Broadcom iProc
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1421695428-19102-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial I2C support for Broadcom iProc family of
SoCs.

The iProc I2C controller has separate internal TX and RX FIFOs, each has a
size of 64 bytes. The iProc I2C controller supports two bus speeds including
standard mode (100 kHz) and fast mode (400 kHz)

Changes from v5:
 - Improve the "waiting for transaction to be complete" logic to take care of
   the corner case when an interrupt fires after wait_for_completion_timeout
   times out
 - Improve the logic to disable I2C interrupt in the remove function. Make it
   more generic so it works for both dedicated and shared interrupt

Changes from v4:
 - Remove redundant header file includes
 - Change the logic that waits for the host controller to be idle to
   simply return -EBUSY
 - Use proper print level and error codes in the driver
 - Allow zero length message in the driver to support I2C_SMBUS_QUICK
 - Change back to use devm_request_irq. Disable interrupt in the remove
   function so there's no outstanding I2C interrupt when the driver is
   being removed from the framework
 - Other minor miscellaneous improvements and fixes

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
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  499 ++++++++++++++++++++
 5 files changed, 567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c

-- 
1.7.9.5
