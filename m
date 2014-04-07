From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Apr 2014 09:26:31 -0700
Subject: [PATCH V2 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <6917975.3JZyGKGoxO@amdc1032>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <5825506.2ErDt1UQ5r@amdc1032> <53427353.2020303@linaro.org>
 <6917975.3JZyGKGoxO@amdc1032>
Message-ID: <CAOesGMhnREwo-GEWACsfe30CCQqkzbqanY4VKjnitTQPq7-2Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 7, 2014 at 9:19 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Monday, April 07, 2014 11:43:47 AM Daniel Lezcano wrote:
>> On 04/04/2014 06:09 PM, Bartlomiej Zolnierkiewicz wrote:
>> >
>> > On Friday, April 04, 2014 03:43:09 PM Daniel Lezcano wrote:
>> >> The cpuidle driver is broken since v3.11 and now we are at v3.14.
>> >>
>> >> Default the cpuidle driver to favorize a better detection next time.
>> >>
>> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> >> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >> ---
>> >>   arch/arm/configs/exynos_defconfig |    1 +
>> >>   1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> >> index 4ce7b70..6ed4b34 100644
>> >> --- a/arch/arm/configs/exynos_defconfig
>> >> +++ b/arch/arm/configs/exynos_defconfig
>> >> @@ -132,3 +132,4 @@ CONFIG_DEBUG_INFO=y
>> >>   CONFIG_DEBUG_USER=y
>> >>   CONFIG_CRYPTO_SHA256=y
>> >>   CONFIG_CRC_CCITT=y
>> >> +CONFIG_CPU_IDLE=y
>> >
>> > Sorry but I have to NAK this change.  There are three issues with AFTR
>> > mode that should be resolved first before this patch can be merged:
>> >
>> > * The upstream Exynos cpuidle code lacks support for secure firmware and
>> >    it is used on i.e. Trats2 boards (Exynos4412).  Attempts to use AFTR on
>> >    such hardware results in oops + lockup.
>> >    I have patches adding secure firmware support to Exynos cpuidle driver
>> >    but they depend on Tomasz Figa's PM changes which are not yet upstream.
>>
>> Ok.
>>
>> > * Somebody needs to verify that the current Exynos cpuidle driver works
>> >    in the AFTR mode on Exynos5420 for which support has been added recently
>> >    (I really doubt it looking at some internal trees).
>>
>> Rajeshwari (cc'ed) is working on creating a big.Little driver for this
>> board, so it will be a separate cpuidle driver.
>>
>> > * Some of our u-boot bootloader versions are incompatible with AFTR.  We
>> >    have observed the problem happening on Trats board (Exynos4210) on which
>> >    it can be fixed by using the upstream u-boot version and Universal C210
>> >    board (Exynos4210 with broken SMP support) on which there is no upstream
>> >    u-boot available (IIRC) and because of the broken SMP support enabling
>> >    cpuidle results in attempt to enter AFTR during boot + immediate lockup.
>> >
>> >    I know that this is mainly our problem but the issue is widespread on
>> >    our targets and I believe that adding some workaround for it in cpuidle
>> >    core would be beneficial for the whole cpuidle subsystem.  Namely there
>> >    should be some way of telling cpuidle subsystem to either disable
>> >    particular state(s) or limit the max available state.  I think that this
>> >    can be also useful for testing and development of other cpuidle drivers.
>> >
>> > For now please change this patch to add CONFIG_CPU_IDLE=n instead (since
>> > the config option is "default y" it will be auto-enabled if there is no
>> > entry in the defconfig)..
>>
>> Ok.
>>
>> Kukjin, is it possible you merge patches 1->16 ?
>
> It is OK given that patch #17 is fixed and merged at the same time
> (preferably it should go before patches #1-16 to preserve bisectability).
> Alternatively 'default y' should be removed from patch #16 before
> the merge.  We really don't want to have EXYNOS cpuidle driver enabled
> by default yet.

Default y is almost always the wrong thing to use, so that should be
taken out no matter what.


-Olof
