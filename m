From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Feb 2011 21:55:10 +0300
Subject: [PATCH v2 12/13] da850: pruss SUART platform specific additions.
In-Reply-To: <1297435892-28278-13-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-13-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D55860E.3090908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subhasish Ghosh wrote:

> This patch adds the McASP clock alias.
> The alias is used by the pruss suart driver
> for enabling the McASP PSC.

> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index e15de72..f1cf605 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -560,7 +560,18 @@ struct platform_device da8xx_pruss_dev = {
>  
>  int __init da8xx_register_pruss(struct da8xx_pruss_devices *pruss_device)
>  {
> +#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE

    #ifdef's in the function body are generally fromned upon.

> +	int ret;
> +#endif
> +

    This line should have been inside #ifdef...

>  	da8xx_pruss_dev.dev.platform_data = pruss_device;
> +
> +#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE

    Why not do it before assigning the platform data and avoid extra #ifdef?

> +	ret = clk_add_alias(NULL, "da8xx_pruss_uart.1",
> +	NULL, &da850_mcasp_device.dev);

    This line should be indented more to the right.

> +	if (ret < 0)
> +		return ret;
> +#endif

WBR, Sergei
