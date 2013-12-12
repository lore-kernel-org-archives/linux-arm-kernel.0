From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 12 Dec 2013 10:06:36 +0530
Subject: [PATCH 1/5] clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag
 for the sysreg clock
In-Reply-To: <CAD=FV=XG+5n+SW_bDiFtQB7ieViAxVAO5E12+y-DgY34maT6DQ@mail.gmail.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
 <1386763029-8516-2-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=WK-zgcNvF6qtnsRky3RbEvBOW+1uNiUR-fyp2257gPPw@mail.gmail.com>
 <CA+Ln22EQnpLfjcCOAY7U-tpc--XFy=dnwUr7K577x_ker4KuHw@mail.gmail.com>
 <CAD=FV=XG+5n+SW_bDiFtQB7ieViAxVAO5E12+y-DgY34maT6DQ@mail.gmail.com>
Message-ID: <CAM4voanSSqqAzRqrNrRc+HYh4vtq3zgNeGQYCVG6sE6nB_eWGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz and Doug,

Thanks for the review.
On Thu, Dec 12, 2013 at 6:00 AM, Doug Anderson <dianders@chromium.org> wrote:
> Tomasz,
>
> On Wed, Dec 11, 2013 at 4:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> 2013/12/12 Doug Anderson <dianders@chromium.org>:
>>> This does match what's done in exynos4 and exynos5420 and it's not
>>> terrible.  I'm always a fan of actually specifying clocks properly and
>>> that's more possible now using the syscon stuff (see Leela Krishna's
>>> watchdog patches).  You'd have to extend that to add a clock, but that
>>> wouldn't be too hard.
>>
>> Leela's patches are about PMU, not sysreg, but that's not an issue, I guess,
>> as it's about adding a clock to the generic syscon driver.
>
> Right.  I was proposing doing something similar to his, but for the
> separate "sysreg" address range.  ...then adding a clock to the
> generic syscon driver.
>
> I _think_ the syscon clock doesn't really need to be always on--it
> only needs to be on during the access of these registers, right?  I
> make this statement based on the fact that exynos5250 boards currently
> bootup and are very functional, but this clock is currently off.
I see USB2 currently using sysreg at boot-up, so I would assume that
it would fail if we have this clock turned off by the firmware. Have
not tested yet.
>
>
>> Still, I discussed about such cases as this with Sylwester a bit today and
>> maybe a bit different approach would be better. There is a number of clocks
>> that need to be always on, such as PMU (but also a lot of currently undefined
>> ones). IMHO it would be nice to make sure they are enabled at boot time
>> and do one of following:
>> 1) claim and enable them directly from the clock controller driver
>> 2) define them with CLK_IGNORE_UNUSED flag and enable them directly from
>>    the clock controller driver (without increasing the refcount, so users could
>>    possibly disable them later),
>> 3) add a generic flag, such as CLK_BOOT_ENABLE (or something), that would
>>    make the CCF enable such clock at bootup (in addition to implying
>>    CLK_IGNORE_UNUSED).
>>
>> For me, the most sensible option would be 2) as it doesn't bloat the CCF with
>> yet another flag and doesn't encourage people to leave clocks always on
>> just because of laziness stopping them from implementing proper clock
>> support in drivers.
>
> Right, we're using #2 for this now, but one problem is that it's
> possible that the firmware may turn off one of these misc-type clocks.
>  On exynos5250-snow we ran into this.  The firmware actually gates the
> clock needed for accessing the chip_id, though perhaps that's not one
> of the clocks that needs to be on all the time.

Yes, If the firmware gates sysreg then we should see failures at
boot-up or later.
Is this patch OK for now ? How would you guys like me to proceed on this ?
>
> -Doug

Regards,
Abhilash
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
