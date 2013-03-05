From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 5 Mar 2013 23:25:12 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303052154.22857.arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303052124.04101.arnd@arndb.de> <201303052154.22857.arnd@arndb.de>
Message-ID: <201303052325.13143.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 5. M?rz 2013, 22:54:22 schrieb Arnd Bergmann:
> On Tuesday 05 March 2013, Arnd Bergmann wrote:
> > The s3c64xx_dma code is also interesting because
> > it has both an implementation of the s3c_dma interface in
> > arch/arm/mach-s3c64xx/dma.c and one using the generic interface in
> > drivers/dma/amba-pl08x.c.
> 
> This actually brings me to an interesting idea: the s3c64xx SPI driver
> is used with the regular dmaengine API and pl330 on S5P and Exynos,
> but with the s3c-dma interface and pl080 on S3C64xx.
>
> If we just convert S3C64xx to use the pl080 dmaengine driver
> instead, we can apply my SPI patch without breaking anything.

The S3C24XX starting from S3C2443 (including S3C2416 and S3C2450) also use the
s3c64xx-spi driver.

My argument has of course the problem of me seemingly being the only user of
it currently and it being stuff not in mainline yet [0] :-) .

But on the other hand, it's no use anyway staying attached to old cruft, so
it also wouldn't be a problem to go your way. I'll just try to come up with
a dmaengine driver for s3c24xx after common-clk and pinctrl ;-) .


[0] https://github.com/mmind/linux-es600/blob/topic/es600-devel/arch/arm/mach-
s3c24xx/mach-as090.c#L138


> We still need a solution for the ASoC drivers, but they are
> not as essential. We could probably move the wrapper files
> from plat-samsung/*dma*.c to sounds/soc/samsung when that becomes
> the only remaining user.

In ASoC there is also a clear distinction between the different SoC
generations. SND_SAMSUNG_I2S /_PCM /_AC97 ... is only used by newer SoCs
while SND_S3C24XX_I2S and SND_S3C_I2SV2_SOC is used by the legacy SoCs.

Of course "my subarch" is bitten again, as it's using the new sound
interface, but the same as above applies.


Heiko
