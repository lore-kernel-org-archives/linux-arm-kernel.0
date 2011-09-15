From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 15 Sep 2011 16:42:07 +0900
Subject: [PATCH 2/2] ARM: Exynos4: use s5p-timer for UniversalC210 board
In-Reply-To: <00aa01cc737a$76d75690$648603b0$%kim@samsung.com>
References: <1311659456-6659-1-git-send-email-m.szyprowski@samsung.com>
	<1311659456-6659-3-git-send-email-m.szyprowski@samsung.com>
	<CAH9JG2V6Sfjmjupj5oBd_5vziBa4iezBpRfK9tNECrFO5sSfLw@mail.gmail.com>
	<00a301cc736d$2d9c4fb0$88d4ef10$%kim@samsung.com>
	<CAH9JG2UKh5poAVFoXbEL0N9Afj3D16nuMYWEmeFRNL47P5onpw@mail.gmail.com>
	<00aa01cc737a$76d75690$648603b0$%kim@samsung.com>
Message-ID: <CAH9JG2Va4R76PUCkR4dFJtxir_S7t2gHuiy2MkY1Zjsa8JnvCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 4:38 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On Thu, Sep 15, 2011 at 3:03 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > Kukjin Kim wrote:
>> >>
>> >> Kyungmin Park wrote:
>> >> >
>> >> > Hi,
>> >> >
>> >> > It's required for boot universal c210 w/ EVT0 chip.
>> >> > Can you include it at 3.1 fixed branch?
>> >> >
>> >> Sure, will apply into samsung-fixes for 3.1.
>> >
>> > Unfortunately, it happens boot failure with this patch on other
> EXYNOS4210
>> > boards and it is due to HAVE_SCHED_CLOCK.
>> >
>> >> > > + ? ? ? select HAVE_SCHED_CLOCK
>> >
>> > I think, we need to sort out the method...
>> As sched_clock_postinit is called at generic time code by
>> HAVE_SCHED_CLOCK. and there's no sched_clock_update_fn() is defined.
>> As a work-around, you can test it.
>>
>> static void sched_clock_poll(unsigned long wrap_ticks)
>> {
>> ? ? ? ? mod_timer(&sched_clock_timer, round_jiffies(jiffies +
> wrap_ticks));
>> ? ? ? ? if (sched_clock_update_fn)
>> ? ? ? ? ? ? ? ? sched_clock_update_fn();
>> }
>>
>
> Following is better than above but need Russell's review
Right, during the make a patch, I also found it. Check the patch

