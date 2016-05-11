From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 11 May 2016 12:13:06 +0200
Subject: [PATCH v8 0/2] memory: add Atmel EBI (External Bus Interface) driver
Message-ID: <1462961588-23004-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EBI (External Bus Interface) is used to access external peripherals
(NOR, SRAM, NAND, and other specific devices like ethernet controllers).
Each device is assigned a CS line and an address range and can have its
own configuration (timings, access mode, bus width, ...).
This driver provides a generic DT binding to configure a device according
to its requirements.
For specific device controllers (like the NAND one) the SMC timings
should be configured by the controller driver through the matrix and
smc syscon regmaps.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Changes since v7:
- move EBI bus config properties directly in the sub-device node
- prefix all EBI/SMC properties with atmel,smc-
- rework the driver to take the new binding into account
- disable the subdevice when EBI implementation fails to configure
  the bus as requested

Changes since v6:
- rework the binding to put per-device config information into a
  separate subnode and have devices connected to the EBI bus
  defined as direct children of the EBI node
- make all EBI timings mandatory
- keep adding sub-devices when a failure occurs on one of them

Changes since v5:
- remove the "atmel,specialized-logic" property: now all devices are
  are attached to the SMC logic by default, and specialized drivers
  (like the NAND controller one), should change this configuration
  manually.
- provide hardware readout to allow partial config description.
  This is mainly here to keep existing platforms (where everything
  is configured by the bootloader/bootstrap) in working state.
- rename "atmel,tdf-optimized" into "atmel,tdf-mode" and switch from
  a boolean to string property to properly support partial config

Changes since v4:
- fix inconsistencies in SMC and MATRIX registers definition
- add missing compatible strings for at91sam9rl SoC
- fix DT bindings documentation
- replace "atmel,generic-dev" property by "atmel,specialized-logic"

Changes since v3:
- added AT91_MATRIX_USBPUCR_PUON definition
- removed useless macros (those directly returning SoC specific register
  offsets)
- use syscon_regmap_lookup_by_phandle instead of of_parse_phandle +
  syscon_node_to_regmap
- drop AT91_EBICSA_REGFIELD and AT91_MULTI_EBICSA_REGFIELD macros

Changes since v2:
- minor fixes int DT bindings doc
- fix SMC macros
- make use of SMC macros defined in include/linux/mfd/syscon/atmel-smc.h

Changes since v1:
- almost everything :-)

Boris Brezillon (2):
  memory: add Atmel EBI (External Bus Interface) driver
  memory: atmel-ebi: add DT bindings documentation

 .../bindings/memory-controllers/atmel,ebi.txt      | 136 ++++
 drivers/memory/Kconfig                             |  11 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/atmel-ebi.c                         | 771 +++++++++++++++++++++
 4 files changed, 919 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
 create mode 100644 drivers/memory/atmel-ebi.c

-- 
2.7.4
