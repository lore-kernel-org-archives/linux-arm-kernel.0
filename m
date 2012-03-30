From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 30 Mar 2012 15:24:37 +0300
Subject: [PATCH v3] ARM: pxa: fix build failure for regulator consumer
 in em-x270.c
In-Reply-To: <1333043034-3374-1-git-send-email-paul.gortmaker@windriver.com>
References: <20120329151157.GT3668@opensource.wolfsonmicro.com>
 <1333043034-3374-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4F75A605.8040601@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/12 19:43, Paul Gortmaker wrote:
> Commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0
> 
>   "regulator: Remove support for supplies specified by struct device"
> 
> caused this file to break, since it was still relying on the
> device field to be present.  Map it onto dev_name appropriately
> 
> Since there are two consumers with the name "reg-userspace-consumer",
> we have to supply the ID as a suffix in the REGULATOR_CONSUMER calls.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> [v3: add .0/.1 ID suffix to "reg-userspace-consumer" instances ]
> 
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index c1b65da..16ec557 100644
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
> +REGULATOR_CONSUMER(ldo3, "reg-userspace-consumer.0", "vcc gps");
>  REGULATOR_CONSUMER(ldo5, NULL, "vcc cam");
> -REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
> +REGULATOR_CONSUMER(ldo10, "pxa2xx-mci", "vcc sdio");
>  REGULATOR_CONSUMER(ldo12, NULL, "vcc usb");
> -REGULATOR_CONSUMER(ldo19, &em_x270_gprs_userspace_consumer.dev, "vcc gprs");
> +REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer.1", "vcc gprs");
>  REGULATOR_CONSUMER(buck2, NULL, "vcc_core");
>  
>  #define REGULATOR_INIT(_ldo, _min_uV, _max_uV, _ops_mask)		\

Better late then never...
Tested and works as expected.
Thanks for the patch.


-- 
Regards,
Igor.
