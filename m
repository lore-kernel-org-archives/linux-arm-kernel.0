From: ido@wizery.com (Ido Yariv)
Date: Thu, 4 Aug 2011 12:22:33 +0300
Subject: [PATCH v4] ARM: davinci: AM18x: Add wl1271/wlan support
In-Reply-To: <CADqH6Vz3gn6dwLHtfZkzLxkHfHqRV3e+C_w_hfYO2-PK_TU4eA@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DF05D8E@dbde02.ent.ti.com>
	<1312444283-25581-1-git-send-email-ido@wizery.com>
	<CADqH6Vz3gn6dwLHtfZkzLxkHfHqRV3e+C_w_hfYO2-PK_TU4eA@mail.gmail.com>
Message-ID: <20110804092233.GS1985@WorkStation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaya,

On Thu, Aug 04, 2011 at 04:40:01PM +0800, Jaya Kumar wrote:
> Hi Ido,
> 
> A quick question for my own understanding. What's the mechanism by
> which wl12xx is bound with above. I see above wl12xx_set_platform_data
> but I didn't see something like .name = "wl1271" or dev_name that
> comes in through platform_device_register.

The wl12xx module calls wl12xx_get_platform_data, which simply returns
the structure set by wl12xx_set_platform_data. This mechanism only
supports a single platform data.

> If I look at other board files, I see:
> 
> 321 #ifdef CONFIG_WL12XX_PLATFORM_DATA
> 322         {
> 323                 .name           = "wl1271",
> 324                 .mmc            = 2,
> 325                 .caps           = MMC_CAP_4_BIT_DATA |
> MMC_CAP_POWER_OFF_CARD,
> 326                 .gpio_wp        = -EINVAL,
> 327                 .gpio_cd        = -EINVAL,
> 328                 .nonremovable   = true,
> 329         },
> 330 #endif

'name' is just a descriptive name of omap2_hsmmc_info. davinci_mmc_config
doesn't have such a member.

> 729 #ifdef CONFIG_WL12XX_PLATFORM_DATA
> 730         /* WL12xx WLAN Init */
> 731         if (wl12xx_set_platform_data(&omap3evm_wlan_data))
> 732                 pr_err("error setting wl12xx data\n");
> 733         platform_device_register(&omap3evm_wlan_regulator);
> 734 #endif

Please note that the platform_device_register above is used for
registering a regulator device, which is driven by the fixed regulator
driver and not by wl12xx. This regulator is controlled by omap's mmc
host driver.

Hope this clarifies things,
Ido.
