From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:48 +0530
Subject: [PATCH V4 00/12] drivers: Boot Constraints core
Message-ID: <cover.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here is V4 of the boot constraints core based on your feedback from V3.
We now have support for three platforms (as you suggested) included in
this series: Hisilicon, IMX and Qualcomm.

I have tested the Hisilicon patches on hikey 9660 board, IMX stuff is
tested by Sascha (Pengutronix) on i.MX6 and Qualcomm stuff is tested by
Rajendra (Qualcomm) on Dragonboard 410C (This required some more patches
related to display driver which Rajendra should be sending separately
later on).


Problem statement:

Some devices are powered ON by the bootloader before the bootloader
handovers control to Linux. It maybe important for those devices to keep
working until the time a Linux device driver probes the device and
reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the platform is booting into
Linux.  The LCD controller can be using some resources, like clk,
regulators, etc, that are shared between several devices. These shared
resources should be configured to satisfy need of all the users.  If
another device's (X) driver gets probed before the LCD controller driver
in this case, then it may end up disabling or reconfiguring these
resources to ranges satisfying the current users (only device X) and
that can make the LCD screen unstable.

Another case can be a debug serial port enabled from the bootloader.

Of course we can have more complex cases where the same resource is
getting used by two devices while the kernel boots and the order in
which devices get probed wouldn't matter as the other device will surely
break then.

There are also cases where the resources may not be shared, but the
kernel will disable them forcefully as no users may have appeared until
a certain point in kernel boot. This makes sure that the resources stay
enabled. A wide variety of constraints can be satisfied using the new
framework.

Proposed solution:

This series introduces the concept of "boot-constraints", which are set
by platform specific drivers (for now at least) at early init (like
subsys_initcall) and the kernel will keep satisfying them until the time
driver for such a device is probed (successfully or unsuccessfully).
Once the driver is probed, the driver core removes the constraints set
for the device. This series implements clk, regulator and PM domain
constraints currently.

Rebased over: driver-core/master
Targeted for: v4.16 (Sending it earlier for reviews mostly)

Pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git device/boot-constraints

V3->V4:
- Added support for imx, hikey and Qcom usecases.
- Enhanced boot constraints core to make drivers code easy and handle
  complex cases.
- Two new patches for OF included to provide APIs to boot constraint
  core.
- Removed the kernel parameter patch for now.
- Don't check return values of debugfs routines.
- Moved the boot constraints core from drivers/base/ to drivers/.

V2->V3:
- Removed DT support as we aren't sure about how to define the bindings
  yet.
- Added CLK and PM domain constraint types.
- A new directory is added for boot constraints, which will also contain
  platform specific drivers in future.
- Deferred devices are still supported, just that it wouldn't be called
  from generic code anymore but platform specific code.
- Tested on Qcom 410c dragonboard with display flash screen (Rajendra).
- Usual renaming/commit-log-updates/etc changes done.

V1->V2:
- Add support for setting constraints for devices created from DT.
- Allow handling deferred devices earlier then late_init.
- Remove 'default y' line from kconfig.
- Drop '=" after boot_constraints_disable kernel param.
- Dropped the dummy testing patch now.

--
viresh

Rajendra Nayak (1):
  boot_constraint: Add Qualcomm display controller constraints

Viresh Kumar (11):
  of: platform: Add of_find_amba_device_by_node()
  of: platform: Make of_platform_bus_create() global
  drivers: Add boot constraints core
  boot_constraint: Add support for supply constraints
  boot_constraint: Add support for clk constraints
  boot_constraint: Add support for PM constraints
  boot_constraint: Add debugfs support
  boot_constraint: Manage deferrable constraints
  boot_constraint: Add earlycon helper
  boot_constraint: Add support for Hisilicon platforms
  boot_constraint: Add support for IMX platform

 arch/arm/mach-imx/Kconfig                 |   1 +
 arch/arm64/Kconfig.platforms              |   2 +
 drivers/Kconfig                           |   2 +
 drivers/Makefile                          |   1 +
 drivers/base/dd.c                         |  32 +++-
 drivers/boot_constraints/Kconfig          |   9 +
 drivers/boot_constraints/Makefile         |   7 +
 drivers/boot_constraints/clk.c            |  73 ++++++++
 drivers/boot_constraints/core.c           | 271 ++++++++++++++++++++++++++++++
 drivers/boot_constraints/core.h           |  48 ++++++
 drivers/boot_constraints/deferrable_dev.c | 235 ++++++++++++++++++++++++++
 drivers/boot_constraints/hikey.c          | 145 ++++++++++++++++
 drivers/boot_constraints/imx.c            | 113 +++++++++++++
 drivers/boot_constraints/pm.c             |  31 ++++
 drivers/boot_constraints/qcom.c           | 123 ++++++++++++++
 drivers/boot_constraints/serial.c         |  28 +++
 drivers/boot_constraints/supply.c         | 107 ++++++++++++
 drivers/clk/imx/clk-imx25.c               |  12 --
 drivers/clk/imx/clk-imx27.c               |  13 --
 drivers/clk/imx/clk-imx31.c               |  12 --
 drivers/clk/imx/clk-imx35.c               |  10 --
 drivers/clk/imx/clk-imx51-imx53.c         |  16 --
 drivers/clk/imx/clk-imx6q.c               |   8 -
 drivers/clk/imx/clk-imx6sl.c              |   8 -
 drivers/clk/imx/clk-imx6sx.c              |   8 -
 drivers/clk/imx/clk-imx7d.c               |  14 --
 drivers/clk/imx/clk.c                     |  38 -----
 drivers/clk/imx/clk.h                     |   1 -
 drivers/of/platform.c                     |  28 ++-
 include/linux/boot_constraint.h           |  74 ++++++++
 include/linux/of_platform.h               |  21 +++
 31 files changed, 1340 insertions(+), 151 deletions(-)
 create mode 100644 drivers/boot_constraints/Kconfig
 create mode 100644 drivers/boot_constraints/Makefile
 create mode 100644 drivers/boot_constraints/clk.c
 create mode 100644 drivers/boot_constraints/core.c
 create mode 100644 drivers/boot_constraints/core.h
 create mode 100644 drivers/boot_constraints/deferrable_dev.c
 create mode 100644 drivers/boot_constraints/hikey.c
 create mode 100644 drivers/boot_constraints/imx.c
 create mode 100644 drivers/boot_constraints/pm.c
 create mode 100644 drivers/boot_constraints/qcom.c
 create mode 100644 drivers/boot_constraints/serial.c
 create mode 100644 drivers/boot_constraints/supply.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.15.0.rc1.236.g92ea95045093
