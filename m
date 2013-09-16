From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:06 +0100
Subject: [PATCH v4 00/20] iio: ST clean-ups and new sensor support
Message-ID: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Hopefully I've covered all of your points in this new set.

This patch-set includes a few clean-ups surrounding error handling and
non-mandatory functionality along with regulator support and the addition
of a new pressure/temperature sensor (LPS001WP).

Everything has been tested with Device Tree.

v2:
 - Rebased onto Linux -next as requested by Jonathan
 - Reworked clean-up patch to address Jonathan's concerns
 - Added binding document (inc regulators)
 - Extended regulator support in the driver
 - Re-worked Data Ready pin handling

v3:
 - Standardise sensor names: <model>_<sensor-type>
 - Added error handling clean-ups
 - More binding documents; for magn, accel and gyro
 - Message on successful sensor bring-up; for press, magn, accel and gyro
 - More device enablement for ux500 by way of CONFIGs
 - New neat reorder/grouping of patches

v4:
 - Remove "registered" prints
 - Remove *_<dev_name> appends
 - Fix patch mangle
 - CC DT ML on bindings
 - Realisation that we're using a different Accel & Magn chip
 - Move (irq > 0) back into the error path
 - Squash CONFIG enablement into one patch

 Documentation/devicetree/bindings/iio/accel/lsm303dlhc.txt        |  21 +++++++++++++
 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt           |  21 +++++++++++++
 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt |  21 +++++++++++++
 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt       |  21 +++++++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                                 |   5 ----
 arch/arm/boot/dts/ste-snowball.dts                                |  34 +++++++++++++++++++++
 arch/arm/configs/u8500_defconfig                                  |   5 ++++
 drivers/iio/accel/st_accel_core.c                                 |  19 ++++++------
 drivers/iio/common/st_sensors/st_sensors_core.c                   |  50 ++++++++++++++++++-------------
 drivers/iio/gyro/st_gyro_core.c                                   |  19 ++++++------
 drivers/iio/magnetometer/st_magn_core.c                           |  19 ++++++------
 drivers/iio/pressure/st_pressure.h                                |   1 +
 drivers/iio/pressure/st_pressure_core.c                           | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/iio/pressure/st_pressure_i2c.c                            |   1 +
 include/linux/iio/common/st_sensors.h                             |   5 ++++
 15 files changed, 329 insertions(+), 67 deletions(-)
