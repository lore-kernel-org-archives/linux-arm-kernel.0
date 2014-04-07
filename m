From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Apr 2014 11:33:57 -0700
Subject: [PATCH V2 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <3344539.A0GIVp3yPt@amdc1032>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <5825506.2ErDt1UQ5r@amdc1032>
 <CAOesGMgkbfUX=cJ4rMf+-26Sq_fYUNW8m6unNiCXHKwj83dLbw@mail.gmail.com>
 <3344539.A0GIVp3yPt@amdc1032>
Message-ID: <CAOesGMgf4owZBCVz4RTgbFVsogws6WKARmA7COkgXVQaG5ky9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 7, 2014 at 10:44 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Monday, April 07, 2014 09:28:39 AM Olof Johansson wrote:
>> On Fri, Apr 4, 2014 at 9:09 AM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>>
>> [...]
>> >   I know that this is mainly our problem but the issue is widespread on
>> >   our targets and I believe that adding some workaround for it in cpuidle
>> >   core would be beneficial for the whole cpuidle subsystem.
>
> On the second look at the cpuidle code there is a "cpuidle.off" kernel
> parameter which should be sufficient to workaround this particular issue
> for now.
>
>> Yes, we need to find a way forward without you guys holding the whole
>> platform hostage with out-of-tree code (here and in general, since I
>> think there are more areas in which this applies).
>
> Please explain this more because I really don't know what you're meaning
> here (at least in case of SRPOL I feel that there are no such issues).
>
> In this particular case we have a problem with a modified uboot bootloader
> versions being broken and incompatible with the advanced AFTR cpuidle mode.
> This is not the only / main issue preventing AFTR mode and thus EXYNOS
> cpuidle driver from being used by default so I really think that the your
> comment was unfair.

Holding off features for users of the platform because your firmware
is too old (and you can't control the feature per platform) is going
to get harder and harder, so being able to enable these kind of things
at runtime will be important. I.e. as features go in, it's something
that needs to be considered (runtime checking vs ifdef).

Calling that hostage taking? Yeah, maybe a little on the harsh side.
But the problem definitely exists.

>> >  Namely there
>> >   should be some way of telling cpuidle subsystem to either disable
>> >   particular state(s) or limit the max available state.  I think that this
>> >   can be also useful for testing and development of other cpuidle drivers.
>> >
>> > For now please change this patch to add CONFIG_CPU_IDLE=n instead (since
>> > the config option is "default y" it will be auto-enabled if there is no
>> > entry in the defconfig)..
>>
>> Can the code be refactored such that even if CPU_IDLE is on, it won't
>> actually do anything useful on the platforms that have problems above?
>> I.e. determined at runtime, not build time?
>
> We can disable AFTR mode by default on EXYNOS4x12 SoCs with secure mode
> enabled and EXYNOS5420 SoCs (I would like somebody with the hardware to
> verify that AFTR mode is not working first so we have 100% certainty
> that we don't regress here).

Does 5420 even work upstream? I have hardware access but nothing that
will run an upstream kernel as far as I know. Maybe SLSI has an SMDK
they can help out with?


-Olof
