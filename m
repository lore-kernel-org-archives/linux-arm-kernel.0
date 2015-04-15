From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 Apr 2015 08:19:52 -0500
Subject: [PATCH 0/2] gpio: Allow userspace export from DT
In-Reply-To: <20150413110515.9681.58848.stgit@localhost>
References: <20150413110515.9681.58848.stgit@localhost>
Message-ID: <CAL_JsqJorndYh4ROdKbJfpG1KY=Xosjc6BMFYRPrb+BsauFsnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 6:05 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> Currently the gpio sysfs interface allows userspace to access simple hardware
> where no kernel driver exists or would be useful.

Whether or not a kernel driver exists can vary by kernel version. The
dtb needs to work either way. The way you have done it would require
dtb changes.

It would be useful to describe the function of gpios in a way that
either subsystems can bind to them (e.g. leds, rf-kill, keys, etc.) or
that information can be exported to userspace.

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

Isn't there some plan/desire to fix the GPIO sysfs interface?

> The above means that, in order to export the GPIO to userspace via
> /sys/class/gpio/export the userspace code must know the exact hardware and
> kernel version information.
>
> Furthermore, in many cases, it makes no sense to allow userspace to change the
> signal direction; even if the GPIO itself allows it the circuitry connected
> to the pin often does not (eg a signal dedicated to an output function driving
> a  transistor).
>
> This patch series solves both problems by performing the external
> signal => GPIO mapping in the device tree.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
