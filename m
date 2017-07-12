From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:04:30 +0530
Subject: [RFC v2 0/6] drivers: Boot Constraints core
Message-ID: <cover.1499770771.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg and others,

I am sending the V2 for this series after waiting for just 2 weeks
because this one presents a clearer picture on how is this going to get
used. V2 has gained updates for adding the constraints for platform and
AMBA devices created from DT.

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


Proposed solution:

This patchset introduces the concept of boot-constraints, which are set
by the different parts of the kernel (on behalf of the bootloaders) and
the kernel will satisfy them until the time driver for such a device is
probed (successfully or unsuccessfully). Once the driver's probe()
routine is called, the driver core removes the constraints set for the
particular device. Only the power-supply constraint type is supported
for now.

This can be used across platforms working with DT, ACPI, etc and has no
dependency on those. The last two patches add support to set these
constraints automatically for the devices created via DT.

V1->V2:
- Add support for setting constraints for devices created from DT.
- Allow handling deferred devices earlier then late_init.
- Remove 'default y' line from kconfig.
- Drop '=" after boot_constraints_disable kernel param.
- Dropped the dummy testing patch now.

It is tested on ARM hikey ARM64 platform and compile testing is done for
X86 as well (without enabling boot constraints config option).

--
viresh

Viresh Kumar (6):
  drivers: Add boot constraints core
  drivers: boot_constraint: Add support for supply constraints
  drivers: boot_constraint: Add boot_constraints_disable kernel
    parameter
  drivers: boot_constraint: Add debugfs support
  drivers: boot_constraint: Add initial DT bindings
  drivers: boot_constraint: Add constraints for OF devices

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 .../devicetree/bindings/boot-constraints.txt       |  68 ++++
 drivers/base/Kconfig                               |  10 +
 drivers/base/Makefile                              |   4 +
 drivers/base/base.h                                |   1 +
 drivers/base/boot_constraint.c                     | 404 +++++++++++++++++++++
 drivers/base/boot_constraint_of.c                  | 122 +++++++
 drivers/base/dd.c                                  |  32 +-
 drivers/of/platform.c                              |   4 +
 include/linux/boot_constraint.h                    |  44 +++
 10 files changed, 685 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/boot-constraints.txt
 create mode 100644 drivers/base/boot_constraint.c
 create mode 100644 drivers/base/boot_constraint_of.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.13.0.71.gd7076ec9c9cb
