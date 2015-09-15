From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 15 Sep 2015 17:50:56 +0100
Subject: [PATCH v4 0/5] SCPI sensors support
Message-ID: <1442335861-7282-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for SCPI based sensors for ARM development
platform. In addition to supporting sensors, when a temperature sensor
is discovered the driver registers the sensor with the thermal
framework.

The sensor patches here have been split out from a longer series
adding support for registering power model based cooling devices for
the CPU via device tree. Earliers postings can be seen at [0], [1], [2].

Patches 1-3 create a hwmon sensor driver for sensors provided by SCPI
firmware. Patch 4 adds support for the temperature sensors to register
with the thermal framework. This allows setting up platform thermals
using OF thermal bindings.

The last patch adds support for the sensors in the Juno r0 device
tree.

The patches depend on SCPI and mailbox patches[3] from Sudeep. The
SCPI protocol document with details of the sensor interface can be
found at [4].

I'd like to aim for merging the patches with the SCPI changes if
possible. The hwmon patches have been acked by Guenter. If there
aren't any objections, I would like to request acks for the binding
updates in Patch 1.

Thanks,
Punit

Changes v3 -> v4
  - clarified binding regarding use of sensor identifier

Changes v2 -> v3
  - split out the sensor patches (posted here)
  - rebase onto v4.3-rc1
  
Changes v1 -> v2
  - added documentation for the scpi-hwmon driver
  - replaced static allocation of platform structure in scpi-hwmon.c
    with dynamic allocation
  - re-structured registering of thermal zones to better handle
    error conditions
  - reduced chattiness in scpi-hwmon.c
  - corrected sensor numbering to align with hwmon documentation
  - dynamic allocation of attributes and attribute groups

[0] http://thread.gmane.org/gmane.linux.kernel/2002152
[1] http://thread.gmane.org/gmane.linux.kernel/2011466
[2] http://thread.gmane.org/gmane.linux.power-management.general/65475
[3] http://thread.gmane.org/gmane.linux.kernel/2009735
[4] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html

Punit Agrawal (5):
  Documentation: add DT bindings for ARM SCPI sensors
  firmware: arm_scpi: Extend to support sensors
  hwmon: Support sensors exported via ARM SCP interface
  hwmon: Support thermal zones registration for SCP temperature sensors
  arm64: dts: Add sensor node to Juno dt

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  38 +++
 Documentation/hwmon/scpi-hwmon                     |  33 +++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   5 +
 drivers/firmware/arm_scpi.c                        |  60 +++++
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scpi-hwmon.c                         | 288 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  17 ++
 8 files changed, 450 insertions(+)
 create mode 100644 Documentation/hwmon/scpi-hwmon
 create mode 100644 drivers/hwmon/scpi-hwmon.c

-- 
2.5.1
