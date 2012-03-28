From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 28 Mar 2012 17:21:59 +0200
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4F732C97.2030804@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I've finally found one of em-x270 to test on...

On 03/09/12 00:06, Paul Gortmaker wrote:
> Commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)
> 
>   "regulator: Remove support for supplies specified by struct device"
> 
> caused this file to break, since it was still relying on the
> device field to be present.  Update them to use the new dev_name
> entries instead.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> [v2: replace dev with dev_name instead of just deleting dev.
>  Note however there is dev_name overlap; not sure if that matters? ]
> 
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index c1b65da..0ffc100 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -1083,19 +1083,19 @@ static void __init em_x270_userspace_consumers_init(void)
>  }
>  
>  /* DA9030 related initializations */
> -#define REGULATOR_CONSUMER(_name, _dev, _supply)			       \
> +#define REGULATOR_CONSUMER(_name, _dev_name, _supply)		        \
>  	static struct regulator_consumer_supply _name##_consumers[] = {	\
>  		{							\
> -			.dev = _dev,					\
> +			.dev_name = _dev_name,				\
>  			.supply = _supply,				\
>  		},							\
>  	}
>  
> -REGULATOR_CONSUMER(ldo3, &em_x270_gps_userspace_consumer.dev, "vcc gps");
> +REGULATOR_CONSUMER(ldo3, "reg-userspace-consumer", "vcc gps");

If you make this:
REGULATOR_CONSUMER(ldo3, NULL, "vcc gps");

>  REGULATOR_CONSUMER(ldo5, NULL, "vcc cam");
> -REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
> +REGULATOR_CONSUMER(ldo10, "pxa2xx-mci", "vcc sdio");
>  REGULATOR_CONSUMER(ldo12, NULL, "vcc usb");
> -REGULATOR_CONSUMER(ldo19, &em_x270_gprs_userspace_consumer.dev, "vcc gprs");
> +REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer", "vcc gprs");

and this:
REGULATOR_CONSUMER(ldo19, NULL, "vcc gprs");

the device even boots...

>  REGULATOR_CONSUMER(buck2, NULL, "vcc_core");
>  
>  #define REGULATOR_INIT(_ldo, _min_uV, _max_uV, _ops_mask)		\


Thanks for the patch, with the changes above:
Tested-by: Igor Grinberg <grinberg@compulab.co.il>

Haojian, can this patch be included in your pull request (or another one)?
It fixes the build for em_x270_defconfig and with the updates above
gets the board to boot.

Thanks.

-- 
Regards,
Igor.
