From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 13 Apr 2015 13:05:15 +0200
Subject: [PATCH  0/2] gpio: Allow userspace export from DT
Message-ID: <20150413110515.9681.58848.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the gpio sysfs interface allows userspace to access simple hardware
where no kernel driver exists or would be useful.

However it requires userspace to know the gpio number that has been assigned
by the kernel.

That number, in the case of gpio drviers using dynamic allocation, is not fixed,
and may change when:
* The kernel version changes and ARCH_NR_GPIOS is changed (happened in 3.17)
* The kernel version changes and probe order changes for gpio chips.
* The kernel configuration is changed if CONFIG_ARCH_NR_GPIO is used
* The board is redesigned (eg switching an externally visible signal from a
SoC provided GPIO to an I2C expander chip or vice versa).
* Other GPIO chips are added to the system.

The above means that, in order to export the GPIO to userspace via
/sys/class/gpio/export the userspace code must know the exact hardware and
kernel version information.

Furthermore, in many cases, it makes no sense to allow userspace to change the
signal direction; even if the GPIO itself allows it the circuitry connected
to the pin often does not (eg a signal dedicated to an output function driving
a  transistor).

This patch series solves both problems by performing the external
signal => GPIO mapping in the device tree.
