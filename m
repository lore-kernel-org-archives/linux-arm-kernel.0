From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Tue, 17 Jan 2017 16:02:39 -0600
Subject: [PATCH v3 00/18] FSI device driver introduction
Message-ID: <1484690559-12909-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Introduction of the IBM 'Flexible Support Interface' (FSI) bus device
driver. FSI is a high fan out serial bus consisting of a clock and a serial
data line capable of running at speeds up to 166 MHz.

This set provides the basic framework to add FSI extensions to the
Linux bus and device models. Master specific implementations are
defined to utilize the core FSI function.

In Linux, we have a core FSI "bus type", along with drivers for FSI
masters and engines.

The FSI master drivers expose a read/write interface to the bus address
space. The master drivers are under drivers/fsi/fsi-master-*.c.

The core handles probing and discovery of slaves and slave
engines, using those read/write interfaces. It is responsible for
creating the endpoint Linux devices corresponding to the discovered
engines on each slave.

Slave engines are identified by an 'engine' type, and an optional
version. Engine, a.k.a. client, drivers are matched and bound to these
engines during discovery.

This patch set does not include extended FSI function such as:
    *  Hub master support
    *  Cascaded master support
    *  Application layer hot plug notification
    *  Application layer FSI bus status interface

Common FSI terminology:

* Master
    Controller of the FSI bus.  Only the master is allowed to control the
    clock line and is the initiator of all transactions on a bus.

* Slave
    The receiver or target of a master initiated transaction.  The slave
    cannot initiate communications on a bus and must respond to any
    master requests for data.

* CFAM
    Stands for Common Field replaceable unit Access Macro.  A CFAM is an
    ASIC residing in any device requiring FSI communications. CFAMs
    consist of an array of hardware 'engines' used for various purposes.
    I2C masters, UARTs, General Purpose IO hardware are common types of
    these engines.

* Configuration Space / Table
    A table contained at the beginning of each CFAM address space.
    This table lists information such as the CFAM's ID, which engine types
    and versions it has available, as well as its addressing range.

* FSI Engine driver
    A device driver that registers with the FSI core so that it can access
    devices it owns on an FSI bus.

Chris Bostic (8):
  drivers/fsi: Kick off master scan via sysfs
  drivers/fsi: Set up links for slave communication
  drivers/fsi: Set slave SMODE to init communication
  drivers/fsi: Remove all scanned devices during master unregister
  drivers/fsi: Add FSI bus documentation
  drivers/fsi: Add documentation for GPIO based FSI master
  drivers/fsi: Document FSI master sysfs files in ABI
  drivers/fsi: Add GPIO based FSI master

Jeremy Kerr (10):
  drivers/fsi: Add empty fsi bus definitions
  drivers/fsi: Add device & driver definitions
  drivers/fsi: add driver to device matches
  drivers/fsi: Add fsi master definition
  drivers/fsi: Add slave definition
  drivers/fsi: Add empty master scan
  drivers/fsi: Add FSI crc calculators to library
  drivers/fsi: Implement slave initialisation
  drivers/fsi: scan slaves & register devices
  drivers/fsi: Add device read/write/peek functions

Changes for v3:
    - Patch set contained an invalid 18/18 test patch not
      meant for community review, corrected.

Changes for v2:
    - Change from atomic global for master number to ida simple
      interface.
    - Add valid pointer checks on register and unregister utils.
    - Move CRC calculation utilities out of driver to lib path.
    - Clean up white space issues.
    - Remove added list management of master devices and use
      instead the device_for_each_child method available in the
      bus.
    - Add new patch to document FSI bus functionality.
    - Add new patch documenting FSI gpio master.
    - Rearrage patch set to have documentation earlier than code
      implementing it.
    - Document all comptible strings used in device tree bindings.
    - Elaborate documentation definition of FSI GPIO master.
    - Describe in more detail what each GPIO FSI master pin is for.
    - Re-order compatible strings in example binding so that most
      specific device comes first.
    - Indicate proper activation order of all FSI GPIO master pins.
    - Fix an unmatched '>' bracket in the example for binding.
    - Bracket each element of the example bindings individually.
    - Add new patch documenting sysfs-bus-fsi attributes.
    - Merge FSI GPIO master init into probe function.
    - Set pin initial values at time of pin request.
    - Assign value of master->master.dev at probe time.
    - Use get_optional interfac for all optional GPIO pins.


 Documentation/ABI/testing/sysfs-bus-fsi            |   6 +
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    |  71 +++
 Documentation/devicetree/bindings/fsi/fsi.txt      |  54 +++
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/fsi/Kconfig                                |  23 +
 drivers/fsi/Makefile                               |   3 +
 drivers/fsi/fsi-core.c                             | 494 +++++++++++++++++++
 drivers/fsi/fsi-master-gpio.c                      | 530 +++++++++++++++++++++
 drivers/fsi/fsi-master.h                           |  39 ++
 include/linux/crc-fsi.h                            |  29 ++
 include/linux/fsi.h                                |  60 +++
 lib/Makefile                                       |   1 +
 lib/crc-fsi.c                                      |  39 ++
 14 files changed, 1352 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi.txt
 create mode 100644 drivers/fsi/Kconfig
 create mode 100644 drivers/fsi/Makefile
 create mode 100644 drivers/fsi/fsi-core.c
 create mode 100644 drivers/fsi/fsi-master-gpio.c
 create mode 100644 drivers/fsi/fsi-master.h
 create mode 100644 include/linux/crc-fsi.h
 create mode 100644 include/linux/fsi.h
 create mode 100644 lib/crc-fsi.c

-- 
1.8.2.2
