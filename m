From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 09:45:46 -0600
Subject: [PATCH V2 09/15] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <57163075.5030107@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-10-git-send-email-mathieu.poirier@linaro.org>
 <57163075.5030107@arm.com>
Message-ID: <CANLsYkyOG2OofP=XxDjJzjv74RO-75O_rXWJjhUeOQ-e8wFjPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 07:19, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> Moving tmc_drvdata::enable to a local_t mode.  That way the
>> sink interface is aware of it's orgin and the foundation for
>> mutual exclusion between the sysFS and Perf interface can be
>> laid out.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 28
>> ++++++++++++++++++-------
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 24
>> ++++++++++++++++-----
>>   drivers/hwtracing/coresight/coresight-tmc.h     |  4 ++--
>>   3 files changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 7cb287ef7b9e..5908000e1ae0 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -110,6 +110,7 @@ static int tmc_enable_etf_sink(struct coresight_device
>> *csdev, u32 mode)
>>   {
>>         bool allocated = false;
>>         char *buf = NULL;
>> +       u32 val;
>>         unsigned long flags;
>>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> @@ -146,6 +147,15 @@ fast_path:
>>                 return -EBUSY;
>>         }
>>
>> +       val = local_xchg(&drvdata->mode, mode);
>> +       /*
>> +        * In sysFS mode we can have multiple writers per sink.  Since
>> this
>> +        * sink is already enabled no memory is needed and the HW need not
>> be
>> +        * touched.
>> +        */
>> +       if (val == CS_MODE_SYSFS)
>> +               goto out;
>> +
>
>
> We are not dropping the spinlock in this case. Are we ?

Definitely - thanks for pointing that out.

>
>>         /*
>>          * If drvdata::buf isn't NULL, memory was allocated for a previous
>>          * trace run but wasn't read.  If so simply zero-out the memory.
>> @@ -163,9 +173,9 @@ fast_path:
>>         }
>>
>>         tmc_etb_enable_hw(drvdata);
>> -       drvdata->enable = true;
>>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>
>> +out:
>>         /* Free memory outside the spinlock if need be */
>>         if (!allocated && buf)
>>                 kfree(buf);
>
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 6022ff26deba..8e6fe267195a 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -85,6 +85,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata
>> *drvdata)
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>>   {
>>         bool allocated = false;
>> +       u32 val;
>>         unsigned long flags;
>>         void __iomem *vaddr = NULL;
>>         dma_addr_t paddr;
>> @@ -125,6 +126,15 @@ fast_path:
>>                 return -EBUSY;
>>         }
>>
>> +       val = local_xchg(&drvdata->mode, mode);
>> +       /*
>> +        * In sysFS mode we can have multiple writers per sink.  Since
>> this
>> +        * sink is already enabled no memory is needed and the HW need not
>> be
>> +        * touched.
>> +        */
>> +       if (val == CS_MODE_SYSFS)
>> +               goto out;
>> +
>
>
> Same as above, we should drop the locks in this case.
>
>> @@ -140,9 +150,9 @@ fast_path:
>>         memset(drvdata->vaddr, 0, drvdata->size);
>>
>>         tmc_etr_enable_hw(drvdata);
>> -       drvdata->enable = true;
>>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>
>> +out:
>>         /* Free memory outside the spinlock if need be */
>>         if (!allocated && vaddr)
>>                 dma_free_coherent(drvdata->dev, drvdata->size, vaddr,
>> paddr);
>> @@ -153,6 +163,7 @@ fast_path:
>
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h
>> b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 80096fa75326..821bdf150ac9 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -100,7 +100,7 @@ enum tmc_mem_intf_width {
>>    * @paddr:    DMA start location in RAM.
>>    * @vaddr:    virtual representation of @paddr.
>>    * @size:     @buf size.
>> - * @enable:    this TMC is being used.
>> + * @mode:      how this TMC is being used.
>>    * @config_type: TMC variant, must be of type @tmc_config_type.
>>    * @trigger_cntr: amount of words to store after a trigger.
>>    */
>> @@ -116,7 +116,7 @@ struct tmc_drvdata {
>>         dma_addr_t              paddr;
>>         void __iomem            *vaddr;
>>         u32                     size;
>> -       bool                    enable;
>> +       local_t                 mode;
>
>
> Since we always deal with the mode under the spinlock, do we really need
> this to
> be local_t ? Or do we plan to get rid of the lock ?

You are correct, using a local_t variable isn't strictly needed here.  But:

1) It greatly simplifies the code.
2) I'm really hoping one day we can do without the spinlocks, though I
don't know when that will happen.

Get back to me if you're resolute on switching the local_t to a normal type.

Mathieu

>
> Suzuki
>
