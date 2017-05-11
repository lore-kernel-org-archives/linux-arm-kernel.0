From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:37 -0500
Subject: [PATCH v7 00/23] FSI device driver implementation
Message-ID: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementation of the IBM 'Flexible Support Interface' (FSI) bus device
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

* Hub
    An FSI master that connects to an upstream 'primary' master allowing
    high fanout of target devices.

----
Changes in v7:
   - Use GENMASK for bitmask definitions
   - Move instances of dev_info to dev_dbg
   - Add missing return code checks
   - Add API details for fsi_device_read/write/peek()
   - GPIO master: Unscan when unregistering master
   - Document ABI sysfs files raw, term, break, rescan
   - GPIO master: move global spinlock into struct fsi_master_gpio
   - GPIO master: remove redundant checks for valid pin descriptors

Changes in v6:
   - Remove redundant 'depends on' specifiers in Kconfig for SCOM
     GPIO master and Hub masters.

Changes in v5:
   - Remove explicit kfree of struct fsi_master in fsi_master_gpio.
   - Remove Palmetto and Romulus dts device tree file udates for FSI gpio
     master

Changes in v4:
   - endianness: the _read() and _write() APIs are now all *bus endian*,
     so will be the same on all platforms (the previous fsi patches
     exposed as (BMC/FSP) CPU endian, which is variable).
   - device tree: Remove the "ibm," prefix for the fsi core and GPIO
     master compatibility strings, as they're not describing
     IBM-specific
   - device model: Create separate struct devices for each FSI
     master, which fits better with the Linux device model, and allows
     addition of sysfs attributes that are implemented by the fsi core
   - sysfs: there are now sysfs facilities for break and term. Raw
     file supports reads and writes of arbitrary sizes.
   - GPIO master: split the xfer() logic out a little, so that the
     response handling & DPOLL retry mechanism is more obvious
   - GPIO master: simplifications for message construction
   - GPIO master: fixes for some CRC calculations
   - GPIO master: issue TERM in response to DPOLL busy-loops
   - Error handling: rather than handle errors on (potentially) an entire
     cascaded read or write, the error handling is now down on a per-slave
     basis, where we try to reestablish communication in a more "gradual"
     manner, rather than sending a break immediately. May need to add a
     hook to percolate error recovery up to a slave's master but no need
     seen for that at present.
   - Hub master: this is now implemented as a fsi engine driver, as the
     fsi_slave_{read,write}() functions are exported (and the port count
     is available in the hMFSI configuration register)
     This means we need fewer special-cases in the fsi core.
   - Tracepoints: Add tracepoints for FSI core read & write, and another
     set for low-level GPIO in/out operations.

Changes in v3:
    - Patch set contained an invalid 18/18 test patch not
      meant for community review, corrected.

Changes in v2:
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
    - Document all compatible strings used in device tree bindings.
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
    - Use get_optional interface for all optional GPIO pins.

Christopher Bostic (9):
  drivers/fsi: Document FSI master sysfs files in ABI
  drivers/fsi: Set up links for slave communication
  drivers/fsi: Set slave SMODE to init communication
  drivers/fsi: Add master unscan
  drivers/fsi: Add documentation for GPIO bindings
  drivers/fsi: Add client driver register utilities
  drivers/fsi: Add GPIO based FSI master
  drivers/fsi: Add SCOM FSI client device driver
  drivers/fsi: Add hub master support

Jeremy Kerr (14):
  drivers/fsi: Add fsi master definition
  drivers/fsi: Add slave definition
  drivers/fsi: Add empty master scan
  lib: Add crc4 module
  drivers/fsi: Add slave & master read/write APIs
  drivers/fsi: Implement slave initialisation
  drivers/fsi: scan slaves & register devices
  drivers/fsi: Add device read/write/peek API
  drivers/fsi: Add sysfs files for FSI master & slave accesses
  drivers/fsi: expose direct-access slave API
  drivers/fsi: Add tracepoints for low-level operations
  drivers/fsi: Add error handling for slave
  drivers/fsi/gpio: Add tracepoints for GPIO master
  drivers/fsi: Use asynchronous slave mode

 Documentation/ABI/testing/sysfs-bus-fsi            |  38 +
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    |  24 +
 drivers/fsi/Kconfig                                |  26 +
 drivers/fsi/Makefile                               |   3 +
 drivers/fsi/fsi-core.c                             | 836 +++++++++++++++++++++
 drivers/fsi/fsi-master-gpio.c                      | 604 +++++++++++++++
 drivers/fsi/fsi-master-hub.c                       | 327 ++++++++
 drivers/fsi/fsi-master.h                           |  43 ++
 drivers/fsi/fsi-scom.c                             | 263 +++++++
 include/linux/crc4.h                               |   8 +
 include/linux/fsi.h                                |  35 +-
 include/trace/events/fsi.h                         | 127 ++++
 include/trace/events/fsi_master_gpio.h             |  68 ++
 lib/Kconfig                                        |   8 +
 lib/Makefile                                       |   1 +
 lib/crc4.c                                         |  46 ++
 16 files changed, 2456 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
 create mode 100644 drivers/fsi/fsi-master-gpio.c
 create mode 100644 drivers/fsi/fsi-master-hub.c
 create mode 100644 drivers/fsi/fsi-master.h
 create mode 100644 drivers/fsi/fsi-scom.c
 create mode 100644 include/linux/crc4.h
 create mode 100644 include/trace/events/fsi.h
 create mode 100644 include/trace/events/fsi_master_gpio.h
 create mode 100644 lib/crc4.c

-- 
1.8.2.2
