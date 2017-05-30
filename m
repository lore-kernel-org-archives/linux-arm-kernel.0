From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 May 2017 11:05:05 +0200
Subject: [PATCH v4 0/2] scpi-sensors: Fix SCP sensor readings scale
Message-ID: <20170530090507.16611-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Sorry for the delay. This is the follow-up on the patches about scpi-sensors
with the fix suggested in [0].

The previous version is at [1].

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

In this patchset we introduce a new DT compatible
'amlogic,meson-gxbb-scpi-sensors' that is used by the scpi-hwmon driver to
convert the sensor readings to the expected scale.

v2:
 - Added data validation (scale != 0)
 - s/unsigned int/u32/ for the array
 - Switched to array initialiser notation
 - Introduced scpi_scale_reading()

v3:
 - scpi_scale_reading marked as static

v4:
 - Removed new binding and added a new compatible instead

[0] https://patchwork.kernel.org/patch/9612959/
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492553.html

Carlo Caione (2):
  Documentation: bindings: add amlogic,meson-gxbb-scpi-sensors
    compatible
  hwmon: (scpi) Fix the scale of SCP sensor readings

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  2 +-
 drivers/hwmon/scpi-hwmon.c                         | 54 +++++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.9.3
