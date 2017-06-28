From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 28 Jun 2017 15:56:33 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
Message-ID: <cover.1498642745.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am sending this RFC to get early comments before I put too much
effort in the solution proposed here. The solution isn't fully complete
yet.


Problem statement:

Some devices are powered ON by the bootloaders before the bootloader
handovers control to Linux. It maybe important for those devices to keep
working until the time a Linux device driver probes the device and
reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the machine is booting into
Linux. The LCD controller can be using some resources, like clk,
regulators, etc, that are shared between several devices. These shared
resources should be programmed so that all the users of them are
satisfied. If a user (X) driver gets probed before the LCD controller
driver in this case, then it may end up reconfiguring these resources to
ranges satisfying the current users (only user X) and that can make the
LCD screen unstable.

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
dependency on those.


What's left ?

There are a couple of problems which aren't solved yet:

o EPROBE_DEFER: Deferred probing is a major problem that needs to be
  solved. Because we want to add the constraint ASAP (i.e. before most
  of the drivers are registered), we would end up doing that right after
  the device is created. That is very early in the kernel boot cycle and
  its very much possible that the resource we need to get (in order to
  set the constraint) isn't available yet. Like regulator in case of
  supply constraint.
  
  Now how do we control that the constraint is set right after the
  resource is available, and before any other user of the resource comes
  up ?

  One way out is to set "driver_deferred_probe_enable" to 'true'
  (drivers/base/dd.c), after we got EPROBE_DEFER for any of the
  constraints. That would make sure that all the deferred drivers get a
  chance to get probed again, after addition of every new device.
  Without this change, we probe all the deferred devices only after
  late_init.

  But that may not work as it depends on a new workqueue thread for
  doing this work, and no one is stopping another driver to get
  registered by that time.

  I also thought about using the "functional dependency" stuff [1] that
  Rafael introduced earlier, but that too has its own challenges.
  Specifically, we may not have the device structures available for all
  the consumers/suppliers to start with.

o DT support will be added at first and I am planning to add the
  constraints right from drivers/of/platform.c after the AMBA and
  platform devices are created automatically from DT. Some sort of
  bindings (per constraint type) are required to be defined for that of
  course. We can think about other interfaces (like ACPI) as well, if we
  have any users right now.


But yeah, the first thing is to get some sort of feedback for the
proposed solution. :)

FWIW, I started discussing this with Mark Brown earlier [2] and this
series is a follow-up to that discussion.

--
viresh

[1] commit 9ed9895370ae ("driver core: Functional dependencies tracking support")
[2] https://marc.info/?l=linux-kernel&m=149423887617635

Viresh Kumar (5):
  drivers: Add boot constraints core
  drivers: boot_constraint: Add support for supply constraints
  drivers: boot_constraint: Add boot_constraints_disable kernel
    parameter
  drivers: boot_constraint: Add debugfs support
  drivers: Code to test boot constraints

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 drivers/base/Kconfig                            |  11 +
 drivers/base/Makefile                           |   1 +
 drivers/base/boot_constraint.c                  | 402 ++++++++++++++++++++++++
 drivers/base/dd.c                               |  20 +-
 drivers/base/test_plat_boot_constraint.c        |  51 +++
 include/linux/boot_constraint.h                 |  35 +++
 7 files changed, 515 insertions(+), 7 deletions(-)
 create mode 100644 drivers/base/boot_constraint.c
 create mode 100644 drivers/base/test_plat_boot_constraint.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.13.0.71.gd7076ec9c9cb
