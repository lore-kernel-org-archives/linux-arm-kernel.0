From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  8 Jul 2011 09:54:06 +0100
Subject: [RFC PATCH v2 0/4] Core device subsystem
Message-ID: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a small number of devices that the core kernel needs very
early in the boot process, namely an interrupt controller and a timer,
long before the driver model is up and running.

Most architectures implement this requirement by hardcoding the
initialisation of a "well known" piece of hardware which is standard
enough to work on any platform.

This is very different on the ARM architecture, where platforms have a
variety of interrupt controllers and timers. While the same hardcoding
is possible (and is actually used), it makes it almost impossible to
support several platforms in the same kernel.

Though the device tree is helping greatly to solve this problem, some
platform won't ever be converted to DT, hence the need to have a
mechanism supporting a variety of information source. Early platform
devices having been deemed unsuitable (complexity, abuse of various
subsystems), this subsystem has been designed to provide the very
minimal level of functionality.

The "core device subsystem" offers a class based device/driver
matching model, doesn't rely on any other subsystem, is very (too?)
simple, and support getting information both from DT as well as from
static data provided by the platform. It also gives the opportunity to
define the probing order by offering a sorting hook at run-time.

As for the Linux driver model, the core device subsystem deals mainly
with device and driver objects. It also has the notion of "class" to
designate a group of devices implementing the same functionality, and
a group of drivers to be matched against the above devices
(CORE_DEV_CLASS_TIMER for example).

Tested on RealView PB-11MP (with both dt and non dt setups), and
Samsug SMDKv310 (non-dt only).
