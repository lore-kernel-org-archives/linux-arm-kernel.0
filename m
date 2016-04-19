From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Apr 2016 16:32:38 +0100
Subject: [PATCH V2 06/15] coresight: tmc: making prepare/unprepare
 functions generic
In-Reply-To: <CANLsYkzizZtY=Mvh-Ko619Rc5GRCj1VVxracKgWVhNx=jFwqBw@mail.gmail.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-7-git-send-email-mathieu.poirier@linaro.org>
 <571624FF.1040404@arm.com>
 <CANLsYkzizZtY=Mvh-Ko619Rc5GRCj1VVxracKgWVhNx=jFwqBw@mail.gmail.com>
Message-ID: <57164F96.7000909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 16:22, Mathieu Poirier wrote:
> On 19 April 2016 at 06:30, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 12/04/16 18:54, Mathieu Poirier wrote:
>>>
>>> Dealing with HW related matters in tmc_read_prepare/unprepare
>>> becomes convoluted when many cases need to be handled distinctively.
>>>
>>> As such moving processing related to HW setup to individual driver
>>> files and keep the core driver generic.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-tmc-etf.c | 62
>>> ++++++++++++++++++++++++-
>>>    drivers/hwtracing/coresight/coresight-tmc-etr.c | 42 ++++++++++++++++-
>>>    drivers/hwtracing/coresight/coresight-tmc.c     | 55
>>> +++++-----------------
>>>    drivers/hwtracing/coresight/coresight-tmc.h     |  8 ++--
>>>    4 files changed, 117 insertions(+), 50 deletions(-)
>>>
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 910d6f3b7d26..495540e9064d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -70,7 +70,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
>>>                  drvdata->buf = drvdata->vaddr;
>>>    }
>>>
>>> -void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>>> +static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>>>    {
>>>          CS_UNLOCK(drvdata->base);
>>>
>>> @@ -126,3 +126,43 @@ static const struct coresight_ops_sink
>>> tmc_etr_sink_ops = {
>>>    const struct coresight_ops tmc_etr_cs_ops = {
>>>          .sink_ops       = &tmc_etr_sink_ops,
>>>    };
>>> +
>>> +int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>>> +{
>>> +       unsigned long flags;
>>> +
>>> +       /* config types are set a boot time and never change */
>>> +       if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
>>> +               return -EINVAL;
>>
>>
>> ...
>>
>>> +
>>> +int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>>> +{
>>> +       unsigned long flags;
>>> +
>>> +       /* config types are set a boot time and never change */
>>> +       if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
>>> +               return -EINVAL;
>>> +
>>
>>
>> For both cases above should we WARN_ON_ONCE() if we encounter such a case ?
>
> WARN_ON_ONCE() would also be valid, albeit very blunt.  Those
> functions are user space triggered and returning -EINVAL will stop
> everything - the end result is the same.  I suppose that on such
> condition fighting back with a backtrace will force people to pay
> attention or report the problem.

We do necessary checks to route the caller here, so we shouldn't really
hit the condition with the tmc_read_prepare(). So WARN_ON_ONCE() might be a
good check to make sure we don't hit it from say, perf driver or something
really went bad under the hood (corrupted ?). I am not too particular about it.

Suzuki
