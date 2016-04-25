From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 Apr 2016 08:24:08 -0600
Subject: [PATCH V3 09/18] coresight: tmc: allocating memory when needed
In-Reply-To: <571DEF5F.5060109@arm.com>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
 <1461345255-11758-10-git-send-email-mathieu.poirier@linaro.org>
 <571DEF5F.5060109@arm.com>
Message-ID: <CANLsYkz-thsYBod8KK=GqUfSc63a3k4tbc0-Ew0+hd+ZY8msgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2016 at 04:20, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 22/04/16 18:14, Mathieu Poirier wrote:
>>
>>   static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>>   {
>> +       bool used = false;
>> +       char *buf = NULL;
>>         unsigned long flags;
>>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> +        /* This shouldn't be happening */
>> +       if (WARN_ON(mode != CS_MODE_SYSFS))
>> +               return -EINVAL;
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
>
>
> nit: As I mentioned in the previous series, could we not avoid the goto in
> the middle of the
> function,by doing :
>
>         if (!drvdata->buf) {
>                 unlock();
>                 buf = alloc();
>                 if (!buf) return -ENOMEM;
>                 lock();
>         }
>

If we do not move the condition below (as per your comment in the
previous set), this will indeed make the code easier to
read/understand.

I will make the change.

>
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
> It would be good to unify the exit points as we do similar steps.
>         if (drvdata->reading) {
>                 rc = -EBUSY;
>                 goto out;
>         }
>>
>>
>> +       /*
>> +        * If drvdata::buf isn't NULL, memory was allocated for a previous
>> +        * trace run but wasn't read.  If so simply zero-out the memory.
>> +        * Otherwise use the memory allocated above.
>> +        *
>> +        * The memory is freed when users read the buffer using the
>> +        * /dev/xyz.{etf|etb} interface.  See tmc_read_unprepare_etf() for
>> +        * details.
>> +        */
>> +       if (drvdata->buf) {
>> +               memset(drvdata->buf, 0, drvdata->size);
>> +       } else {
>> +               used = true;
>> +               drvdata->buf = buf;
>> +       }
>> +
>>         tmc_etb_enable_hw(drvdata);
>>         drvdata->enable = true;
>
>
> out:
>
>>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>
>> +       /* Free memory outside the spinlock if need be */
>> +       if (!used && buf)
>> +               kfree(buf);
>> +
>
>         if (!rc)
>                 dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
>         return rc
>
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 3483d139a4ac..474c70c089f3 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>
>
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>>   {
>> +       bool used = false;
>>         unsigned long flags;
>> +       void __iomem *vaddr = NULL;
>> +       dma_addr_t paddr;
>>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> +        /* This shouldn't be happening */
>> +       if (WARN_ON(mode != CS_MODE_SYSFS))
>> +               return -EINVAL;
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
>
>
> nit: Same as above.
>
> I am not too particular about the above changes, but would be good to have
> them
> reader friendly.
>
> Either way,
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Suzuki
