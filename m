From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Dec 2014 16:09:05 -0800
Subject: [PATCH v2 2/3] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
 start_signal_voltage_switch
In-Reply-To: <CAL1qeaHfsq1xOOBMQc58uSvV4unuEWHjqVpiZrpu2bQD36LbXg@mail.gmail.com>
References: <1418685929-13096-1-git-send-email-dianders@chromium.org>
 <1418685929-13096-2-git-send-email-dianders@chromium.org>
 <CAL1qeaHfsq1xOOBMQc58uSvV4unuEWHjqVpiZrpu2bQD36LbXg@mail.gmail.com>
Message-ID: <CAD=FV=XigXJWg1PiFzA20xXz-6VY=OGnGefJfvoVOiajq5Aicg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, Dec 15, 2014 at 3:44 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
>> -       if (!IS_ERR(mmc->supply.vqmmc)) {
>> -               ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
>> -
>> -               if (ret) {
>> -                       dev_dbg(&mmc->class_dev,
>> -                                        "Regulator set error %d: %d - %d\n",
>> -                                        ret, min_uv, max_uv);
>> -                       return ret;
>> -               }
>> -       }
>> +       mmc_regulator_set_vqmmc(mmc, ios);
>
> Shouldn't we check the return value here and bail out of the voltage
> switch procedure if it fails?

My thought was to purposely _not_ check the return value.  The comment
right above this says:

* Program the voltage.  Note that some instances of dw_mmc may use
* the UHS_REG for this.  For other instances (like exynos) the UHS_REG
* does no harm but you need to set the regulator directly.  Try both.

...I'm not 100% sure that I understand how the UHS_REG is supposed to
be implemented since I've never seen a system that uses it.  I was
assuming that if you have UHS_REG you don't need the regulator...

...but probably a better solution is to return the error if "
!IS_ERR(mmc->supply.vqmmc)".  Let me fix that up and repost.


-Doug
