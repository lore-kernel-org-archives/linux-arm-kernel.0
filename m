From: jayakumar.sc@gmail.com (Jaya Kumar)
Date: Thu, 4 Aug 2011 16:40:01 +0800
Subject: [PATCH v4] ARM: davinci: AM18x: Add wl1271/wlan support
In-Reply-To: <1312444283-25581-1-git-send-email-ido@wizery.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DF05D8E@dbde02.ent.ti.com>
	<1312444283-25581-1-git-send-email-ido@wizery.com>
Message-ID: <CADqH6Vz3gn6dwLHtfZkzLxkHfHqRV3e+C_w_hfYO2-PK_TU4eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2011 at 3:51 PM, Ido Yariv <ido@wizery.com> wrote:
> +static __init int da850_wl12xx_init(void)
> +{
> + ? ? ? int ret;
> +
> + ? ? ? ret = davinci_cfg_reg_list(da850_wl12xx_pins);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("wl12xx/mmc mux setup failed: %d\n", ret);
> + ? ? ? ? ? ? ? goto exit;
> + ? ? ? }
> +
> + ? ? ? ret = da850_register_mmcsd1(&da850_wl12xx_mmc_config);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("wl12xx/mmc registration failed: %d\n", ret);
> + ? ? ? ? ? ? ? goto exit;
> + ? ? ? }
> +
> + ? ? ? ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW, "wl12xx_en");
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("Could not request wl12xx enable gpio: %d\n", ret);
> + ? ? ? ? ? ? ? goto exit;
> + ? ? ? }
> +
> + ? ? ? ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("Could not request wl12xx irq gpio: %d\n", ret);
> + ? ? ? ? ? ? ? goto free_wlan_en;
> + ? ? ? }
> +
> + ? ? ? da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> +
> + ? ? ? ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? pr_err("Could not set wl12xx data: %d\n", ret);
> + ? ? ? ? ? ? ? goto free_wlan_irq;
> + ? ? ? }
> +
> + ? ? ? return 0;

Hi Ido,

A quick question for my own understanding. What's the mechanism by
which wl12xx is bound with above. I see above wl12xx_set_platform_data
but I didn't see something like .name = "wl1271" or dev_name that
comes in through platform_device_register. If I look at other board
files, I see:

321 #ifdef CONFIG_WL12XX_PLATFORM_DATA
322         {
323                 .name           = "wl1271",
324                 .mmc            = 2,
325                 .caps           = MMC_CAP_4_BIT_DATA |
MMC_CAP_POWER_OFF_CARD,
326                 .gpio_wp        = -EINVAL,
327                 .gpio_cd        = -EINVAL,
328                 .nonremovable   = true,
329         },
330 #endif

and

729 #ifdef CONFIG_WL12XX_PLATFORM_DATA
730         /* WL12xx WLAN Init */
731         if (wl12xx_set_platform_data(&omap3evm_wlan_data))
732                 pr_err("error setting wl12xx data\n");
733         platform_device_register(&omap3evm_wlan_regulator);
734 #endif

Thanks,
jayakumar
