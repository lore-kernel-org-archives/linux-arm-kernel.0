From: dianders@chromium.org (Doug Anderson)
Date: Fri, 9 Oct 2015 13:12:10 -0700
Subject: [PATCH v2 4/8] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
 start_signal_voltage_switch
In-Reply-To: <CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <1443622064-14362-5-git-send-email-heiko@sntech.de>
 <CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
Message-ID: <CAD=FV=XfoRoj610zXvBPxAwSO7O_eYGxsAidnEnXx5mK1ANGrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Fri, Oct 9, 2015 at 12:06 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Wed, Sep 30, 2015 at 4:07 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> From: Douglas Anderson <dianders@chromium.org>
>>
>> We've introduced a new helper in the MMC core:
>> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
>> helper has some advantages:
>>
>> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>>    compatibility.
>>
>> 2. We get rid of a few more warnings when probing unsupported
>>    voltages.
>>
>> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> kernelci.org found a new failure in linux-next on
> exynos5800-peach-pi[1] and it was bisected down to this patch, which
> has hit linux-next in the form of commit fba2e23128d0 (mmc: dw_mmc:
> Use mmc_regulator_set_vqmmc in start_signal_voltage_switch).  Based on
> a quick glance at the boot log[2], it looks to be a bad pointer
> dereference in regulator_get_voltage().
>
> I confirmed that reverting this patch on top of next-20151009 gets my
> peach-pi booting again.
>
> Note that the boot failure is only on exynos_defconfig, not multi_v7_defconfig.

Right.  See <http://www.spinics.net/lists/arm-kernel/msg450802.html>
for discussion.  Ulf responded to the cover letter rather than the
individual patch.

-Doug
