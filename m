From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 12 Jun 2014 12:22:58 +0200
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <20140612094745.GD23430@n2100.arm.linux.org.uk>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <20140612094745.GD23430@n2100.arm.linux.org.uk>
Message-ID: <1402568578.10273.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc-ing Yann and linux-kbuild.]

On Thu, 2014-06-12 at 10:47 +0100, Russell King - ARM Linux wrote:
> If no one responds, I'll assume that no one is interested, and I'll
> just create a pile of patches removing a bunch of these idiotic select
> statements at random to break this loop.

I looked into a much, much easier "recursive dependency" warning
recently. That triggered me to post
http://article.gmane.org/gmane.linux.kernel/1678946 . In summary: select
statements are treated as "reverse dependencies", but that is actually
rather odd.

See, for example, DMADEVICES in this warning: the kconfig code treats it
as if it's depending on SAMSUNG_DMADEV. But I would be very surprised if
that was what was intended when that select statement was added. Please
note that I have not yet really looked into the mess you reported. But
for now I'll state that a recursive dependency warning involving select
statements is probably bogus. Perhaps Yann e.a. can prove me wrong.

I might have an ugly hack to the kconfig code disabling the "recursive
dependency" stuff stashed away somewhere. Not sure, as it's been two
months...


Paul Bolle

> On Sat, Jun 07, 2014 at 10:09:44AM +0100, Russell King - ARM Linux wrote:
> > This is getting silly:
> > 
> > scripts/kconfig/conf --silentoldconfig Kconfig
> > drivers/dma/Kconfig:5:error: recursive dependency detected!
> > drivers/dma/Kconfig:5:  symbol DMADEVICES is selected by SAMSUNG_DMADEV
> > arch/arm/plat-samsung/Kconfig:412:      symbol SAMSUNG_DMADEV is selected by S3C64XX_PL080
> > arch/arm/mach-s3c64xx/Kconfig:20:       symbol S3C64XX_PL080 is selected by SPI_S3C64XX
> > drivers/spi/Kconfig:429:        symbol SPI_S3C64XX depends on SPI
> > drivers/spi/Kconfig:8:  symbol SPI is selected by DRM_PANEL_LD9040
> > drivers/gpu/drm/panel/Kconfig:19:       symbol DRM_PANEL_LD9040 depends on DRM_PANEL
> > drivers/gpu/drm/panel/Kconfig:1:        symbol DRM_PANEL is selected by DRM_IMX_LDB
> > drivers/staging/imx-drm/Kconfig:35:     symbol DRM_IMX_LDB depends on MFD_SYSCON
> > drivers/mfd/Kconfig:722:        symbol MFD_SYSCON is selected by POWER_RESET_KEYSTONE
> > drivers/power/reset/Kconfig:76: symbol POWER_RESET_KEYSTONE depends on POWER_SUPPLY
> > drivers/power/Kconfig:1:        symbol POWER_SUPPLY is selected by HID_SONY
> > drivers/hid/Kconfig:622:        symbol HID_SONY depends on NEW_LEDS
> > drivers/leds/Kconfig:8: symbol NEW_LEDS is selected by BACKLIGHT_ADP8860
> > drivers/video/backlight/Kconfig:327:    symbol BACKLIGHT_ADP8860 depends on BACKLIGHT_CLASS_DEVICE
> > drivers/video/backlight/Kconfig:156:    symbol BACKLIGHT_CLASS_DEVICE is selected by FB_MX3
> > drivers/video/fbdev/Kconfig:2333:       symbol FB_MX3 depends on MX3_IPU
> > drivers/dma/Kconfig:121:        symbol MX3_IPU depends on DMADEVICES
> > 
> > This is a good illustration why the select disease is truely bad...
