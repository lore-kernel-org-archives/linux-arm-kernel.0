From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  1 Sep 2014 23:05:59 +0800
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Message-ID: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is example of the sort of driver changes needed to boot
Juno using ACPI tables, which using the ACPI tables devloped for MS
Windows and published by ARM [1].

For the smsc911x driver, it is based on the following ASL fragment
which is part of DSDT for Juno:

    // LAN9118 Ethernet
    //
    Device(ETH0) {
      Name(_HID, "ARMH9118")
      Name(_UID, Zero)
      Name(_CRS, ResourceTemplate() {
              Memory32Fixed(ReadWrite, 0x1A000000, 0x1000)
              Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) { 192 }
      })
    }

UART driver is just for review purpose, ARM is working on a more
functional UART driver that does not poll to transmit. But it shows
how to initialise SBSA compatible UART without clock definitions in
DSDT.

You also can refer to the boot log from [2].

[1]: https://github.com/ARM-software/edk2/tree/juno-acpi/ArmPlatformPkg/ArmJunoPkg/AcpiTables
[2]: http://www.xora.org.uk/2014/08/29/juno-booting-from-acpi-tables/


Graeme Gregory (2):
  net: smsc911x add support for probing from ACPI
  tty: SBSA compatible UART

 drivers/net/ethernet/smsc/smsc911x.c |   38 ++++
 drivers/tty/Kconfig                  |    6 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/sbsauart.c               |  328 ++++++++++++++++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 drivers/tty/sbsauart.c

-- 
1.7.9.5
