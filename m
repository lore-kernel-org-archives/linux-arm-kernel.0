From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Apr 2016 15:49:04 +0100
Subject: [PATCH V3 12/18] coresight: tmc: dump system memory content only
 when needed
In-Reply-To: <CANLsYky_TK9PkwSPnQzmaV5Y0fD0jQvRS2FgTB9b6Om8TDfWXQ@mail.gmail.com>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
 <1461345255-11758-13-git-send-email-mathieu.poirier@linaro.org>
 <571DFC95.10006@arm.com>
 <CANLsYky_TK9PkwSPnQzmaV5Y0fD0jQvRS2FgTB9b6Om8TDfWXQ@mail.gmail.com>
Message-ID: <571E2E60.50207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 15:38, Mathieu Poirier wrote:
> On 25 April 2016 at 05:16, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 22/04/16 18:14, Mathieu Poirier wrote:
>>>
>>> Calling tmc_etf/etr_dump_hw() is required only when operating from
>>> sysFS.  When working from Perf, the system memory is harvested
>>> from the AUX trace API.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-tmc-etf.c | 7 ++++++-
>>>    drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++++++-
>>>    2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> index d090a9745c73..25fad93b68d4 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> @@ -74,7 +74,12 @@ static void tmc_etb_disable_hw(struct tmc_drvdata
>>> *drvdata)
>>>          CS_UNLOCK(drvdata->base);
>>>
>>>          tmc_flush_and_stop(drvdata);
>>> -       tmc_etb_dump_hw(drvdata);
>>> +       /*
>>> +        * When operating in sysFS mode the content of the buffer needs to
>>> be
>>> +        * read before the TMC is disabled.
>>> +        */
>>> +       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>>> +               tmc_etb_dump_hw(drvdata);
>>>          tmc_disable_hw(drvdata);
>>>
>>>          CS_LOCK(drvdata->base);
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 8bbbf3ab1387..4b000f4003a2 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -76,7 +76,12 @@ static void tmc_etr_disable_hw(struct tmc_drvdata
>>> *drvdata)
>>>          CS_UNLOCK(drvdata->base);
>>>
>>>          tmc_flush_and_stop(drvdata);
>>> -       tmc_etr_dump_hw(drvdata);
>>> +       /*
>>> +        * When operating in sysFS mode the content of the buffer needs to
>>> be
>>> +        * read before the TMC is disabled.
>>> +        */
>>> +       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>>> +               tmc_etr_dump_hw(drvdata);
>>>          tmc_disable_hw(drvdata);
>>
>>
>> Nit: It would be cleaner if tmc_etX_disable_hw accepted a bool parameter to
>> decide
>> whether to dump the hw data or not. That way, the callers can make the
>> decision,
>> leaving the disable_hw code unaware of the mode checks.
>
> My goal in pushing the functionality to tmc_etX_disable_hw() was to
> especially keep the the higher layers unaware of sink buffer
> management specifics.  There is two ways to look at this and we simply
> landed on different sides of the fence.  I'm not strongly opinionated
> on this, I'll modify if you're really keen on this.

I am not, you can retain as it is.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
