From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 7 Nov 2018 10:02:05 +0100
Subject: [PATCH v2] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
In-Reply-To: <20181107085639.32366-1-natechancellor@gmail.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <20181107085639.32366-1-natechancellor@gmail.com>
Message-ID: <79a33561-6980-2fa4-182a-c2def95d49cb@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07. 11. 18 9:56, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>         ~               ^~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
> 
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Avoid kernel-doc warning
> 
>  drivers/pinctrl/pinctrl-zynq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> index a0daf27042bd..90fd37e8207b 100644
> --- a/drivers/pinctrl/pinctrl-zynq.c
> +++ b/drivers/pinctrl/pinctrl-zynq.c
> @@ -971,15 +971,12 @@ enum zynq_io_standards {
>  	zynq_iostd_max
>  };
>  
> -/**
> - * enum zynq_pin_config_param - possible pin configuration parameters
> - * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
> +/*
> + * PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
>   *	this parameter (on a custom format) tells the driver which alternative
>   *	IO standard to use.
>   */
> -enum zynq_pin_config_param {
> -	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
> -};
> +#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
>  
>  static const struct pinconf_generic_params zynq_dt_params[] = {
>  	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
