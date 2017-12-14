From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 21:03:07 +0530
Subject: [PATCH V5 00/13] drivers: Boot Constraint core
Message-ID: <cover.1513264961.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here is V5 of the boot constraints core based on your feedback from V4.
Hope this looks better now :)

I have tested the Hisilicon patches (again) on hikey 9660 board, IMX
stuff was earlier tested by Sascha (Pengutronix) on i.MX6 and Qualcomm
stuff was earlier tested by Rajendra (Qualcomm) on Dragonboard 410C
(This required some more patches related to display driver which
Rajendra should be sending separately later on).


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

This series introduces the concept of "boot-constraint", which are set
by platform specific drivers (for now at least) at early init (like
subsys_initcall) and the kernel will keep satisfying them until the time
driver for such a device is probed (successfully or unsuccessfully).
Once the driver is probed, the driver core removes the constraints set
for the device. This series implements clk, regulator and PM domain
constraints currently.

Targeted for: v4.16

Pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git boot-constraints

V4->V5:
- SPDX Licence format used.
- arm,primecell stuff removed from boot constraint core and added a
  helper in OF core (which already handles amba and platform devices).
- Removed a bunch of BUG_ON(), pr_fmt(), comments.
- Changed directory and other names from
  boot_constraints/boot_constraint.
- Removed serial.o file and moved the code to hikey and imx files.
- Don't return error from dummy helper.
- Added documentation and corresponding kernel doc comments in the code.
- Updated MAINTAINERS.

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

Viresh Kumar (12):
  of: platform: Add of_find_any_device_by_node()
  of: platform: Make of_platform_bus_create() global
  drivers: Add boot constraints core
  boot_constraint: Add support for supply constraints
  boot_constraint: Add support for clk constraints
  boot_constraint: Add support for PM constraints
  boot_constraint: Add debugfs support
  boot_constraint: Manage deferrable constraints
  boot_constraint: Add support for Hisilicon platforms
  boot_constraint: Add support for IMX platform
  boot_constraint: Update MAINTAINERS
  boot_constraint: Add documentation

 .../driver-api/boot-constraint/constraints.rst     |  98 +++++++
 Documentation/driver-api/boot-constraint/index.rst |   4 +
 Documentation/driver-api/index.rst                 |   1 +
 MAINTAINERS                                        |   9 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 arch/arm64/Kconfig.platforms                       |   2 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/dd.c                                  |  32 ++-
 drivers/boot_constraint/Kconfig                    |   9 +
 drivers/boot_constraint/Makefile                   |   7 +
 drivers/boot_constraint/clk.c                      |  70 +++++
 drivers/boot_constraint/core.c                     | 290 +++++++++++++++++++++
 drivers/boot_constraint/core.h                     |  47 ++++
 drivers/boot_constraint/deferrable_dev.c           | 241 +++++++++++++++++
 drivers/boot_constraint/hikey.c                    | 158 +++++++++++
 drivers/boot_constraint/imx.c                      | 126 +++++++++
 drivers/boot_constraint/pm.c                       |  28 ++
 drivers/boot_constraint/qcom.c                     | 122 +++++++++
 drivers/boot_constraint/supply.c                   | 104 ++++++++
 drivers/clk/imx/clk-imx25.c                        |  12 -
 drivers/clk/imx/clk-imx27.c                        |  13 -
 drivers/clk/imx/clk-imx31.c                        |  12 -
 drivers/clk/imx/clk-imx35.c                        |  10 -
 drivers/clk/imx/clk-imx51-imx53.c                  |  16 --
 drivers/clk/imx/clk-imx6q.c                        |   8 -
 drivers/clk/imx/clk-imx6sl.c                       |   8 -
 drivers/clk/imx/clk-imx6sx.c                       |   8 -
 drivers/clk/imx/clk-imx7d.c                        |  14 -
 drivers/clk/imx/clk.c                              |  38 ---
 drivers/clk/imx/clk.h                              |   1 -
 drivers/of/platform.c                              |  63 ++++-
 include/linux/boot_constraint.h                    | 121 +++++++++
 include/linux/of_platform.h                        |  16 ++
 34 files changed, 1541 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/driver-api/boot-constraint/constraints.rst
 create mode 100644 Documentation/driver-api/boot-constraint/index.rst
 create mode 100644 drivers/boot_constraint/Kconfig
 create mode 100644 drivers/boot_constraint/Makefile
 create mode 100644 drivers/boot_constraint/clk.c
 create mode 100644 drivers/boot_constraint/core.c
 create mode 100644 drivers/boot_constraint/core.h
 create mode 100644 drivers/boot_constraint/deferrable_dev.c
 create mode 100644 drivers/boot_constraint/hikey.c
 create mode 100644 drivers/boot_constraint/imx.c
 create mode 100644 drivers/boot_constraint/pm.c
 create mode 100644 drivers/boot_constraint/qcom.c
 create mode 100644 drivers/boot_constraint/supply.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.15.0.194.g9af6a3dea062
