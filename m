From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue,  9 Jan 2018 14:31:20 -0800
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
Message-ID: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>

Hello,

This patch set provides support for PECI of AST2400/2500 which can give us PECI
functionalities such as temperature monitoring, platform manageability,
processor diagnostics and failure analysis. Also provides generic peci.h and
peci_ioctl.h headers to provide compatibility to peci drivers that can be
implemented later e.g. Nuvoton's BMC SoC family.

The misc peci driver can be used as a multi-purpose PECI controller driver which
serializes all PECI transactions that coming from user space and from other
kernel modules. This misc peci driver could be replaced with other BMC chipsets'
implementation if the implementation provide compatible 'peci_ioctl'
inter-module call and ioctl scheme defined in peci.h and peci_ioctl.h files.

The hwmon peci driver implements a generic PECI hwmon feature which is running
with a PECI misc driver supports compatible native PECI command suite for
retrieving temperatures of the CPU package, CPU cores and DIMM components.

Please review.

-Jae

Jae Hyun Yoo (6):
  Documentation: dt-bindings: Add Aspeed PECI
  ARM: dts: aspeed: peci: Add Aspeed PECI
  drivers/misc: Add driver for Aspeed PECI and generic PECI headers
  Documentation: dt-bindings: Add a generic PECI hwmon
  Documentation: hwmon: Add a generic PECI hwmon
  drivers/hwmon: Add a driver for a generic PECI hwmon

 .../devicetree/bindings/hwmon/peci-hwmon.txt       |   33 +
 .../devicetree/bindings/misc/aspeed-peci.txt       |   55 +
 Documentation/hwmon/peci-hwmon                     |   74 ++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   14 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   14 +
 drivers/hwmon/Kconfig                              |    6 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/peci-hwmon.c                         |  953 +++++++++++++++++
 drivers/misc/Kconfig                               |    9 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/aspeed-peci.c                         | 1130 ++++++++++++++++++++
 include/misc/peci.h                                |   11 +
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/peci_ioctl.h                    |  270 +++++
 14 files changed, 2572 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-peci.txt
 create mode 100644 Documentation/hwmon/peci-hwmon
 create mode 100644 drivers/hwmon/peci-hwmon.c
 create mode 100644 drivers/misc/aspeed-peci.c
 create mode 100644 include/misc/peci.h
 create mode 100644 include/uapi/linux/peci_ioctl.h

-- 
2.7.4
