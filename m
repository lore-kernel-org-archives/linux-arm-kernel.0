From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Apr 2016 16:49:35 +0100
Subject: [PATCH V2 09/15] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <CANLsYkyOG2OofP=XxDjJzjv74RO-75O_rXWJjhUeOQ-e8wFjPQ@mail.gmail.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-10-git-send-email-mathieu.poirier@linaro.org>
 <57163075.5030107@arm.com>
 <CANLsYkyOG2OofP=XxDjJzjv74RO-75O_rXWJjhUeOQ-e8wFjPQ@mail.gmail.com>
Message-ID: <5716538F.6040707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 16:45, Mathieu Poirier wrote:
> On 19 April 2016 at 07:19, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 12/04/16 18:54, Mathieu Poirier wrote:
>>>
>>> Moving tmc_drvdata::enable to a local_t mode.  That way the
>>> sink interface is aware of it's orgin and the foundation for
>>> mutual exclusion between the sysFS and Perf interface can be
>>> laid out.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-tmc-etf.c | 28
>>> ++++++++++++++++++-------
>>>    drivers/hwtracing/coresight/coresight-tmc-etr.c | 24
>>> ++++++++++++++++-----
>>>    drivers/hwtracing/coresight/coresight-tmc.h     |  4 ++--
>>>    3 files changed, 42 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> index 7cb287ef7b9e..5908000e1ae0 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> @@ -110,6 +110,7 @@ static int tmc_enable_etf_sink(struct coresight_device
>>> *csdev, u32 mode)
>>>    {
>>>          bool allocated = false;
>>>          char *buf = NULL;
>>> +       u32 val;
>>>          unsigned long flags;
>>>          struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>
>>> @@ -146,6 +147,15 @@ fast_path:
>>>                  return -EBUSY;
>>>          }
>>>
>>> +       val = local_xchg(&drvdata->mode, mode);
>>> +       /*
>>> +        * In sysFS mode we can have multiple writers per sink.  Since
>>> this
>>> +        * sink is already enabled no memory is needed and the HW need not
>>> be
>>> +        * touched.
>>> +        */
>>> +       if (val == CS_MODE_SYSFS)
>>> +               goto out;
>>> +
>>
>>
>> We are not dropping the spinlock in this case. Are we ?
>
> Definitely - thanks for pointing that out.
>
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h
>>> b/drivers/hwtracing/coresight/coresight-tmc.h
>>> index 80096fa75326..821bdf150ac9 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>>> @@ -100,7 +100,7 @@ enum tmc_mem_intf_width {
>>>     * @paddr:    DMA start location in RAM.
>>>     * @vaddr:    virtual representation of @paddr.
>>>     * @size:     @buf size.
>>> - * @enable:    this TMC is being used.
>>> + * @mode:      how this TMC is being used.
>>>     * @config_type: TMC variant, must be of type @tmc_config_type.
>>>     * @trigger_cntr: amount of words to store after a trigger.
>>>     */
>>> @@ -116,7 +116,7 @@ struct tmc_drvdata {
>>>          dma_addr_t              paddr;
>>>          void __iomem            *vaddr;
>>>          u32                     size;
>>> -       bool                    enable;
>>> +       local_t                 mode;
>>
>>
>> Since we always deal with the mode under the spinlock, do we really need
>> this to
>> be local_t ? Or do we plan to get rid of the lock ?
>
> You are correct, using a local_t variable isn't strictly needed here.  But:
>
> 1) It greatly simplifies the code.

+1

> 2) I'm really hoping one day we can do without the spinlocks, though I
> don't know when that will happen.
>
> Get back to me if you're resolute on switching the local_t to a normal type.

No, leave it as it is, as you said, it does simplify the code.
