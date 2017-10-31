From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 12:17:15 +0200
Subject: [PATCH v4 0/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509445035.10233.108.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 15:33 +0800, Phil Reid wrote:
> Changes from V3:
> - rebase on i2c/for-next
> - Add patches to convert other drivers using gpio recover to gpiod
> - Remove legacy gpio
> - Address minor issues raised in review and add acks received so far
> 
> Changes from V2:
> - Rebase on https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.
> git/
>   i2c/for-next
>   No intentional changes, but needed to move i2c_dw_plat_prepare_clk
> to common
>   for the master recovery functions to use. which is included as two
> additional
>   patches.
> 
> Changes from V1:
> - In review Andy suggested change the i2c core to use the gpiod
>   I've added a patch that allows the gradual switching of drivers 
>   to using gpiod interface. The old interface is preserved so
>   that changes can be made incrementally.
> - I've update Tim's patch for the designware driver to use the new
>   interface. Tweaked a couple of things to his patch and fixed
>   up things Andy id in last review. 
>   The core changes in p1 don't require the get/set scl/sda functions.
>   Hopefully I've done the right thing with preserving authorship and
>   signoff.

I like the series (esp. last patch), I hope Jarkko would be able to
check (and test on DW I2C) this as well.

No objections from me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.?. One minor comment is a naming of new function. Legacy one uses
_gpio_ as pointer to mechanism of recovery, the new one uses plain _scl_
which might be not so obvious. Unfortunately I have no (good)
alternatives to propose (perhaps _gpiod_ ?), thus leave this to Jarkko
and Wolfram.

> 
> 
> Phil Reid (6):
>   i2c: Switch to using gpiod interface for gpio bus recovery
>   i2c: designware: move i2c_dw_plat_prepare_clk to common
>   i2c: designware: rename i2c_dw_plat_prepare_clk to
> i2c_dw_prepare_clk
>   i2c: imx: switch to using gpiod for bus recovery gpios
>   i2c: davinci: switch to using gpiod for bus recovery gpios
>   i2c: remove legacy integer scl/sda gpio for recovery
> 
> Tim Sander (1):
>   i2c: designware: add i2c gpio recovery option
> 
>  drivers/i2c/busses/i2c-davinci.c            | 20 +++++--
>  drivers/i2c/busses/i2c-designware-common.c  | 19 ++++++-
>  drivers/i2c/busses/i2c-designware-core.h    |  2 +
>  drivers/i2c/busses/i2c-designware-master.c  | 57 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++-----
>  drivers/i2c/busses/i2c-imx.c                | 18 +++----
>  drivers/i2c/i2c-core-base.c                 | 83 ++++--------------
> -----------
>  include/linux/i2c.h                         | 11 ++--
>  8 files changed, 120 insertions(+), 108 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
