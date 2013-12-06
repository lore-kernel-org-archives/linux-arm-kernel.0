From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Dec 2013 14:22:00 -0800
Subject: [PATCH v2 2/3] pinctrl: Add msm8x74 configuration
In-Reply-To: <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <52A24E08.706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/13 18:10, Bjorn Andersson wrote:
> Add initial definition of parameters for pinctrl-msm for the msm8x74
> platform.

Hmm. We've tried to remove 'x' from our code because it isn't really
accurate and leads to more confusion. For example, 8660 and 8960 are
vastly different with respect to SoC architecture and it was a mistake
to name it 8x60 in the code. We should have stuck with 8660 and 8260 to
avoid any confusion with 8960 but we didn't know that 8960 was going to
be made at the time. While it seems convenient to just throw in the x,
who knows what marketing will do later on and it could break the whole
scheme.

>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index d0b6846..31c6c4a 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -208,6 +208,10 @@ config PINCTRL_MSM
>  	select PINCONF
>  	select GENERIC_PINCONF
>  
> +config PINCTRL_MSM8X74
> +	bool "Qualcomm 8x74 pin controller driver"
> +	select PINCTRL_MSM

No help?

> +
>  config PINCTRL_NOMADIK
>  	bool "Nomadik pin controller driver"
>  	depends on ARCH_U8500 || ARCH_NOMADIK
> diff --git a/drivers/pinctrl/pinctrl-msm8x74.c b/drivers/pinctrl/pinctrl-msm8x74.c
> new file mode 100644
> index 0000000..762552b
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-msm8x74.c
> @@ -0,0 +1,636 @@
[snip]
> +
> +#define FUNCTION(fname)					\
> +	[MSM_MUX_##fname] = {				\
> +		.name = #fname,				\
> +		.groups = fname##_groups,		\
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7)	\
> +	{						\
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = ARRAY_SIZE(gpio##id##_pins),	\
> +		.funcs = {				\
> +			MSM_MUX_NA, /* gpio mode */	\
> +			MSM_MUX_##f1,			\
> +			MSM_MUX_##f2,			\
> +			MSM_MUX_##f3,			\
> +			MSM_MUX_##f4,			\
> +			MSM_MUX_##f5,			\
> +			MSM_MUX_##f6,			\
> +			MSM_MUX_##f7			\
> +		},					\
> +		.ctl_reg = 0x1000 + 0x10 * id ,		\

Weird trailing space here.

Also, do we ever plan to have anything more than the gpio pins and the
sdc pins? It seems like we spend a lot of space describing exactly the
same thing in these structs for each of the 146 gpio pins when we could
just know that range 0 to 146 is gpio pins and have different code for
that part vs the 6 or something sd pins.

> +
> +static struct of_device_id msm8x74_pinctrl_of_match[] = {

const?

>
> +
> +static int __init msm8x74_pinctrl_init(void)
> +{
> +	return platform_driver_register(&msm8x74_pinctrl_driver);
> +}
> +arch_initcall(msm8x74_pinctrl_init);
> +
> +static void __exit msm8x74_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&msm8x74_pinctrl_driver);
> +}
> +module_exit(msm8x74_pinctrl_exit);

Why not module_platform_driver()? I thought pinctrl supported deferred
probing?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
