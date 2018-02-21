From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:49 +0530
Subject: [PATCH 00/10] Implementation of Tegra Tachometer driver
Message-ID: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches adds support for PWM based Tegra Tachometer driver
which implements PWM capture interface to analyze the PWM signal of a
electronic fan and reports it in periods and duty cycles.

Generic PWM Tachometer implemented to monitor the speed of fan in rpms
using PWM interface. RPM of Fan will be exposed to user interface through
HWMON sysfs interface avialable at below location
/sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm

Steps to validate Tachometer:
A. push modules pwm-tegra.ko, pwm-tegra-tachometer.ko and
   generic-pwm-tachometer.ko to linux device using scp command.
   scp build/tegra186/drivers/pwm/pwm-tegra.ko ubuntu at 10.19.65.176:/tmp/
   scp build/tegra186/drivers/pwm/pwm-tegra-tachometer.ko ubuntu at 10.19.65.176:/tmp/
   scp build/tegra186/drivers/hwmon/generic-pwm-tachometer.ko ubuntu at 10.19.65.176:/tmp/
B. On Linux device console, insert these modules using insmod command.
   insmod /tmp/pwm-tegra.ko
   insmod /tmp/pwm-tegra-tachometer.ko
   insmod /tmp/generic-pwm-tachometer.ko
C. Read RPM value at below sysfs node
   cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
D. Change the FAN speed using PWM sysfs interface. Follow below steps for the same:
   a. cd /sys/class/pwm/pwmchip0
   b. ls -la (make sure pwm controller is c340000.pwm)
      Output should be: device -> ../../../c340000.pwm
   c. echo 0 > export
   d. cd pwmchip0:0
   e. echo 8000 > period
   f. echo 1 > enable
   g. echo 7000 > duty_cycle # change duty_cycles from 0 to 7000 and see FAN speed
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 4000 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 2000 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 0 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm

Rajkumar Rampelli (10):
  pwm: core: Add support for PWM HW driver with pwm capture only
  dt-bindings: Tegra186 tachometer device tree bindings
  pwm: tegra: Add PWM based Tachometer driver
  hwmon: generic-pwm-tachometer: Add DT binding details
  hwmon: generic-pwm-tachometer: Add generic PWM based tachometer
  arm64: tegra: Add Tachometer Controller on Tegra186
  arm64: tegra: Add PWM based Tachometer support on Tegra186
  arm64: defconfig: enable Nvidia Tegra Tachometer as a module
  arm64: defconfig: Enable Generic PWM based Tachometer driver
  arm64: tegra: Add PWM controller on Tegra186 soc

 .../bindings/hwmon/generic-pwm-tachometer.txt      |  25 ++
 .../bindings/pwm/pwm-tegra-tachometer.txt          |  31 +++
 Documentation/hwmon/generic-pwm-tachometer         |  17 ++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   5 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/generic-pwm-tachometer.c             | 112 ++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   4 +
 drivers/pwm/pwm-tegra-tachometer.c                 | 303 +++++++++++++++++++++
 13 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
 create mode 100644 Documentation/hwmon/generic-pwm-tachometer
 create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
 create mode 100644 drivers/pwm/pwm-tegra-tachometer.c

-- 
2.1.4
