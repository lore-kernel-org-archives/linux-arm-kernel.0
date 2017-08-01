From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  1 Aug 2017 14:53:41 +0530
Subject: [PATCH V3 0/8] drivers: Boot Constraints core
Message-ID: <cover.1501578037.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here is V3 of the boot constraints core based on the feedbacks I have
received during V2. This tested on real hardware (Qcom dragonboard 410c)
with a display controller configured from bootloader to display a flash
screen. Obviously it doesn't work seamlessly without this series and
works just fine with it. Rajendra Nayak helped getting this tested on
Qcom hardware.

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
in this case, then it may end up reconfiguring these resources to ranges
satisfying the current users (only device X) and that can make the LCD
screen unstable.

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

This patchset introduces the concept of boot-constraints, which are set
by platform specific drivers (for now at least) at early init (like
subsys_initcall) and the kernel will satisfy them until the time driver
for such a device is probed (successfully or unsuccessfully). Once the
driver is probed, the driver core removes the constraints set for the
device. This series implements clk, regulator and PM domain constraints
for now.

The last patch isn't up for merge yet, and is used to test the boot
constraint framework on Qcom 410c along with some of the display
controller patches from Rob's series [1] to make sure the controller's
registers are configured properly.

Rebased over: drivers/driver-core-next (some debugfs dependencies)
Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git device/boot-constraints

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

[1] https://marc.info/?l=dri-devel&m=149979722606563&w=2

Rajendra Nayak (1):
  drivers: boot_constraint: Add Qualcomm display controller constraints

Viresh Kumar (7):
  drivers: Add boot constraints core
  drivers: boot_constraint: Add boot_constraints_disable kernel
    parameter
  drivers: boot_constraint: Add support for supply constraints
  drivers: boot_constraint: Add support for clk constraints
  drivers: boot_constraint: Add support for PM constraints
  drivers: boot_constraint: Add debugfs support
  drivers: boot_constraint: Manage deferrable constraints

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 drivers/base/Kconfig                            |  10 +
 drivers/base/Makefile                           |   1 +
 drivers/base/base.h                             |   1 +
 drivers/base/boot_constraints/Makefile          |   3 +
 drivers/base/boot_constraints/clk.c             |  74 ++++++
 drivers/base/boot_constraints/core.c            | 300 ++++++++++++++++++++++++
 drivers/base/boot_constraints/core.h            |  50 ++++
 drivers/base/boot_constraints/deferrable_dev.c  | 192 +++++++++++++++
 drivers/base/boot_constraints/pm.c              |  32 +++
 drivers/base/boot_constraints/qcom-display.c    | 107 +++++++++
 drivers/base/boot_constraints/supply.c          | 108 +++++++++
 drivers/base/dd.c                               |  32 ++-
 include/linux/boot_constraint.h                 |  68 ++++++
 14 files changed, 974 insertions(+), 7 deletions(-)
 create mode 100644 drivers/base/boot_constraints/Makefile
 create mode 100644 drivers/base/boot_constraints/clk.c
 create mode 100644 drivers/base/boot_constraints/core.c
 create mode 100644 drivers/base/boot_constraints/core.h
 create mode 100644 drivers/base/boot_constraints/deferrable_dev.c
 create mode 100644 drivers/base/boot_constraints/pm.c
 create mode 100644 drivers/base/boot_constraints/qcom-display.c
 create mode 100644 drivers/base/boot_constraints/supply.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.13.0.71.gd7076ec9c9cb
