From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Apr 2018 18:55:45 +0100
Subject: [PATCH 00/11] platform: device tree support for early platform
 drivers
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi bartosz,

On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Device tree based systems often use OF_DECLARE() macros for devices
> that need to be initialized early in the boot process such as clocks,
> timers etc. However platform devices are more desirable.
> 
> This series aims at introducing support for early platform drivers for
> OF-based systems.
> 
> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. We then need to call of_early_platform_populate() early
> in the boot process to actually probe the registered devices.
> 
> I am aware that this new compatible does not strictly correspond with
> the "hardware description only" rule of DT, but we already have many
> functionalities that break this rule: syscon, gpio hogs etc.

I don't think we need the "earlydev" string at all, and can still keep
the rest of this infrastrcuture if it is helpful.

So while I'm certainly oppposed to the "earlydev" string, I think that
the infrastrcuture could be useful.

> The first user of this new functionality will be the DaVinci platform
> for which we want to probe the pll, psc and timer drivers early in the
> boot sequence but keep them implemented as platform drivers.

Can we have early_paltform_driver() take a reference to the driver's
of_match_table, and put that in a special section?

Then instead of looking for "earlydev", we look for any compatible
string in that section. No magic string required in the DT, and we can
always mess around with probe ordering in future.

> In the future, if this series gets accepted, this could become and
> alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
> to deprecating of those macros in favor of early platform drivers.

IIRC we typically want to probe clocks before clocksources. Does using
early platform drivers ensure the necessary ordering?

Thanks,
Mark.

> Bartosz Golaszewski (11):
>   platform: early: provide early_platform_add_device()
>   platform: provide early_platform_driver_register_probe_all()
>   platform: make support for early platform devices conditional
>   of: platform: use pdev as name for vars of type struct platform_device
>   platform: use a dedicated list_head for early devices
>   of: provide for_each_compatible_child_node()
>   dt-bindings: add bindings for early devices
>   of: platform: provide of_early_platform_populate()
>   platform: provide early_platform_driver()
>   of: platform: provide of_early_platform_probe()
>   misc: implement a dummy early platform driver
> 
>  Documentation/devicetree/bindings/early.txt |   7 +
>  arch/sh/Kconfig                             |   1 +
>  drivers/base/Kconfig                        |   4 +
>  drivers/base/platform.c                     |  26 ++--
>  drivers/misc/Kconfig                        |   8 ++
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/dummy-early.c                  |  40 ++++++
>  drivers/of/device.c                         |  14 +-
>  drivers/of/platform.c                       | 143 +++++++++++++++-----
>  include/linux/device.h                      |   4 +
>  include/linux/of.h                          |   3 +
>  include/linux/of_device.h                   |   5 +
>  include/linux/of_platform.h                 |  19 +++
>  include/linux/platform_device.h             |  52 +++++++
>  14 files changed, 279 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/early.txt
>  create mode 100644 drivers/misc/dummy-early.c
> 
> -- 
> 2.17.0
> 
