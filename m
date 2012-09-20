From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Sep 2012 17:23:12 +0900
Subject: [PATCH 2/3] ARM: EXYNOS: add device tree based discovery support
 for FIMD
In-Reply-To: <CAL1wa8dj_Tm0QdbKh=xTqkvqhHu3tpuOFWRwMpiqY_1nx1Swgg@mail.gmail.com>
References: <1347992531-27279-1-git-send-email-l.krishna@samsung.com>
 <1347992531-27279-3-git-send-email-l.krishna@samsung.com>
 <007801cd96ed$1b408080$51c18180$%han@samsung.com>
 <CAL1wa8dj_Tm0QdbKh=xTqkvqhHu3tpuOFWRwMpiqY_1nx1Swgg@mail.gmail.com>
Message-ID: <008301cd9709$2d198740$874c95c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 20, 2012 2:54 PM Leela Krishna Amudala wrote
> 
> Hi Jingoo Han,
> 
> On Thu, Sep 20, 2012 at 10:32 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Wednesday, September 19, 2012 3:22 AM Leela Krishna Amudala wrote
> >>
> >> This patch adds support for device tree based discovery for Samsung's
> >> display controller. Adds DRM-Fimd plat data for smdk5250
> >> evt1 to the corresponding dts file
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> ---
> >>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   16 ++++++++++++++++
> >>  arch/arm/mach-exynos/include/mach/map.h   |    1 +
> >>  arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 ++
> >>  3 files changed, 19 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> >> index 8a5e348..c8d32f5 100644
> >> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> >> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> >> @@ -109,4 +109,20 @@
> >>       spi_2: spi at 12d40000 {
> >>               status = "disabled";
> >>       };
> >> +
> >> +     lcd_fimd0: lcd_panel0 {
> >> +                     lcd-htiming = <4 4 4 1280>;
> >> +                     lcd-vtiming = <4 4 4 800>;
> >> +                     supports-mipi-panel;
> >> +     };
> >> +
> >> +     fimd {
> >> +             samsung,fimd-display = <&lcd_fimd0>;
> >> +             samsung,fimd-vidout-rgb;
> >> +             samsung,fimd-inv-vclk;
> >> +             samsung,fimd-frame-rate = <60>;
> >> +             samsung,default-window = <0>;
> >> +             samsung,fimd-win-bpp = <32>;
> >> +     };
> >> +
> >>  };
> >> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> >> index b2021bd..dd9cea3 100644
> >> --- a/arch/arm/mach-exynos/include/mach/map.h
> >> +++ b/arch/arm/mach-exynos/include/mach/map.h
> >> @@ -174,6 +174,7 @@
> >>  #define EXYNOS4_PA_MIPI_CSIS1                0x11890000
> >>
> >>  #define EXYNOS4_PA_FIMD0             0x11C00000
> >> +#define EXYNOS5_PA_FIMD                      0x14400000
> >
> > CC'ed Thomas Abraham
> >
> > Please, replace EXYNOS5_PA_FIMD with EXYNOS5_PA_FIMD1.
> >
> > As I mentioned before, Other Exynos5 SoCs can have 2 FIMD IPs.
> > Also, Exynos5250 uses FIMD1.
> >
> >
> 
> As per Joonyoung Shim's comment on my previous patches I renamed it
> from EXYNOS5_PA_FIMD1 to EXYNOS5_PA_FIMD. Will change it in next
> version.
> Thanks for reviewing the patch set.

Let me explain why FIMD1 is right.

Exynos5 SoCs have 2 FIMD IPs, and its address are 0x13800000
And 0x14400000, respectively. Therefore, if address of FIMD IP
Is 0x14400000, it means FIMD1.

Best regards,
Jingoo Han

> 
> Best Wishes,
> Leela Krishna Amudala.
> 
> >>
> >>  #define EXYNOS4_PA_HSMMC(x)          (0x12510000 + ((x) * 0x10000))
> >>  #define EXYNOS4_PA_DWMCI             0x12550000
> >> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> >> index e707eb1..0d35d31 100644
> >> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> >> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> >> @@ -64,6 +64,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
> >>                               "exynos-gsc.2", NULL),
> >>       OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
> >>                               "exynos-gsc.3", NULL),
> >> +     OF_DEV_AUXDATA("samsung,exynos5-fimd", EXYNOS5_PA_FIMD,
> >> +                             "exynos5-fb.1", NULL),
> >>       {},
> >>  };
> >>
> >> --
> >> 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
