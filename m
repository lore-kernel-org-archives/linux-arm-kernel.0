From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Jul 2011 03:59:20 -0700
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
In-Reply-To: <20110715083103.GF2611@legolas.emea.dhcp.ti.com>
References: <1310554738.18446.12.camel@lws-weitzel>
	<1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
	<4E1D8BCD.5060901@ru.mvista.com>
	<1310561772.18446.14.camel@lws-weitzel>
	<20110714073445.GL5783@atomide.com>
	<1310632792.4008.3.camel@lws-weitzel>
	<20110715075024.GO5783@atomide.com>
	<20110715075825.GB2611@legolas.emea.dhcp.ti.com>
	<20110715082012.GR5783@atomide.com>
	<20110715083103.GF2611@legolas.emea.dhcp.ti.com>
Message-ID: <20110715105920.GU5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110715 01:25]:
> 
> possibly something like this (still missing MACHINE_START a few more
> things):

Yes and it would be better to initialize data in the .init_machine
to avoid adding machine_is tests in multiple places.
 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 0cfe200..dff174c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -681,20 +681,44 @@ void omap4_panda_display_init(void)
>         omap_display_init(&omap4_panda_dss_data);
>  }
>  
> +static struct omap_smsc911x_platform_data board_smsc911x_data __initdata = {
> +       .cs             = OMAP4_SMSC911X_ETH_CS,
> +       .gpio_irq       = OMAP4_SMSC911X_ETH_GPIO_IRQ,
> +       .gpio_reset     = -EINVAL,
> +       .flags          = SMSC911X_USE_16BIT,
> +};
> +
> +static void __init omap4_panda_smsc91xx_init(void)
> +{
> +       if (!machine_is_pcm049())
> +               return;
> +
> +       omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
> +       gpmc_smsc911x_init(&board_smsc911x_data);
> +}
> +
>  static void __init omap4_panda_init(void)
>  {
>         int package = OMAP_PACKAGE_CBS;
>  
>         if (omap_rev() == OMAP4430_REV_ES1_0)
>                 package = OMAP_PACKAGE_CBL;
> +
>         omap4_mux_init(board_mux, NULL, package);
>  
> -       if (wl12xx_set_platform_data(&omap_panda_wlan_data))
> -               pr_err("error setting wl12xx data\n");
> +       if (machine_is_omap4panda()) {
> +               int             ret;
> +
> +               ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
> +               if (ret)
> +                       pr_err("error setting wl12xx data\n");
> +
> +               platform_device_register(&omap_vwlan_device);
> +       }
>  
> +       omap4_panda_smsc91xx_init();
>         omap4_panda_i2c_init();
>         platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
> -       platform_device_register(&omap_vwlan_device);
>         board_serial_init();
>         omap4_twl6030_hsmmc_init(mmc);

So we sould have panda_common_init() and then omap4_panda_init()
and omap4_phycore_init() or something like that. No need for machine_is
tests then as the .machine_init already takes care of that test.

Regards,

Tony
