From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 26 Jan 2013 18:42:49 +0400
Subject: [PATCH v6 2/2] ARM: davinci: Remoteproc platform device creation
 data/code
In-Reply-To: <1359168322-17733-3-git-send-email-rtivy@ti.com>
References: <1359168322-17733-1-git-send-email-rtivy@ti.com>
 <1359168322-17733-3-git-send-email-rtivy@ti.com>
Message-ID: <5103EB69.5070101@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-01-2013 6:45, Robert Tivy wrote:

> Added a new remoteproc platform device for DA8XX.  Contains CMA-based
> reservation of physical memory block.  A new kernel command-line
> parameter has been added to allow boot-time specification of the
> physical memory block.

    No signoff again.

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index fb2f51b..a455e5c 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
[...]
> @@ -706,6 +706,96 @@ int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
>   }
>   #endif
>
> +static struct resource da8xx_rproc_resources[] = {
> +	{ /* DSP boot address */
> +		.start		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG,
> +		.end		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG + 3,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{ /* DSP interrupt registers */
> +		.start		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG,
> +		.end		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG + 7,
> +		.flags		= IORESOURCE_MEM,

    Does it really make sense to pass these as 2 resources -- they have the 
same base address?

> +int __init da8xx_register_rproc(void)
> +{
> +	int ret;
> +
> +	ret = platform_device_register(&da8xx_dsp);
> +	if (ret) {
> +		pr_err("%s: platform_device_register: %d\n", __func__, ret);

    Better message would be "can't register DSP device".

> +

    Empty line hardly needed here.

> +		return ret;

    Not needed here, just move it outside the {} to replace 'return 0'.

> +	}
> +
> +	return 0;
> +};
> +

WBR, Sergei
