From: johan@kernel.org (Johan Hovold)
Date: Mon, 4 May 2015 10:49:25 +0200
Subject: [PATCH  0/2] gpio: Allow userspace export from DT
In-Reply-To: <20150413110515.9681.58848.stgit@localhost>
References: <20150413110515.9681.58848.stgit@localhost>
Message-ID: <20150504084925.GB4047@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 01:05:15PM +0200, Martin Fuzzey wrote:
> Currently the gpio sysfs interface allows userspace to access simple hardware
> where no kernel driver exists or would be useful.
> 
> However it requires userspace to know the gpio number that has been assigned
> by the kernel.
> 
> That number, in the case of gpio drviers using dynamic allocation, is not fixed,
> and may change when:
> * The kernel version changes and ARCH_NR_GPIOS is changed (happened in 3.17)
> * The kernel version changes and probe order changes for gpio chips.
> * The kernel configuration is changed if CONFIG_ARCH_NR_GPIO is used
> * The board is redesigned (eg switching an externally visible signal from a
> SoC provided GPIO to an I2C expander chip or vice versa).
> * Other GPIO chips are added to the system.
> 
> The above means that, in order to export the GPIO to userspace via
> /sys/class/gpio/export the userspace code must know the exact hardware and
> kernel version information.

Not quite. You can still determine the gpio number in the above cases by
walking the sysfs tree to find the chip and it's base. This is the only
way to do this for dynamic buses such as USB.

The only case for which this fails is if a pin function is moved (e.g.
your i2c-expander case above).

> Furthermore, in many cases, it makes no sense to allow userspace to
> change the signal direction; even if the GPIO itself allows it the
> circuitry connected to the pin often does not (eg a signal dedicated
> to an output function driving a  transistor).

Indeed. The current sysfs-interface is a hack (which I personally think
never should have been merged).

Firmware should describe pin directionality and function, and undefined
pins should never be allowed to be accessed from userspace.

Sure, the current GPIO-sysfs-interface is useful during development and
for one-off hacks, but I'm convinced it's detrimental in the long run as
it removes the incentives to fix the driver code that it's used to work
around (e.g. custom init script to toggle enable lines of some radio
chips).

> This patch series solves both problems by performing the external
> signal => GPIO mapping in the device tree.

As Rob already mentioned, what we want is some way to declare pin
functions. These could then be requested from userspace (or used in DT,
something which should allow for further refactoring there as well)
unless a driver has already claimed them.

We don't want to add more dependencies on the current sysfs-based
interface, which I hope we'll one day will be able to retire in favour
of a more sane one.

Johan
