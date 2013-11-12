From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 10:31:58 -0500
Subject: Fwd: [PATCH 1/8] watchdog: davinci: change driver to use WDT core
In-Reply-To: <527A287C.2090401@ti.com>
References: <1383680783-12114-2-git-send-email-ivan.khoronzhuk@ti.com>
 <527A287C.2090401@ti.com>
Message-ID: <528249EE.6080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 November 2013 06:31 AM, ivan.khoronzhuk wrote:
> To reduce code duplicate and increase code readability use WDT core
> code to handle WDT interface.
> 
> Remove io_lock as the WDT core uses mutex to lock each wdt device.
> Remove wdt_state as the WDT core track state with its own variable.
> 
> The watchdog_init_timeout() can read timeout value from timeout-sec
> property if the passed value is out of bounds. So set initial
> heartbeat value more than max value in order to initialize heartbeat
> in next way. If heartbeat is not set thought module parameter, try
> to read it's value from WDT node timeout-sec property. If node has
> no one, use default value.
> 
> The heartbeat is hold in wdd->timeout by WDT core, so use it in
> order to set timeout period.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  drivers/watchdog/Kconfig       |    1 +
>  drivers/watchdog/davinci_wdt.c |  150 ++++++++++------------------------------
>  2 files changed, 38 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index d1d53f3..2c954b5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -271,6 +271,7 @@ config IOP_WATCHDOG
>  config DAVINCI_WATCHDOG
>  	tristate "DaVinci watchdog"
>  	depends on ARCH_DAVINCI
> +	select WATCHDOG_CORE
>  	help
>  	  Say Y here if to include support for the watchdog timer
>  	  in the DaVinci DM644x/DM646x processors.
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index bead774..a6eef71 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -3,7 +3,7 @@
>   *
>   * Watchdog driver for DaVinci DM644x/DM646x processors
>   *
> - * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2013 Texas Instruments.
s/2013/2006-2013

Apart from the minor nit, this is really nice clean-up and
more aligned with wdt coer leayer.

FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
