From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 Jan 2018 20:57:45 +0530
Subject: [PATCH] ARM: da8xx: use platform data for CFGCHIP syscon regmap
In-Reply-To: <1516750563-24981-1-git-send-email-david@lechnology.com>
References: <1516750563-24981-1-git-send-email-david@lechnology.com>
Message-ID: <0ca5c498-e16e-f02a-28be-51ee9abb3363@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Arnd, Kishon and Lee for their information.

On Wednesday 24 January 2018 05:06 AM, David Lechner wrote:
> This converts from using a platform device for the CFGCHIP syscon
> regmap to using platform data to pass the regmap to consumers.
> 
> A lazy getter function is used so that the regmap will only be
> created if it is actually used. This function will also be used
> in the clock init when we convert to the common clock framework.
> 
> The USB PHY driver is currently the only consumer. This driver is
> updated to use platform data to get the CFGCHIP regmap instead of
> syscon_regmap_lookup_by_pdevname().
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> This is based on the feedback from the series "ARM: davinci: common clock prep
> work?". https://lkml.org/lkml/2018/1/19/715

It will be nice to have the discussion link as part of commit description.

Links:
https://lkml.kernel.org/r/<CAK8P3a1AP1sz3nT8S6WMupo3iSVRsn2t9sPg2Mj1RAY1AS58UQ@mail.gmail.com>

Kishon,

With your ack I would like to queue this through the DaVinci tree for
v4.17. Due to ongoing common clock framework conversion effort, I expect
to queue a number of other patches dependent on this.

Once v4.16-rc1 comes out, I can provide an immutable commit/tag with
just this patch applied. You can use that if you end up queuing other
patches which conflict with this.

Let me know.

Thanks,
Sekhar

