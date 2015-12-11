From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 13:39:32 +0100
Subject: [PATCH 1/3] Device tree binding documentation for gpio-switch
In-Reply-To: <1449250275-23435-2-git-send-email-martyn.welch@collabora.co.uk>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-2-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <CACRpkdYZ-PK9Fb2uq+EMz5RTrtX-isxYkiNvWm2QqAh5WZhpOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 4, 2015 at 6:31 PM, Martyn Welch
<martyn.welch@collabora.co.uk> wrote:

> This patch adds documentation for the gpio-switch binding. This binding
> provides a mechanism to bind named links to gpio, with the primary
> purpose of enabling standardised access to switches that might be standard
> across a group of devices but implemented differently on each device.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>

As mentioned in the comment to the second patch, this solves the
following generic problem:

Expose a GPIO line to userspace using a specific name

That means basically naming GPIO lines and marking them as
"not used by the operating system".

This is something that has been proposed before, and postponed
because the kernel lacks the right infrastructure.

Markus Pargmann also did a series that add initial values to
hogs, which is the inverse usecase of this, where you want to
*output* something by default, then maybe also make it available
to userspace.

So what we need to see here is a patch series that does all of these
things:

- Name lines

- Sets them to initial values

- Mark them as read-only

- Mark them as "not used by the operating system" so that they
  can be default-exported to userspace.

Making *USE* of this naming etc inside the Linux kernel

> +        gpio-switch {
> +                compatible = "gpio-switch";
> +
> +                write-protect {
> +                        label = "write-protect";
> +                        gpios = <&gpx3 0 GPIO_ACTIVE_LOW>;
> +                        read-only;
> +                };

This should not need new structures and nodes like this. It should
be part of Documentation/devicetree/bindings/gpio/gpio.txt
and put directly in the gpiochip node.

Maybe as an extension of the existing hogs, but that has already
been tried.

While we can agree on a device tree binding, the kernel still needs
major refactoring to actually expose named GPIOs to userspace,
and that should be done using the new chardev, not with sysfs
links.

Yours,
Linus Walleij
