From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 26 Apr 2018 17:29:18 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early platform
 drivers
Message-ID: <20180426152920.21569-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow to my series[1] the aim of which was to introduce device tree
support for early platform devices.

It was received rather negatively. Aside from using device tree to pass
implementation specific details to the system, two important concerns were
raised: no probe deferral support and the fact that currently the early devices
never get converted to actual platform drivers. This series is a
proof-of-concept that's trying to address those issues.

The only user of the current version of early platform drivers is the SuperH
architecture. If this series eventually gets merged, we could simply replace
the other solution.

The current implementation of early platform drivers is pretty much a hack
built on top of the early_param mechanism. The devices only look like platform
devices and use the same structures but never actually get registered with the
driver model.

The idea behind this series is to allow users to probe platform devices very
early in the boot sequence and then switch the early devices to actual platform
devices and the early drivers to platform drivers in during device_initcall.

If any of the early registration functions is called after device_initcall,
we'll just end up calling the normal platform_driver/device_register routines.

The user can specify if he wants the device to be probed the second time after
this conversion and the check if it's an early or a normal probe from the
driver code.

We also support a simple version of probe deferral: initially each new
registered device is added to the head of the early devices list. If it matches
an early driver, it will be probed. If probe return -EPROBE_DEFER, it will be
moved to the tail of the list and reprobed the next time we match a device
but after all other devices.

This implementation has certain shortcomings that will be addressed if the
feedback is at least somewhat positive. For instance: the driver registration
happens in early_initcall(). This may be too late for certain clocksource or
clk drivers. The solution for that would be defining a new section in which the
init callbacks of the drivers would reside and let the architecture call the
actual registration function whenever it's needed.

I also need to figure out if any locking is needed.

We don't support DT in this series either. The proposed approach would be to
walk over the devices nodes early in the boot sequence and allocate and probe
the matching early devices and then register them with the driver model later.

[1] https://lkml.org/lkml/2018/4/24/937

Bartosz Golaszewski (2):
  earlydev: implement a new way to probe platform devices early
  misc: implement a dummy early platform driver

 drivers/base/Kconfig            |   3 +
 drivers/base/Makefile           |   1 +
 drivers/base/earlydev.c         | 175 ++++++++++++++++++++++++++++++++
 drivers/base/platform.c         |  11 ++
 drivers/misc/Kconfig            |   8 ++
 drivers/misc/Makefile           |   1 +
 drivers/misc/dummy-early.c      |  46 +++++++++
 include/linux/earlydev.h        |  63 ++++++++++++
 include/linux/platform_device.h |   4 +
 9 files changed, 312 insertions(+)
 create mode 100644 drivers/base/earlydev.c
 create mode 100644 drivers/misc/dummy-early.c
 create mode 100644 include/linux/earlydev.h

-- 
2.17.0
