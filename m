From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 09:32:16 -0800
Subject: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
In-Reply-To: <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
 <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111222173216.GJ24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> @@ -548,6 +588,19 @@ void omap4_panda_display_init(void)
>  	omap_display_init(&omap4_panda_dss_data);
>  }
>  
> +static void omap4_panda_audio_init(void)
> +{
> +	if (cpu_is_omap4430()) {
> +		/* PandaBoard 4430 */
> +		panda_abe_audio_data.card_name = "PandaBoard";
> +		/* Audio in is connected to HSMIC */
> +		panda_abe_audio_data.has_hsmic = 1;
> +	} else {
> +		/* PandaBoard ES */
> +		panda_abe_audio_data.card_name = "PandaBoardES";
> +	}
> +}
> +

Please move the cpu_is_omap4430() check from audio_init to..

>  static void __init omap4_panda_init(void)
>  {
>  	int package = OMAP_PACKAGE_CBS;
> @@ -560,6 +613,7 @@ static void __init omap4_panda_init(void)
>  		pr_err("error setting wl12xx data\n");
>  
>  	omap4_panda_i2c_init();
> +	omap4_panda_audio_init();
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>  	platform_device_register(&omap_vwlan_device);
>  	board_serial_init();

..omap4_panda_init() instead and set some flag that other
devices can use too so we don't have cpu_is_omap tests
for each init function. I'd assume that will be needed for
other devices too, but that's just a guess of course :)

Tony
