From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 03:35:37 -0700
Subject: [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1364488523-20310-4-git-send-email-p.zabel@pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <1364488523-20310-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 28, 2013 at 9:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/reset/gpio-reset.txt       |  37 ++++
>  drivers/reset/Kconfig                              |  13 ++
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/gpio-reset.c                         | 208 +++++++++++++++++++++
>  4 files changed, 259 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.txt
>  create mode 100644 drivers/reset/gpio-reset.c
>
> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> new file mode 100644
> index 0000000..1f203eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> @@ -0,0 +1,37 @@
> +GPIO reset controller
> +=====================
> +
> +A GPIO reset controller controls a number of GPIOs that are connected
> +to reset pins of peripheral ICs.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be "gpio-reset"
> +- reset-gpios: List of gpios used as reset lines. The gpio specifier for this
> +               property depends on the gpio controller that provides the gpio.
> +- #reset-cells: 1, see below
> +
> +Optional properties:
> +- reset-delays: List of delays in microseconds. The corresponding gpio reset
> +                line should be asserted for this duration to reset.
> +- initially-in-reset: List of integers. Zero if the initial state should be
> +                      a deasserted reset line, nonzero if the line should be
> +                      kept in reset.
> +
> +example:
> +
> +gpio_reset: gpio-reset {
> +       compatible = "gpio-reset";
> +       reset-gpios = <&gpio5 0 1>; /* active-low */
> +       reset-delays = <10000>; /* 10 ms */
> +       initially-in-reset: <1>;
> +       #reset-cells = <1>;
> +};

I find this binding that uses an array of GPIOs and their state to be
a bit awkward, especially if you compare it to something like the
simple gpio regulators that have a simpler one-to-one mapping.

Also, if you did one node per gpio you'd have a boolean property for
"initially-in-reset" which seems much more logical (i.e. the property
is either there, or it's not).

A couple of more comments:

> +config RESET_GPIO
> +       tristate "GPIO reset controller support"
> +       depends on GENERIC_GPIO
> +       help
> +         This driver provides support for reset lines that are controlled
> +         directly by GPIOs.
> +         The delay between assertion and de-assertion of the reset signal
> +         can be configured.

Can be configured how? And why would I care about that when I'm trying
to decide if I need to include this driver in my kernel configuration
or not? Seems like misplaced information.

Since this is a platform driver and not just an OF driver, shouldn't
you provide a way to specify the same configuration data through a
platform_data structure as well?


-Olof
