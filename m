From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 3 Nov 2017 14:17:26 -0600
Subject: [PATCH 13/17] coresight etr: Do not clean ETR trace buffer
In-Reply-To: <c7a89f16-3974-69aa-505f-a3395d0579e6@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-14-suzuki.poulose@arm.com>
 <20171102203623.GE23320@xps15>
 <c7a89f16-3974-69aa-505f-a3395d0579e6@arm.com>
Message-ID: <CANLsYkyEVqZ+Nc-RwWpNJ7TpxTdDFHF05-JsSSG65JYZhnoc6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2017 at 04:10, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 02/11/17 20:36, Mathieu Poirier wrote:
>>
>> On Thu, Oct 19, 2017 at 06:15:49PM +0100, Suzuki K Poulose wrote:
>>>
>>> We zero out the entire trace buffer used for ETR before it
>>> is enabled, for helping with debugging. Since we could be
>>> restoring a session in perf mode, this could destroy the data.
>>
>>
>> I'm not sure to follow you with "... restoring a session in perf mode
>> ...".
>> When operating from the perf interface all the memory allocated for a
>> session is
>> cleanup after, there is no re-using of memory as in sysFS.
>
>
> We could directly use the perf ring buffer for the ETR. In that case, the
> perf
> ring buffer could contain trace data collected from the previous "schedule"
> which the userspace hasn't collected yet. So, doing a memset here would
> destroy that data.

I originally thought your comment was about re-using the memory from a
previous trace session, hence the confusion.  Please rework your
changelog to include this clarification as I am sure other people can
be mislead.

>
> Cheers
> Suzuki
>
>>
>>> Get rid of this step, if someone wants to debug, they can always
>>> add it as and when needed.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 31353fc34b53..849684f85443 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -971,8 +971,6 @@ static void tmc_etr_enable_hw(struct tmc_drvdata
>>> *drvdata,
>>>                 return;
>>>         drvdata->etr_buf = etr_buf;
>>> -       /* Zero out the memory to help with debug */
>>> -       memset(etr_buf->vaddr, 0, etr_buf->size);
>>
>>
>> I agree, this can be costly when dealing with large areas of memory.
>>
>>>         CS_UNLOCK(drvdata->base);
>>>   @@ -1267,9 +1265,8 @@ int tmc_read_unprepare_etr(struct tmc_drvdata
>>> *drvdata)
>>>         if (drvdata->mode == CS_MODE_SYSFS) {
>>>                 /*
>>>                  * The trace run will continue with the same allocated
>>> trace
>>> -                * buffer. The trace buffer is cleared in
>>> tmc_etr_enable_hw(),
>>> -                * so we don't have to explicitly clear it. Also, since
>>> the
>>> -                * tracer is still enabled drvdata::buf can't be NULL.
>>> +                * buffer. Since the tracer is still enabled drvdata::buf
>>> can't
>>> +                * be NULL.
>>>                  */
>>>                 tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
>>>         } else {
>>> --
>>> 2.13.6
>>>
>
