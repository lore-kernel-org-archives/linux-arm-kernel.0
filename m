From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Jul 2013 12:46:16 +0200
Subject: [PATCH] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for exynos5440
In-Reply-To: <51F4F317.1040001@linaro.org>
References: <0e7d01ce8840$82f79070$88e6b150$@org> <1877730.qZVs3NAG5h@flatron>
 <51F4F317.1040001@linaro.org>
Message-ID: <1449250.PNC13edUOF@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 of July 2013 12:31:51 Daniel Lezcano wrote:
> On 07/28/2013 11:22 AM, Tomasz Figa wrote:
> > On Sunday 28 of July 2013 09:10:09 Daniel Lezcano wrote:
> >> On 07/24/2013 01:47 PM, Kukjin Kim wrote:
> >>> Amit Daniel Kachhap wrote:
> >>>> This patch skips the deep C1(AFTR -Arm off top running) state for
> >>>> exynos5440
> >>>> soc as this soc does not support this state. All the cpu's only
> >>>> allows the basic
> >>>> C0 state.
> >>>> 
> >>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>>> ---
> >>>> 
> >>>>  arch/arm/mach-exynos/cpuidle.c |    2 +-
> >>>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>> 
> >>>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> >>>> exynos/cpuidle.c
> >>>> index 17a18ff..9a776a1 100644
> >>>> --- a/arch/arm/mach-exynos/cpuidle.c
> >>>> +++ b/arch/arm/mach-exynos/cpuidle.c
> >>>> @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
> >>>> 
> >>>>  		device->cpu = cpu_id;
> >>>>  		
> >>>>  		/* Support IDLE only */
> >>>> 
> >>>> -		if (cpu_id != 0)
> >>>> +		if (soc_is_exynos5440() || cpu_id != 0)
> >>>> 
> >>>>  			device->state_count = 1;
> >>>>  		
> >>>>  		ret = cpuidle_register_device(device);
> >>>> 
> >>>> --
> >>>> 1.7.1
> >>> 
> >>> Applied, thanks.
> >> 
> >> You shouldn't have. This patch means exynos5540 has no cpuidle driver
> >> at all. It should be fixed in the Kconfig to unselect
> >> CONFIG_CPU_IDLE for an exynos5540.
> > 
> > To shed more light on this, let me add that you need to register a
> > cpuidle driver only if you have more states than a simple WFI or you
> > need some crazy steps to enter WFI. Default setup falls back to
> > generic ARM WFI. (Daniel, do we get the nice idle stats as provided
> > by cpuidle core then?)
> Nope, but with one state, idle vs busy stats do the trick.
> 
> BTW, I am writing a tool to do some stats based on the idle events [1].
> It is still at a very early development stage but we can get some
> interesting informations.

Sounds good.

By the way, a random idea that just came to my mind is that since we 
already support multiple cpuidle drivers, what about providing a default 
cpuidle-wfi driver that gets used in case no other driver is available?

This would give us cpuidle stats at the same place as with other cpuidle 
drivers and might also unify some code paths.

As I said, it's just a random idea, so feel free to redirect it to 
/dev/null.

> > Anyway, Exynos cpuidle is using an initcall to initialize and we
> > support multiple Exynos SoCs in single zImage, so deselecting
> > CONFIG_CPU_IDLE is not an option.
> 
> Good point.
> 
> > Considering multiplatform requirements, the driver has to
> > 
> > be modified to initialize only on supported platforms, either by:
> >  a) dropping the initcall and calling the init function directly from
> > 
> > arch/arm/mach-exynos
> > 
> >  or
> >  
> >  b) checking if machine we are running on is supported, which would
> >  mean a> 
> > long list of all Exynos SoCs that needs to be checked.
> > 
> > An evolution of option a) is registering a platform device somewhere
> > in
> > arch/arm/mach-exynos and making exynos-cpuidle a platform driver.
> 
> Yes, I am favorable to this solution [2].

OK, looks good.

Best regards,
Tomasz
