From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 14:49:26 +0300
Subject: [PATCH v1 2/9] da850: pruss board specific additions.
In-Reply-To: <1296571667-12049-3-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-3-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D4944C6.5060406@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds board specific initializations and setup routines.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 11f986b..7938c6d 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1053,6 +1053,29 @@ static __init int da850_evm_init_cpufreq(void)
>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>   #endif
>
> +static struct da8xx_pruss_devices pruss_devices[] = {
> +	{.dev_name = NULL,},
> +};
> +
> +static int __init da8xx_evm_setup_pruss(void)

    Only da850_evm_setup_pruss() -- we're in the DA850 EVM support file.

> +{
> +	u32 ret = 0;
> +	u32 count;
> +
> +	for (count = 0; count < ARRAY_SIZE(pruss_devices); count++) {
> +		if (pruss_devices[count].setup != NULL) {
> +			ret = pruss_devices[count].setup();
> +			if (ret) {
> +				pr_warning("%s: %s init failed: %d\n", __func__,
> +					pruss_devices[count].dev_name, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return da8xx_register_pruss(pruss_devices);
> +}
> +
>   static __init void da850_evm_init(void)
>   {
>   	int ret;
> @@ -1127,6 +1150,11 @@ static __init void da850_evm_init(void)
>
>   	da8xx_register_mcasp(0,&da850_evm_snd_data);
>
> +	ret = da8xx_evm_setup_pruss();
> +	if (ret)
> +		pr_warning("%s: pruss initialization failed: %d\n",
> +				__func__, ret);

    Does it really make sense to print 2 messages for one error?

WBR, Sergei
