From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 16 Jul 2014 21:20:38 +0530
Subject: [PATCH 0/4] spi: s3c64xx: fix DT binding breakage
In-Reply-To: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAHfPSqB7BHx49WmFJ-1gyXYMPOyfapnMEGnwPiYOpap=295Vjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

On 16 July 2014 20:49, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Mark,
>
> The s3c64xx SPI driver DT binding is currently broken. Commit
> 3146bee ("spi: s3c64xx: Added provision for dedicated cs pin")
> added a new "cs-gpio" property and made it a requirement in
> order to make the driver behave in the same way that it used to.
>
> The motivation of the offending commit was to allow boards that
> want to use the native chip select (instead of a GPIO) to work
> with the s3c64xx SPI driver. Something that was not possible
> before since the driver made it mandatory to specify a GPIO.
>
> Unfortunately the commit also changed the driver defaults since
> now besides specifying a GPIO, it makes mandatory to also specify
> that a GPIO is used while the default used to be the opposite.
>
> That mean that old FDT are not working anymore after 3146bee
> so DT backward compatibility was not ensured by that commit.
>
> This is a follow-up series from a previous one posted by Naveen
> Krishna [0] which attempts to solve the issue.
>
> The feedback from Naveen's series was that the patches did not
> provide a clear explanation about the rationale and goal of both
> the series as a whole and the individual changes [1].
>
> So I tried to take Navee's series and rework them to provide
> an easier to understand patch series.
>
> The series is composed of the following patches:
>
> Javier Martinez Canillas (1):
>   Revert "spi: s3c64xx: Added provision for dedicated cs pin"
>
> Naveen Krishna Chatradhi (3):
>   spi: s3c64xx: use the generic SPI "cs-gpios" property
>   spi: samsung: Update binding documentation
>   ARM: DTS: fix the chip select gpios definition in the SPI nodes

I should have mentioned what was the issue being fixed. Your
explanation is very clear. I'm working on getting the terminology correct.

Thank you.

>
>  .../devicetree/bindings/spi/spi-samsung.txt        |  8 ++--
>  arch/arm/boot/dts/exynos4210-smdkv310.dts          |  2 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts            |  2 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  2 +-
>  drivers/spi/spi-s3c64xx.c                          | 54 ++++++++++------------
>  5 files changed, 30 insertions(+), 38 deletions(-)
>
> Patch 01/04 reverts the offending commit since it not only broke
> the DT binding but also introduced a confusing "cs-gpio" property
> while the driver already used a property with the same name.
>
> Patch 02/04 fixes the DT binding for good by using the SPI core
> "cs-gpios" property to specify the chip select GPIO instead of
> using a custom property only used by this driver. This change
> breaks backward compatibility but this has been broken for more
> than a year and nobody complained so I think it's safe to change
> it again in favor of using standard DT binding properties.
>
> A benefit of Patch 02/04 is that it allows DT and legacy boards
> that need to use the built-in CS instead of a GPIO to work with
> the driver which was the original motivation of the broken commit.
>
> Patch 03/04 updates the driver binding documentation accordingly
> and patch 04/04 updates all the DTS board files in mainline.
>
> Best regards,
> Javier
>
> [0]: http://www.spinics.net/lists/linux-samsung-soc/msg34163.html
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg34309.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
