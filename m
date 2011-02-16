From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Feb 2011 10:41:54 +0100
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110211181921.3d561568@queued.net>
References: <20110211181921.3d561568@queued.net>
Message-ID: <20110216094154.GV13279@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 06:19:21PM -0800, Andres Salomon wrote:
> 
> The cell's platform_data is now accessed with a helper function;
> change clients to use that, and remove the now-unused data_size.
> 
> Note that mfd-core no longer makes a copy of platform_data, but the
why was this changed and where?  I'm not able to find your complete
series via gmane.

> mc13xxx-core driver creates the pdata structures on the stack.  In
> order to get around that, the various ARM mach types that set the
> pdata have been changed to hold the variable in static (global) memory.
> Also note that __initdata references in aforementioned pdata structs
> have been dropped.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  arch/arm/mach-imx/mach-mx27_3ds.c     |    6 +++++-
>  arch/arm/mach-imx/mach-pcm038.c       |    6 +++++-
>  arch/arm/mach-mx3/mach-mx31_3ds.c     |    6 +++++-
>  arch/arm/mach-mx3/mach-mx31moboard.c  |    6 +++++-
>  drivers/leds/leds-mc13783.c           |    6 +++---
>  drivers/mfd/mc13xxx-core.c            |   18 +++++-------------
>  drivers/regulator/mc13783-regulator.c |    6 ++----
>  drivers/regulator/mc13892-regulator.c |    6 ++----
>  include/linux/mfd/mc13xxx.h           |    3 +--
>  9 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index 1643315..f223371 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -227,9 +227,13 @@ static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
>  };
>  
>  /* MC13783 */
> -static struct mc13783_platform_data mc13783_pdata __initdata = {
isn't using __initdata here broken already before your patch?  Was
introduced in c67a3e09.  Fabio?

But in general I'd prefer to keep as much __initdata as possible because
this occupies less memory when using a multi-machine kernel.

> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index a1d391b..052b133 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -146,8 +146,7 @@ struct mc13xxx_platform_data {
>  #define MC13XXX_USE_LED		(1 << 5)
>  	unsigned int flags;
>  
> -	int num_regulators;
> -	struct mc13xxx_regulator_init_data *regulators;
> +	struct mc13xxx_regulator_platform_data *regulators;
>  	struct mc13xxx_leds_platform_data *leds;
>  };
... so I'd prefer to embed a struct mc13xxx_regulator_platform_data into
mc13xxx_platform_data, not a pointer to it.  This makes initialisation a
bit easier, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
