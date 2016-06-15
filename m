From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 15 Jun 2016 09:52:37 +0200
Subject: [PATCH 10/10] i2c: designware-platdrv: Rework system PM support
In-Reply-To: <1465918516.30123.66.camel@linux.intel.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
 <1465918516.30123.66.camel@linux.intel.com>
Message-ID: <CAPDyKFow3QqMx_qCuSwBbL2rp2zfazyHWb0ez1nuM863b+=AKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2016 at 17:35, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>> The current code that deploys the system PM support relies on the
>> "direct_complete" feature supported by the PM core. The goal is to
>> avoid
>> performing unnecessary operations during the system PM sequence.
>>
>
>>
>>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>> -     .prepare = dw_i2c_plat_prepare,
>> -     .complete = dw_i2c_plat_complete,
>> -     SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend,
>> dw_i2c_plat_resume)
>> -     SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume,
>> NULL)
>> +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                             pm_runtime_force_resume)
>> +     SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
>> +                     dw_i2c_plat_runtime_resume,
>> +                     NULL)
>>  };
>
> UNIVERSAL_PM_OPS ?

The UNIVERSAL_DEV_PM_OPS assigns the same callbacks for system PM as
runtime PM, that doesn't work here.

Kind regards
Uffe
