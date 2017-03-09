From: carlo@caione.org (Carlo Caione)
Date: Thu,  9 Mar 2017 11:17:57 +0100
Subject: [PATCH v3 0/2] scpi-sensors: Fix SCP sensor readings scale
Message-ID: <20170309101759.18081-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The implementation details for SCPI seems to suggest that the sensor
readings must be reported by SCP using a well defined scale
(millidegree Celsius for temperature, millivolts for voltage,
milliamperes for current, microwatts for power and microjoules for
energy).

This is also important for the interaction with other subsystems: for
example both the thermal sub-system and the hwmon sysfs interface expect
the temperature expressed in millidegree Celsius.

Unfortunately since this behaviour is dependent on the firmware
implementation there are cases where the sensor readings are reported
using a different scale. For example in the Amlogic SoCs the
temperature is reported in degree and not millidegree Celsius.

In this patchset we introduce a new DT property `scpi,sensors-scale` that is
used by the scpi-hwmon driver to convert the sensor readings to the expected
scale.

v2:
 - Added data validation (scale != 0)
 - s/unsigned int/u32/ for the array
 - Switched to array initialiser notation
 - Introduced scpi_scale_reading()

v3:
 - scpi_scale_reading marked as static

Carlo Caione (2):
  Documentation: bindings: Introduce scpi,sensors-scale
  hwmon: (scpi) Fix the scale of SCP sensor readings

 Documentation/devicetree/bindings/arm/arm,scpi.txt | 18 ++++++++++++
 drivers/hwmon/scpi-hwmon.c                         | 34 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.9.3
