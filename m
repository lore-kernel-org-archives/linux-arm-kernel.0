From: khilman@ti.com (Kevin Hilman)
Date: Wed, 08 Aug 2012 11:11:25 -0700
Subject: [PATCH 11/11] pm/drivers: fix use of SIMPLE_DEV_PM_OPS
In-Reply-To: <1344437248-20560-12-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 8 Aug 2012 16:47:28 +0200")
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-12-git-send-email-arnd@arndb.de>
Message-ID: <87obmluucy.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> A few drivers use a construct like
>
>  #ifdef CONFIG_PM
>  static int foo_suspend(struct device *pdev)
>  {
>     ...
>  }
>  static int foo_resume struct device *pdev)
>  {
>     ...
>  }
>  #endif
>  static SIMPLE_DEV_PM_OPS(foo_pm, foo_suspend, foo_resume);
>
> which leaves the two functions unused if CONFIG_PM is enabled
> but CONFIG_PM_SLEEP is disabled. I found this while building
> all defconfig files on ARM. It's not clear to me if this is
> the right solution, but at least it makes the code consistent
> again.
>
> Without this patch, building omap1_defconfig results in:
>
> drivers/char/hw_random/omap-rng.c:165:12: warning: 'omap_rng_suspend' defined but not used [-Wunused-function]
> drivers/char/hw_random/omap-rng.c:171:12: warning: 'omap_rng_resume' defined but not used [-Wunused-function]
> sound/drivers/dummy.c:1068:12: warning: 'snd_dummy_suspend' defined but not used [-Wunused-function]
> sound/drivers/dummy.c:1078:12: warning: 'snd_dummy_resume' defined but not used [-Wunused-function]
>
> and building tegra_defconfig results in:
>
> drivers/i2c/busses/i2c-tegra.c:716:12: warning: 'tegra_i2c_suspend' defined but not used [-Wunused-function]
> drivers/i2c/busses/i2c-tegra.c:727:12: warning: 'tegra_i2c_resume' defined but not used [-Wunused-function]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/char/hw_random/omap-rng.c |    2 +-

For the OMAP change,

Acked-by: Kevin Hilman <khilman@ti.com>