And boot tested both EVT0 and others.
>
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 9a46370..b1a1283 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -70,5 +70,6 @@ void __init init_sched_clock(struct clock_data *cd, void
> (*update)(void),
>
> ?void __init sched_clock_postinit(void)
> ?{
> - ? ? ? sched_clock_poll(sched_clock_timer.data);
> + ? ? ? if (sched_clock_update_fn)
> + ? ? ? ? ? ? ? sched_clock_poll(sched_clock_timer.data);
> ?}
>
>
>> To solve the problem correctly. you can add init_sched_clock at
>> "arch/arm/mach-exynos4/mct.c" properly
>>
>> Please test the work-around and share the result. I'll try to find the
>> proper place to add init_sched_clock at mct.c
>>
>> Thank you,
>> Kyungmin Park
>>
>>
>> >
>> > Thanks.
>> >
>> > Best regards,
>> > Kgene.
>> > --
>> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> > SW Solution Development Team, Samsung Electronics Co., Ltd.
>> >
>> >>
>> >> > Thank you,
>> >> > Kyungmin Park
>> >> >
>> >> > On Tue, Jul 26, 2011 at 2:50 PM, Marek Szyprowski
>> >> > <m.szyprowski@samsung.com> wrote:
>> >> > > Commit 069d4e743 removed support for local timers and forced to use
>> > MCT
>> >> as
>> >> > > event source. However MCT is not operating properly on early
> revision
>> > (EVT0)
>> >> > > of Exynos4 SoCs. All UniversalC210 boards are based on Exynos4
> EVT0,
>> > so
>> >> > that
>> >> > > commit broke support for it. This patch provides a workaround that
>> > enables
>> >> > > UniversalC210 boards to boot again. s5p-timer is used as an event
>> > source.
>> >> > >
>> >> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> >> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >> > > ---
>> >> > > ?arch/arm/mach-exynos4/Kconfig ? ? ? ? ? ? ? | ? ?3 +++
>> >> > > ?arch/arm/mach-exynos4/mach-universal_c210.c | ? ?4 +++-
>> >> > > ?2 files changed, 6 insertions(+), 1 deletions(-)
>> >> > >
>> >> > > diff --git a/arch/arm/mach-exynos4/Kconfig
>> > b/arch/arm/mach-exynos4/Kconfig
>> >> > > index 9d62e13..2aad73f 100644
>> >> > > --- a/arch/arm/mach-exynos4/Kconfig
>> >> > > +++ b/arch/arm/mach-exynos4/Kconfig
>> >> > > @@ -173,6 +173,9 @@ config MACH_ARMLEX4210
>> >> > > ?config MACH_UNIVERSAL_C210
>> >> > > ? ? ? ?bool "Mobile UNIVERSAL_C210 Board"
>> >> > > ? ? ? ?select CPU_EXYNOS4210
>> >> > > + ? ? ? select S5P_HRT
>> >> > > + ? ? ? select CLKSRC_MMIO
>> >> > > + ? ? ? select HAVE_SCHED_CLOCK
>> >> > > ? ? ? ?select S5P_GPIO_INT
>> >> > > ? ? ? ?select S5P_DEV_FIMC0
>> >> > > ? ? ? ?select S5P_DEV_FIMC1
>> >> > > diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c
>> > b/arch/arm/mach-
>> >> > exynos4/mach-universal_c210.c
>> >> > > index 0e280d1..ca9e7b7 100644
>> >> > > --- a/arch/arm/mach-exynos4/mach-universal_c210.c
>> >> > > +++ b/arch/arm/mach-exynos4/mach-universal_c210.c
>> >> > > @@ -34,6 +34,7 @@
>> >> > > ?#include <plat/mfc.h>
>> >> > > ?#include <plat/sdhci.h>
>> >> > > ?#include <plat/pd.h>
>> >> > > +#include <plat/s5p-time.h>
>> >> > >
>> >> > > ?#include <mach/map.h>
>> >> > >
>> >> > > @@ -730,6 +731,7 @@ static void __init universal_map_io(void)
>> >> > > ? ? ? ?s5p_init_io(NULL, 0, S5P_VA_CHIPID);
>> >> > > ? ? ? ?s3c24xx_init_clocks(24000000);
>> >> > > ? ? ? ?s3c24xx_init_uarts(universal_uartcfgs,
>> > ARRAY_SIZE(universal_uartcfgs));
>> >> > > + ? ? ? s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
>> >> > > ?}
>> >> > >
>> >> > > ?static void __init universal_reserve(void)
>> >> > > @@ -766,6 +768,6 @@ MACHINE_START(UNIVERSAL_C210,
>> >> > "UNIVERSAL_C210")
>> >> > > ? ? ? ?.init_irq ? ? ? = exynos4_init_irq,
>> >> > > ? ? ? ?.map_io ? ? ? ? = universal_map_io,
>> >> > > ? ? ? ?.init_machine ? = universal_machine_init,
>> >> > > - ? ? ? .timer ? ? ? ? ?= &exynos4_timer,
>> >> > > + ? ? ? .timer ? ? ? ? ?= &s5p_timer,
>> >> > > ? ? ? ?.reserve ? ? ? ?= &universal_reserve,
>> >> > > ?MACHINE_END
>> >> > > --
>> >> > > 1.7.1.569.g6f426
>> >> > >
>> >> > > --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
