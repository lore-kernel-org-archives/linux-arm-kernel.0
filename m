From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 15:01:34 +0300
Subject: [PATCH v1 5/9] da850: pruss CAN board specific additions.
In-Reply-To: <1296571667-12049-6-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-6-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D49479E.3010008@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds the pruss CAN pin mux and registers the device
> with the pruss mfd driver.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 7938c6d..285545f 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1053,8 +1053,46 @@ static __init int da850_evm_init_cpufreq(void)
>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>   #endif
>
> +const short da850_pruss_can_pins[] = {

    Only da850_evm_pruss_can_pins[].

> +	DA850_PRUSS_PRU0_R31_0, DA850_PRUSS_PRU1_R30_15,
> +	DA850_PRUSS_PRU1_R31_18,
> +	-1
> +};
> +
> +static int __init da850_evm_setup_pruss_can(void)
> +{
> +	int ret, val = 0;
> +	void __iomem *cfg_chip3_base;

    CFGCHIP3 is a signle register, so it doesn't make sense to talk about its 
base...

> +	if (!machine_is_davinci_da850_evm())
> +		return 0;

    This check doesn't make sense as this function is not declared as 
*_initcall(). It will only be called on this machine anyway.

> +	ret = davinci_cfg_reg_list(da850_pruss_can_pins);
> +	if (ret)
> +		pr_warning("%s: da850_pruss_can_pins mux setup "
> +					"failed:%d\n", __func__, ret);
> +	cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
> +	val = __raw_readl(cfg_chip3_base);
> +	val |= BIT(3);
> +	__raw_writel(val, cfg_chip3_base);
> +
> +	return ret;
> +}
> +
> +static struct da8xx_pruss_can_data can_data = {
> +	.version	= 1,
> +};
> +
>   static struct da8xx_pruss_devices pruss_devices[] = {
> -	{.dev_name = NULL,},
> +	{
> +		.dev_name	= "da8xx_pruss_can",
> +		.pdata		= &can_data,
> +		.pdata_size	= sizeof(can_data),
> +		.setup		= da850_evm_setup_pruss_can,
> +	},
> +	{
> +		.dev_name	= NULL,
> +	},

    Why you need a dummy lst element in this array?

WBR, Sergei
