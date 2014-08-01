From: trblinux@gmail.com (Tushar Behera)
Date: Fri, 1 Aug 2014 07:54:35 +0530
Subject: [PATCH] ARM: exynos_defconfig: Enable PL330 DMA
In-Reply-To: <11826036.v8B4Gvn5AK@amdc1032>
References: <1406785359-21669-1-git-send-email-tushar.b@samsung.com>
 <53D9DDAD.7040602@suse.de> <11826036.v8B4Gvn5AK@amdc1032>
Message-ID: <CAC5m3BwDtu+=QZGDsvT2LHju5Qg6wi7xcmR+csF7-7sET8GynA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 7:59 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Thursday, July 31, 2014 08:09:49 AM Andreas F?rber wrote:
>> Hi Tushar,
>>
>> Am 31.07.2014 07:42, schrieb Tushar Behera:
>> > We are getting a system hang on Arndale-Octa board if PL330_DMA is not
>> > enabled. The issue is related to [1].
>> >
>> > AUDSS block provides the clock for audio DMA controller. Any operation
>> > on this clock requires that the clock to AUDSS block be enabled. In
>> > current configuration, the clock is gated during late boot process when
>> > all unused clocks are disabled.
>> >
>> > When PL330_DMA is enabled, the 'apb_pclk' is enabled/disabled during
>> > amba_probe(). Otherwise, this clock is also disabled during late boot.
>> > If the AUDSS block clock is disabled by then, we get a system hang.
>
> Could you please explain this more?
>
> I don't get it how apb_pclk is related to AUDSS block clock and why

apb_pclk for ADMA is provided by AUDSS block on Exynos5420. Access to
the control register for this clock cause the system hang when the
clock to the AUDSS block is gated.

> enabling PL330_DMA fixes the issue (I suspect that enabling PL330_DMA
> enables PL330 DMA AMBA device so the amba_probe() keeps apb_pclk clock
> enabled but what is its relation to AUDSS block clock?).
>
>> > [1] https://lkml.org/lkml/2014/6/11/32
>> >
>> > Signed-off-by: Tushar Behera <tushar.b@samsung.com>
>> > ---
>> >  arch/arm/configs/exynos_defconfig |    2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> > index e07a227..c5888e8 100644
>> > --- a/arch/arm/configs/exynos_defconfig
>> > +++ b/arch/arm/configs/exynos_defconfig
>> > @@ -109,6 +109,8 @@ CONFIG_MMC_DW_IDMAC=y
>> >  CONFIG_MMC_DW_EXYNOS=y
>> >  CONFIG_RTC_CLASS=y
>> >  CONFIG_RTC_DRV_S3C=y
>> > +CONFIG_DMADEVICES=y
>> > +CONFIG_PL330_DMA=y
>> >  CONFIG_COMMON_CLK_MAX77686=y
>> >  CONFIG_EXT2_FS=y
>> >  CONFIG_EXT3_FS=y
>>
>> Reviewed-by: Andreas F?rber <afaerber@suse.de>
>>
>> Turns out I had those enabled in my local config when testing the memory
>> patches on Arndale Octa.
>>
>> multi_v7_defconfig has them already.
>
> I observe more and more discrepancies between exynos_defconfig and
> multi_v7_defconfig when it comes to Exynos specific options.  I wanted
> to avoid this by proposing exynos_defconfig removal when multiplatform
> support was added to Exynos.  Unfortunately there was no agreement on
> this at that time.  It would really be great if all Exynos users run on
> a common configuration so the testing is done more efficiently.
>
>> However, shouldn't Kconfig grow a dependency to enable those options
>> automatically for whatever driver or SoC needs them?
>
> Yes, moreover it is not clear yet that enabling PL330 DMA to resolve
> the hang issue is the right approach (to be honest it looks like
> a workaround for the lack of proper clock dependencies in a code).
>

This, for sure, is only a temporary fix. The real fix lies in patch
[1] (mentioned in the original patch comment) which needs a bit of
redesign. I am not able to work on that because of lack of time.

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>



-- 
Tushar Behera
