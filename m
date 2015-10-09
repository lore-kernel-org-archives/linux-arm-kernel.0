From: dianders@chromium.org (Doug Anderson)
Date: Fri, 9 Oct 2015 13:11:21 -0700
Subject: [PATCH v2 0/8] mmc: dw_mmc-rockchip: allow tuning using the
 clk-phase api
In-Reply-To: <CAD=FV=XdVt5Uop5WAUv6vY3=qPksnc9HzR4C9CBWpXJKuteTEQ@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <CAPDyKFqeo--AiW_zHHrSqoOdFNZ3J_FgJpz2L7Z8gZnNmQZSig@mail.gmail.com>
 <CAPDyKFr6WV-o8Td9eJVkuCgaeNjdLr2GpaC32c3026bFmOJiYQ@mail.gmail.com>
 <CAD=FV=XdVt5Uop5WAUv6vY3=qPksnc9HzR4C9CBWpXJKuteTEQ@mail.gmail.com>
Message-ID: <CAD=FV=VaZQcbgByQOAQL4qDCCOb_pNRHnXBS77L8D-dc_eYR5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 9, 2015 at 10:19 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Fri, Oct 9, 2015 at 1:10 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Dough, Heiko,
>>
>> This patchset seems to be causing a boot regression for exynos5800-peach-pi [1].
>>
>> Apparently, the vmmc regulator doesn't exist for one of the controller
>> but vqmmc is. This leads to the following NULL pointer exception.
>
> Ugh.  Hrm, it didn't used to be possible for vmmc to be NULL.  :-/  It
> changed in v3.16:
>
>   4d1f52f mmc: core: Improve support for deferred regulators
>
> ...and I didn't notice it (most of my development is done on 3.14).  :(
>
>
> Is it sensible to have vqmmc without vmmc.  One option would be to
> change mmc_regulator_get_supply() to not even bother trying to get
> vqmmc if vmmc is not there.
>
> Another option would be to just totally fail mmc_regulator_set_vqmmc()
> always if vmmc is an error.  ...or assume that any bogus vmmc (either
> vmmc is an error or regulator_get_voltage(vmmc) returns an error) is
> 3.3V?
>
>
> I guess the safest is to assume that bogus vmmc means 3.3V...

Ah, doh.  Just noticed Ulf's suggestion all the way at the bottom of
the crash info, which I somehow missed before.  Yes, let's do that.
Heiko: are you going to re-post?

-Doug
