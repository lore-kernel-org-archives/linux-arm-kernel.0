From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 21 Feb 2013 23:45:08 +0100
Subject: [PATCH 01/35] mfd: ab8500-gpadc: Implemented suspend/resume
In-Reply-To: <20130220131912.GB13049@sirena.org.uk>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-2-git-send-email-lee.jones@linaro.org>
 <20130220131912.GB13049@sirena.org.uk>
Message-ID: <CAPDyKFo0MpP-d7v8v1zwB42sboR3MWT6nUmG=-L0_nayYRY7FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2013 14:19, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Feb 15, 2013 at 12:56:32PM +0000, Lee Jones wrote:
>
>> +static int ab8500_gpadc_suspend(struct device *dev)
>> +{
>> +     struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
>> +
>> +     mutex_lock(&gpadc->ab8500_gpadc_lock);
>> +
>> +     pm_runtime_get_sync(dev);
>> +
>> +     regulator_disable(gpadc->regu);
>> +     return 0;
>> +}
>
> This doesn't look especially sane...  You're doing a runtime get, taking
> the lock without releasing it and disabling the regulator.  This is
> *very* odd, both the changelog and the code need to explain what's going
> on and why it's safe in a lot more detail here.

You need to do pm_runtime_get_sync to be able to make sure resources
(which seems to be only the regulator) are safe to switch off. To my
understanding this is a generic way to use for being able to switch
off resources at a device suspend when runtime pm is used in
conjunction.

Regarding the mutex, I can't tell the reason behind it. It seems
strange but not sure.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Kind regards
Ulf Hansson
