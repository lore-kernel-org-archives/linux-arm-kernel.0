From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 18:01:53 +0200
Subject: [PATCH 2/2] drm/panel: make DRM_PANEL_LD9040 depend on SPI
In-Reply-To: <E1Wv7Ge-0004SN-Sk@rmk-PC.arm.linux.org.uk>
References: <E1Wv7Ge-0004SN-Sk@rmk-PC.arm.linux.org.uk>
Message-ID: <4631432.m2S6KTlMps@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 16:50:20 Russell King wrote:
> Rather than DRM_PANEL_LD9040 selecting SPI, which then results in an
> increase in the probability of Kconf reporting circular dependencies
> (we're one "select" away from that right now), make this depend on
> SPI instead.  This is akin to having some driver select DRM.
> 
> Having some drivers depend on a subsystem, and other drivers select a
> subsystem is a recipe for circular dependencies, and there's really no
> need for it.
> 
> The potential circular dependency (which can be caused today by the
> addition of selecting DRM_PANEL from DRM_IMX_LDB) is:
> 
>   symbol DMADEVICES is selected by SAMSUNG_DMADEV
>   symbol SAMSUNG_DMADEV is selected by S3C64XX_PL080
>   symbol S3C64XX_PL080 is selected by SPI_S3C64XX
>   symbol SPI_S3C64XX depends on SPI
>   symbol SPI is selected by DRM_PANEL_LD9040
>   symbol DRM_PANEL_LD9040 depends on DRM_PANEL
>   symbol DRM_PANEL is selected by DRM_IMX_LDB
>   symbol DRM_IMX_LDB depends on MFD_SYSCON
>   symbol MFD_SYSCON is selected by POWER_RESET_KEYSTONE
>   symbol POWER_RESET_KEYSTONE depends on POWER_SUPPLY
>   symbol POWER_SUPPLY is selected by HID_SONY
>   symbol HID_SONY depends on NEW_LEDS
>   symbol NEW_LEDS is selected by BACKLIGHT_ADP8860
>   symbol BACKLIGHT_ADP8860 depends on BACKLIGHT_CLASS_DEVICE
>   symbol BACKLIGHT_CLASS_DEVICE is selected by FB_MX3
>   symbol FB_MX3 depends on MX3_IPU
>   symbol MX3_IPU depends on DMADEVICES
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
