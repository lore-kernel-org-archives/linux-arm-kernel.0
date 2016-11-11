From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 11 Nov 2016 02:05:01 +0100
Subject: [PATCH v9 2/8] power: add power sequence library
In-Reply-To: <1478573472-29516-3-git-send-email-peter.chen@nxp.com>
References: <1478573472-29516-1-git-send-email-peter.chen@nxp.com>
 <1478573472-29516-3-git-send-email-peter.chen@nxp.com>
Message-ID: <CAJZ5v0ioqMqoaJqK0CTXafWRKoohmZSiOWKRgVZ9DR3_8+-YDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2016 at 3:51 AM, Peter Chen <peter.chen@nxp.com> wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
>
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
>
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.

In the first place, please document this stuff better than you have so
far.  To a minimum, add kerneldoc comments to all new non-trivial new
functions to document what they are for and how they are expected to
be used (especially the ones exported to drivers).

Also, is there any guidance available for people who may want to use it?

> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  MAINTAINERS                           |   9 ++
>  drivers/power/Kconfig                 |   1 +
>  drivers/power/Makefile                |   1 +
>  drivers/power/pwrseq/Kconfig          |  19 ++++
>  drivers/power/pwrseq/Makefile         |   2 +
>  drivers/power/pwrseq/core.c           | 191 ++++++++++++++++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c | 183 ++++++++++++++++++++++++++++++++
>  include/linux/power/pwrseq.h          |  72 +++++++++++++
>  8 files changed, 478 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cd38a7..5dab975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9612,6 +9612,15 @@ F:       include/linux/pm_*
>  F:     include/linux/powercap.h
>  F:     drivers/powercap/
>
> +POWER SEQUENCE LIBRARY
> +M:     Peter Chen <Peter.Chen@nxp.com>
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> +L:     linux-pm at vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/power/pwrseq/
> +F:     drivers/power/pwrseq/
> +F:     include/linux/power/pwrseq.h/
> +
>  POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
>  M:     Sebastian Reichel <sre@kernel.org>
>  L:     linux-pm at vger.kernel.org
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 63454b5..c1bb046 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -1,3 +1,4 @@
>  source "drivers/power/avs/Kconfig"
>  source "drivers/power/reset/Kconfig"
>  source "drivers/power/supply/Kconfig"
> +source "drivers/power/pwrseq/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index ff35c71..7db8035 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_POWER_AVS)                += avs/
>  obj-$(CONFIG_POWER_RESET)      += reset/
>  obj-$(CONFIG_POWER_SUPPLY)     += supply/
> +obj-$(CONFIG_POWER_SEQUENCE)   += pwrseq/
> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 0000000..3859a67
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,19 @@
> +#
> +# Power Sequence library
> +#
> +
> +config POWER_SEQUENCE
> +       bool
> +
> +menu "Power Sequence Support"
> +
> +config PWRSEQ_GENERIC
> +       bool "Generic power sequence control"
> +       depends on OF
> +       select POWER_SEQUENCE
> +       help
> +          It is used for drivers which needs to do power sequence
> +          (eg, turn on clock, toggle reset gpio) before the related
> +          devices can be found by hardware. This generic one can be
> +          used for common power sequence control.

I wouldn't set it up this way.

There are two problems here.

First, say a distro is going to ship a multiplatform generic kernel.
How they are going to figure out whether or not to set the new symbol
in that kernel?

Second, how users are supposed to know whether or not they will need
it even if they build the kernel by themselves?

It would be better IMO to set things up to select the new symbol from
places making use of the code depending on it.

Thanks,
Rafael