> 
>  arch/arm/mach-davinci/board-da830-evm.c     |  4 ---
>  arch/arm/mach-davinci/board-da850-evm.c     |  4 ---
>  arch/arm/mach-davinci/board-mityomapl138.c  |  4 ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  4 ---
>  arch/arm/mach-davinci/devices-da8xx.c       | 44 ++++++++++++++++-------------
>  arch/arm/mach-davinci/include/mach/da8xx.h  |  3 +-
>  arch/arm/mach-davinci/usb-da8xx.c           |  6 ++++
>  drivers/phy/ti/phy-da8xx-usb.c              |  8 ++++--
>  include/linux/platform_data/phy-da8xx-usb.h | 16 +++++++++++
>  9 files changed, 53 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/platform_data/phy-da8xx-usb.h
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 7aa1262..004f9c8 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -551,10 +551,6 @@ static __init void da830_evm_init(void)
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
>  	int ret;
>  
> -	ret = da8xx_register_cfgchip();
> -	if (ret)
> -		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
> -
>  	ret = da830_register_gpio();
>  	if (ret)
>  		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index d9d423d..3063478 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1334,10 +1334,6 @@ static __init void da850_evm_init(void)
>  {
>  	int ret;
>  
> -	ret = da8xx_register_cfgchip();
> -	if (ret)
> -		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
> -
>  	ret = da850_register_gpio();
>  	if (ret)
>  		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index f9a725a..d1c8548 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -502,10 +502,6 @@ static void __init mityomapl138_init(void)
>  {
>  	int ret;
>  
> -	ret = da8xx_register_cfgchip();
> -	if (ret)
> -		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
> -
>  	/* for now, no special EDMA channels are reserved */
>  	ret = da850_register_edma(NULL);
>  	if (ret)
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index bc8a747..e2ba9da 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -281,10 +281,6 @@ static __init void omapl138_hawk_init(void)
>  {
>  	int ret;
>  
> -	ret = da8xx_register_cfgchip();
> -	if (ret)
> -		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
> -
>  	ret = da850_register_gpio();
>  	if (ret)
>  		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index fe5e15a..4fc9888 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -1105,29 +1105,33 @@ int __init da850_register_sata(unsigned long refclkpn)
>  }
>  #endif
>  
> -static struct syscon_platform_data da8xx_cfgchip_platform_data = {
> -	.label	= "cfgchip",
> -};
> +static struct regmap *da8xx_cfgchip;
>  
> -static struct resource da8xx_cfgchip_resources[] = {
> -	{
> -		.start	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP0_REG,
> -		.end	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP4_REG + 3,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> +/* regmap doesn't make a copy of this, so we need to keep the pointer around */
> +static const char da8xx_cfgchip_name[] = "cfgchip";
>  
> -static struct platform_device da8xx_cfgchip_device = {
> -	.name	= "syscon",
> -	.id	= -1,
> -	.dev	= {
> -		.platform_data	= &da8xx_cfgchip_platform_data,
> -	},
> -	.num_resources	= ARRAY_SIZE(da8xx_cfgchip_resources),
> -	.resource	= da8xx_cfgchip_resources,
> +static const struct regmap_config da8xx_cfgchip_config __initconst = {
> +	.name		= da8xx_cfgchip_name,
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= DA8XX_CFGCHIP4_REG - DA8XX_CFGCHIP0_REG,
>  };
>  
> -int __init da8xx_register_cfgchip(void)
> +/**
> + * da8xx_get_cfgchip - Lazy gets CFGCHIP as regmap
> + *
> + * This is for use on non-DT boards only. For DT boards, use
> + * syscon_regmap_lookup_by_compatible("ti,da830-cfgchip")
> + *
> + * Returns: Pointer to the CFGCHIP regmap or negative error code.
> + */
> +struct regmap * __init da8xx_get_cfgchip(void)
>  {
> -	return platform_device_register(&da8xx_cfgchip_device);
> +	if (IS_ERR_OR_NULL(da8xx_cfgchip))
> +		da8xx_cfgchip = regmap_init_mmio(NULL,
> +					DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG),
> +					&da8xx_cfgchip_config);
> +
> +	return da8xx_cfgchip;
>  }
> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index 3481a0d..9fd6d01 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -18,6 +18,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/platform_data/davinci_asp.h>
>  #include <linux/reboot.h>
> +#include <linux/regmap.h>
>  #include <linux/videodev2.h>
>  
>  #include <mach/serial.h>
> @@ -125,7 +126,7 @@ void da8xx_rproc_reserve_cma(void);
>  int da8xx_register_rproc(void);
>  int da850_register_gpio(void);
>  int da830_register_gpio(void);
> -int da8xx_register_cfgchip(void);
> +struct regmap *da8xx_get_cfgchip(void);
>  
>  extern struct platform_device da8xx_serial_device[];
>  extern struct emac_platform_data da8xx_emac_pdata;
> diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
> index fb31f6e..4d89d86 100644
> --- a/arch/arm/mach-davinci/usb-da8xx.c
> +++ b/arch/arm/mach-davinci/usb-da8xx.c
> @@ -8,6 +8,7 @@
>  #include <linux/init.h>
>  #include <linux/mfd/da8xx-cfgchip.h>
>  #include <linux/phy/phy.h>
> +#include <linux/platform_data/phy-da8xx-usb.h>
>  #include <linux/platform_data/usb-davinci.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/musb.h>
> @@ -40,6 +41,11 @@ static struct platform_device da8xx_usb_phy = {
>  
>  int __init da8xx_register_usb_phy(void)
>  {
> +	struct da8xx_usb_phy_platform_data pdata;
> +
> +	pdata.cfgchip = da8xx_get_cfgchip();
> +	da8xx_usb_phy.dev.platform_data = &pdata;
> +
>  	return platform_device_register(&da8xx_usb_phy);
>  }
>  
> diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
> index 5bd33d0..befb886 100644
> --- a/drivers/phy/ti/phy-da8xx-usb.c
> +++ b/drivers/phy/ti/phy-da8xx-usb.c
> @@ -20,6 +20,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
> +#include <linux/platform_data/phy-da8xx-usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> @@ -145,6 +146,7 @@ static struct phy *da8xx_usb_phy_of_xlate(struct device *dev,
>  static int da8xx_usb_phy_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
> +	struct da8xx_usb_phy_platform_data *pdata = dev->platform_data;
>  	struct device_node	*node = dev->of_node;
>  	struct da8xx_usb_phy	*d_phy;
>  
> @@ -152,11 +154,11 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
>  	if (!d_phy)
>  		return -ENOMEM;
>  
> -	if (node)
> +	if (pdata)
> +		d_phy->regmap = pdata->cfgchip;
> +	else
>  		d_phy->regmap = syscon_regmap_lookup_by_compatible(
>  							"ti,da830-cfgchip");
> -	else
> -		d_phy->regmap = syscon_regmap_lookup_by_pdevname("syscon");
>  	if (IS_ERR(d_phy->regmap)) {
>  		dev_err(dev, "Failed to get syscon\n");
>  		return PTR_ERR(d_phy->regmap);
> diff --git a/include/linux/platform_data/phy-da8xx-usb.h b/include/linux/platform_data/phy-da8xx-usb.h
> new file mode 100644
> index 0000000..be35d9b
> --- /dev/null
> +++ b/include/linux/platform_data/phy-da8xx-usb.h
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-da8xx-usb - TI DaVinci DA8xx USB PHY driver
> + *
> + * Copyright (C) 2018 David Lechner <david@lechnology.com>
> + */
> +
> +#include <linux/regmap.h>
> +
> +/**
> + * da8xx_usb_phy_platform_data
> + * @cfgchip: CFGCHIP syscon regmap
> + */
> +struct da8xx_usb_phy_platform_data {
> +	struct regmap *cfgchip;
> +};
> -- 
> 2.7.4
> 
