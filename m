From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 14:02:14 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419204028.GU10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <517173C0.6010902@ti.com>
 <20130419194323.GP10155@atomide.com>
 <201304192211.13356.arnd@arndb.de>
 <20130419204028.GU10155@atomide.com>
Message-ID: <20130419210213.GW10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130419 13:47]:
> * Arnd Bergmann <arnd@arndb.de> [130419 13:18]:
>  
> > I think all the bugs that Rob reported can be fixed individually.
> > 
> > Note that the "dss-common.c" part there might be a Red Herring, the symbols
> > are likely to be used from somewhere else than that file.
> 
> Yeah. Here's an initial patch of what I had in mind, seems to
> do the trick. Will spend a little more time looking at it.
...

> --- a/arch/arm/plat-omap/include/plat/i2c.h
> +++ b/arch/arm/plat-omap/include/plat/i2c.h
> @@ -25,8 +25,17 @@
>  struct i2c_board_info;
>  struct omap_i2c_bus_platform_data;
>  
> +#if defined(CONFIG_ARCH_OMAP1) || defined(SOC_OMAP)

This should have defined(CONFIG_SOC_OMAP) instead. Will repost
after some more randconfig builds.

>  int omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
>  			int bus_id);
> +#else
> +static inline int
> +omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
> +			int bus_id)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  
>  #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
>  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,

Regards,

Tony
