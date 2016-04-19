From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 09:39:39 -0600
Subject: [PATCH V2 07/15] coresight: tmc: allocating memory when needed
In-Reply-To: <57162AA6.3030605@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-8-git-send-email-mathieu.poirier@linaro.org>
 <57162AA6.3030605@arm.com>
Message-ID: <CANLsYkxREUEYi6zgaOp+c9sMLhK9nQEha9yu3cu7w-eqiTXheA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 06:55, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> In it's current form the TMC probe() function allocates
>> trace buffer memory at boot time, event if coresight isn't
>> used.  This is highly inefficient since trace buffers can
>> occupy a lot of memory that could be used otherwised.
>>
>> This patch allocates trace buffers on the fly, when the
>> coresight subsystem is solicited.  Allocated buffers are
>> released when traces are read using the device descriptors
>> under /dev.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 85
>> +++++++++++++++++++++++--
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 83
>> +++++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tmc.c     | 14 ----
>>   3 files changed, 163 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 4b8f39bd478b..7cb287ef7b9e 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -16,14 +16,12 @@
>>    */
>>
>>   #include <linux/coresight.h>
>> +#include <linux/slab.h>
>>   #include "coresight-priv.h"
>>   #include "coresight-tmc.h"
>>
>>   void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>>   {
>> -       /* Zero out the memory to help with debug */
>> -       memset(drvdata->buf, 0, drvdata->size);
>> -
>>         CS_UNLOCK(drvdata->base);
>>
>>         /* Wait for TMCSReady bit to be set */
>> @@ -110,19 +108,68 @@ static void tmc_etf_disable_hw(struct tmc_drvdata
>> *drvdata)
>>
>>   static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>>   {
>> +       bool allocated = false;
>
>
> nit: does "used" or buf_used sound more suitable than allocated ?
>
>> +       char *buf = NULL;
>>         unsigned long flags;
>>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> +        /* This shouldn't be happening */
>> +       WARN_ON(mode != CS_MODE_SYSFS);
>> +
>> +       /*
>> +        * If a buffer is already allocated *keep holding* the lock and
>> +        * jump to the fast path.  Otherwise release the lock and allocate
>> +        * memory to work with.
>> +        */
>>         spin_lock_irqsave(&drvdata->spinlock, flags);
>> +       if (drvdata->buf)
>> +               goto fast_path;
>> +
>> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +       /* Allocating the memory here while outside of the spinlock */
>> +       buf = kzalloc(drvdata->size, GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       /* Let's try again */
>> +       spin_lock_irqsave(&drvdata->spinlock, flags);
>> +fast_path:
>>         if (drvdata->reading) {
>>                 spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +               /*
>> +                * Free allocated memory outside of the spinlock.  There
>> is
>> +                * no need to assert the validity of 'buf' since calling
>> +                * kfree(NULL) is safe.
>> +                */
>> +               kfree(buf);
>>                 return -EBUSY;
>>         }
>
>
> We could check do the above check, before the allocation and avoid an
> unnecessary
> alloc/free() if we really don't need that. And may be its better to get rid
> of the
> "jump to fastpath" to avoid complicating the code, by using something like :
>
>         lock();
>         if (drvdata->reading) {
>                 rc = -EBUSY;
>                 goto unlock_out;
>         }
>
>         if (!drvdata->buf) {
>         /* Drop the lock here before allocation and retake the lock */
>                 unlock();
>                 alloc();
>                 lock();

Between the time the lock was released and taken again it is entirely
possible that drvdata->reading has been flipped to 'true', something
the original code does provision for.  When operating manually the
probabilities of something like this happening are infinitely small
but increase seriously when using scripts to control trace collection
and retrieval.

We could check for drvdata->reading again here but then our approach
become very similar.

Thanks,
Mathieu

>                 if (!buf) {
>                         rc = -ENOMEM;
>                         goto unlock_out;
>                 }
>         }
> ...
>
>> +
>>         tmc_etb_enable_hw(drvdata);
>>         drvdata->enable = true;
>
>
> unlock_out:
>
>>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>
>> +       /* Free memory outside the spinlock if need be */
>> +       if (!allocated && buf)
>> +               kfree(buf);
>> +
>
>
>
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 495540e9064d..6022ff26deba 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -16,6 +16,7 @@
>>    */
>>
>>   #include <linux/coresight.h>
>> +#include <linux/dma-mapping.h>
>>   #include "coresight-priv.h"
>>   #include "coresight-tmc.h"
>>
>> @@ -83,19 +84,69 @@ static void tmc_etr_disable_hw(struct tmc_drvdata
>> *drvdata)
>>
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>>   {
>
>
>> +
>> +       /*
>> +        * If a buffer is already allocated *keep holding* the lock and
>> +        * jump to the fast path.  Otherwise release the lock and allocate
>> +        * memory to work with.
>> +        */
>> +       spin_lock_irqsave(&drvdata->spinlock, flags);
>> +       if (drvdata->vaddr)
>> +               goto fast_path;
>> +
>> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +       /*
>> +        * Contiguous  memory can't be allocated while a spinlock is held.
>> +        * As such allocate memory here and free it if a buffer has
>> already
>> +        * been allocated (from a previous session).
>> +        */
>> +       vaddr = dma_alloc_coherent(drvdata->dev, drvdata->size,
>> +                                  &paddr, GFP_KERNEL);
>> +       if (!vaddr)
>> +               return -ENOMEM;
>> +
>> +       /* Let's try again */
>>         spin_lock_irqsave(&drvdata->spinlock, flags);
>> +fast_path:
>>         if (drvdata->reading) {
>>                 spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +               if (vaddr)
>> +                       dma_free_coherent(drvdata->dev, drvdata->size,
>> +                                         vaddr, paddr);
>>                 return -EBUSY;
>>         }
>
>
> Same as above, if you move the check above before allocation, we could avoid
> the alloc/free for such cases. And it would be better if simplify the code
> without
> using the fast_path label to the middle of the code.
>
> Otherwise, looks good.
>
> Thanks
> Suzuki
