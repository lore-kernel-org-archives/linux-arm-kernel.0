From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 29 Jul 2013 15:03:17 +0530
Subject: [PATCH] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for exynos5440
In-Reply-To: <13615299.reg39gbbhi@flatron>
References: <0e7d01ce8840$82f79070$88e6b150$@org> <51F4F317.1040001@linaro.org>
 <CADGdYn761S+rDe=GaypFwAYdtQxFZRv0W=jmX9-KomogK5T7ww@mail.gmail.com>
 <13615299.reg39gbbhi@flatron>
Message-ID: <CADGdYn6zsr7HTcV2PD++Ze1Otwf5A51D7GwLDmUuqMdRiN+h=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, Jul 29, 2013 at 2:03 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 29 of July 2013 10:16:14 amit daniel kachhap wrote:
>> Hi Daniel/Tomasz,
>>
>> From the discussion I can conclude that SOC check is needed in the
>> cpuidle driver for deeper C states.
>
> A check is needed for the whole cpuidle driver, so it registers only on
> Exynos SoCs which support deeper C states.

>
>> Only the question is where to
>> insert this.
>
> Exynos doesn't support multiplatform yet, but we must make sure that any
> code being added is multiplatform-aware. So initcall is not a good idea. I
> would put this somewhere on Exynos-specific initialization path, i.e.
> something that would not called for all platforms compiled in (in case of
> multiplatform).
>
> As I discussed with Daniel, this should be using a traditional
> platform_driver model, with the difference that it can't be registered
> from device tree, but rather statically in mach code.
>
> For example, you can add an exynos_register_cpuidle() function in
> arch/arm/mach-exynos/common.c, which registers such platform device and
> always call it from exynos4_dt_machine_init() in mach-exynos4-dt.c. In
> mach-exynos5-dt.c you could make this conditional and check if
> !soc_is_exynos5440().
thanks for the detailed explanation. Certainly initcall is not good
for multikernel. Still I have few concerns.
1) Each C state might be SOC specific. Say there are 3 C states
C0(basic wfi), c1(single CPU power down) and C2 (System wide power
down like AFTR). In this case some exynos soc may support few of these
states and cpuidle driver should bind C-state to correct SOC.
2) Even for default C0 ( simple wfi) currently there is no sysfs
information if the cpuidle driver is not registered(Not quite sure).
I will try to post the new driver by dynamically creating the
cpuidle_state table based on SOC capability and removing the initcall.

Regards,
Amit D
>
> Best regards,
> Tomasz
>
>> Also to perform the SOC there can be 2 ways like
>> 1) each SOC check 4120, 4412, 5250 etc (long list)
>> 2) negate the nonsupporting SOC's like 5440 (small list like current
>> patch) Any opinion?
>>  As Bartlomiej suggested that this patch conflicts with Daniel's
>> earlier patch http://marc.info/?l=linux-arm-kernel&m=137467935712513&w=2
>> So I can re-base my patch on top of this one if needed.
>>
>> Thanks,
>> Amit Daniel
>>
>> On Sun, Jul 28, 2013 at 4:01 PM, Daniel Lezcano
>>
>> <daniel.lezcano@linaro.org> wrote:
>> > On 07/28/2013 11:22 AM, Tomasz Figa wrote:
>> >> On Sunday 28 of July 2013 09:10:09 Daniel Lezcano wrote:
>> >>> On 07/24/2013 01:47 PM, Kukjin Kim wrote:
>> >>>> Amit Daniel Kachhap wrote:
>> >>>>> This patch skips the deep C1(AFTR -Arm off top running) state for
>> >>>>> exynos5440
>> >>>>> soc as this soc does not support this state. All the cpu's only
>> >>>>> allows the basic
>> >>>>> C0 state.
>> >>>>>
>> >>>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> >>>>> ---
>> >>>>>
>> >>>>>  arch/arm/mach-exynos/cpuidle.c |    2 +-
>> >>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> >>>>>
>> >>>>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
>> >>>>> exynos/cpuidle.c
>> >>>>> index 17a18ff..9a776a1 100644
>> >>>>> --- a/arch/arm/mach-exynos/cpuidle.c
>> >>>>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> >>>>> @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
>> >>>>>
>> >>>>>            device->cpu = cpu_id;
>> >>>>>
>> >>>>>            /* Support IDLE only */
>> >>>>>
>> >>>>> -          if (cpu_id != 0)
>> >>>>> +          if (soc_is_exynos5440() || cpu_id != 0)
>> >>>>>
>> >>>>>                    device->state_count = 1;
>> >>>>>
>> >>>>>            ret = cpuidle_register_device(device);
>> >>>>>
>> >>>>> --
>> >>>>> 1.7.1
>> >>>>
>> >>>> Applied, thanks.
>> >>>
>> >>> You shouldn't have. This patch means exynos5540 has no cpuidle
>> >>> driver at all. It should be fixed in the Kconfig to unselect
>> >>> CONFIG_CPU_IDLE for an exynos5540.
>> >>
>> >> To shed more light on this, let me add that you need to register a
>> >> cpuidle driver only if you have more states than a simple WFI or you
>> >> need some crazy steps to enter WFI. Default setup falls back to
>> >> generic ARM WFI. (Daniel, do we get the nice idle stats as provided
>> >> by cpuidle core then?)>
>> > Nope, but with one state, idle vs busy stats do the trick.
>> >
>> > BTW, I am writing a tool to do some stats based on the idle events
>> > [1].
>> > It is still at a very early development stage but we can get some
>> > interesting informations.
>> >
>> >> Anyway, Exynos cpuidle is using an initcall to initialize and we
>> >> support multiple Exynos SoCs in single zImage, so deselecting
>> >> CONFIG_CPU_IDLE is not an option.
>> >
>> > Good point.
>> >
>> >> Considering multiplatform requirements, the driver has to
>> >>
>> >> be modified to initialize only on supported platforms, either by:
>> >>  a) dropping the initcall and calling the init function directly from
>> >>
>> >> arch/arm/mach-exynos
>> >>
>> >>  or
>> >>
>> >>  b) checking if machine we are running on is supported, which would
>> >>  mean a>>
>> >> long list of all Exynos SoCs that needs to be checked.
>> >>
>> >> An evolution of option a) is registering a platform device somewhere
>> >> in
>> >> arch/arm/mach-exynos and making exynos-cpuidle a platform driver.
>> >
>> > Yes, I am favorable to this solution [2].
>> >
>> >> The
>> >> problem is that you must register a static platform device from arch
>> >> code, because cpuidle is not a real hardware block that can be put
>> >> into device tree.
>> >
>> > Thanks
>> >
>> >   -- Daniel
>> >
>> > [1]
>> > https://git.linaro.org/gitweb?p=people/dlezcano/idlestat.git;a=summar
>> > y [2] http://patches.linaro.org/18368/
>> >
>> > --
>> >
>> >  <http://www.linaro.org/> Linaro.org ? Open source software for ARM
>> >  SoCs
>> >
>> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> > <http://twitter.com/#!/linaroorg> Twitter |
>> > <http://www.linaro.org/linaro-blog/> Blog
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-samsung-soc" in the body of a message to
>> > majordomo at vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
