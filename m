From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Nov 2016 16:43:14 +0100
Subject: [PATCH v6 2/4] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161130140017.26307-3-romain.perier@free-electrons.com> (Romain
 Perier's message of "Wed, 30 Nov 2016 15:00:15 +0100")
References: <20161130140017.26307-1-romain.perier@free-electrons.com>
 <20161130140017.26307-3-romain.perier@free-electrons.com>
Message-ID: <87wpflkm7h.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On mer., nov. 30 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
>
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

As the code had changed I tested it agin and it continues to work, so
you can keep my Tested-by.

However I have a small remark, see below:

> ---
>
> Changes in v6:
>  - Revert back A3700_REGS, as asked by Wolfram and define fm_mask
>    and hs_mask in the register layout. I moved the generic code
>    for fm_mask and hs_mask to a seperated commit (1/4)
>
> Changes in v5:
>  - Don't define registers for armada-3700, we can re-use the ones
>    for PXA3XX.
>  - Define registers mask when OF is not used, in probe_pdata. 
>
> Changes in v4:
>  - Replaced the type of hs_mask and fm_mask by u32, instead of
>    unsigned int, As writel() take an u32 as first argument...
>
> Changes in v3:
>  - Replaced the type of hs_mask and fm_mask by unsigned int,
>    instead of unsigned long.
>
>  drivers/i2c/busses/Kconfig   |  2 +-
>  drivers/i2c/busses/i2c-pxa.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..2f56a26 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -763,7 +763,7 @@ config I2C_PUV3
>  
>  config I2C_PXA
>  	tristate "Intel PXA2XX I2C adapter"
> -	depends on ARCH_PXA || ARCH_MMP || (X86_32 && PCI && OF)
> +	depends on ARCH_PXA || ARCH_MMP || ARCH_MVEBU || (X86_32 && PCI && OF)
>  	help
>  	  If you have devices in the PXA I2C bus, say yes to this option.
>  	  This driver can also be built as a module.  If so, the module

Maybe you could add that this driver is no longer only for the PXA
family but also for the Armada 37xx.

Gregory

> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index dc9d0a6..0ded4bc 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -57,8 +57,12 @@ enum pxa_i2c_types {
>  	REGS_PXA3XX,
>  	REGS_CE4100,
>  	REGS_PXA910,
> +	REGS_A3700,
>  };
>  
> +#define ICR_BUSMODE_FM	(1 << 16)	   /* shifted fast mode for armada-3700 */
> +#define ICR_BUSMODE_HS	(1 << 17)	   /* shifted high speed mode for armada-3700 */
> +
>  /*
>   * I2C registers definitions
>   */
> @@ -93,6 +97,15 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
>  		.ilcr = 0x28,
>  		.iwcr = 0x30,
>  	},
> +	[REGS_A3700] = {
> +		.ibmr =	0x00,
> +		.idbr =	0x04,
> +		.icr =	0x08,
> +		.isr =	0x0c,
> +		.isar =	0x10,
> +		.fm = ICR_BUSMODE_FM,
> +		.hs = ICR_BUSMODE_HS,
> +	},
>  };
>  
>  static const struct platform_device_id i2c_pxa_id_table[] = {
> @@ -100,6 +113,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
>  	{ "pxa910-i2c",		REGS_PXA910 },
> +	{ "armada-3700-i2c",	REGS_A3700  },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
> @@ -1141,6 +1155,7 @@ static const struct of_device_id i2c_pxa_dt_ids[] = {
>  	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
>  	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
>  	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
> +	{ .compatible = "marvell,armada-3700-i2c", .data = (void *)REGS_A3700 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
