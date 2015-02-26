From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Feb 2015 08:24:37 +0000
Subject: [PATCH v4 11/20] power_supply: Change ownership from driver to
 core
In-Reply-To: <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150226082437.GH6688@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Feb 2015, Krzysztof Kozlowski wrote:

> Change the ownership of power_supply structure from each driver
> implementing the class to the power supply core.
> 
> The patch changes power_supply_register() function thus all drivers
> implementing power supply class are adjusted.
> 
> Each driver provides the implementation of power supply. However it
> should not be the owner of power supply class instance because it is
> exposed by core to other subsystems with power_supply_get_by_name().
> These other subsystems have no knowledge when the driver will unregister
> the power supply. This leads to several issues when driver is unbound -
> mostly because user of power supply accesses freed memory.
> 
> Instead let the core own the instance of struct 'power_supply'.  Other
> users of this power supply will still access valid memory because it
> will be freed when device reference count reaches 0. Currently this
> means "it will leak" but power_supply_put() call in next patches will
> solve it.
> 
> This solves invalid memory references in following race condition
> scenario:
> 
> Thread 1: charger manager
> Thread 2: power supply driver, used by charger manager
> 
> THREAD 1 (charger manager)         THREAD 2 (power supply driver)
> ==========================         ==============================
> psy = power_supply_get_by_name()
>                                    Driver unbind, .remove
>                                      power_supply_unregister()
>                                      Device fully removed

[...]

>  include/linux/mfd/abx500/ux500_chargalg.h |  11 +-
>  include/linux/mfd/rt5033.h                |   2 +-
>  include/linux/mfd/wm8350/supply.h         |   6 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
