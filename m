From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Dec 2011 21:15:34 +0900
Subject: [PATCH] ARM: exynos4: Fix for stall in case of cpu hotplug or
 sleep
In-Reply-To: <CADGdYn7jfFYkuoFX9J3NtNbgLHgagWHa3q3mehJU+gY_mg5EOw@mail.gmail.com>
References: <1321616752-1233-1-git-send-email-amit.kachhap@linaro.org>
 <047501ccb014$edda8f60$c98fae20$%kim@samsung.com>
 <CADGdYn7jfFYkuoFX9J3NtNbgLHgagWHa3q3mehJU+gY_mg5EOw@mail.gmail.com>
Message-ID: <042c01ccb4d9$ebb56ba0$c32042e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amit kachhap wrote:
> 
> On Thu, Dec 1, 2011 at 4:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Amit Daniel Kachhap wrote:
> >>
> >> This patch adds remove_irq in place of disable_irq which is
> >> correct equivalent function for setup_irq used in
> >> exynos4_mct_tick_init.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> Tested-by: Inderpal Singh <inderpal.singh@linaro.org>
> >> ---
> >> ?arch/arm/mach-exynos/mct.c | ? ?6 +++++-
> >> ?1 files changed, 5 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
> >> index 97343df..959f251 100644
> >> --- a/arch/arm/mach-exynos/mct.c
> >> +++ b/arch/arm/mach-exynos/mct.c
> >> @@ -428,9 +428,13 @@ int __cpuinit local_timer_setup(struct
> >> clock_event_device *evt)
> >>
> >> ?void local_timer_stop(struct clock_event_device *evt)
> >> ?{
> >> + ? ? unsigned int cpu = smp_processor_id();
> >> ? ? ? evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
> >> ? ? ? if (mct_int_type == MCT_INT_SPI)
> >> - ? ? ? ? ? ? disable_irq(evt->irq);
> >> + ? ? ? ? ? ? if (cpu == 0)
> >> + ? ? ? ? ? ? ? ? ? ? remove_irq(evt->irq, &mct_tick0_event_irq);
> >> + ? ? ? ? ? ? else
> >> + ? ? ? ? ? ? ? ? ? ? remove_irq(evt->irq, &mct_tick1_event_irq);
> >
> > Hmm, how about the cpu number is 2 or 3 on Quad-core?
> > As you know, this should be used for all of EXYNOS SoCs.
> 
> This code change is specific for EXYNOS4210 where the MCT irq is SPI
> type. Other exynos soc's (4412 etc) are not effected by this change.
> I am adding the cpu stall log currently caused during cpu1 hotplug or
> sleep/wakeup sequence. This commit fixes this.
> 
Yes, you're right. Will apply :)
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
