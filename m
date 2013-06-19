From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 11:02:43 +0800
Subject: [RFC PATCH v1 2/6] USB: disable IRQs deliberately when calling
 complete()
In-Reply-To: <Pine.LNX.4.44L0.1306181235460.1157-100000@iolanthe.rowland.org>
References: <1371567833-9077-3-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181235460.1157-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOYrAW48YFLesJDtwwqLj9aNzd5wm_LPUSFm3BS8NC3sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 18 Jun 2013, Ming Lei wrote:
>
>> We disable local IRQs here in case of running complete() by
>> tasklet to avoid possible deadlock because drivers may call
>> spin_lock() to hold lock which might be acquired in one hard
>> interrupt handler.
>>
>> The local_irq_save()/local_irq_restore() around complete()
>> will be removed if current USB drivers have been cleaned up
>> and no one may trigger the above deadlock situation when
>> running complete() in tasklet.
>
> This should be part of the first patch, not added on separately.

Yes, but I want to highlight the change since that will be removed
after drivers have been cleaned up.

>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index a272968..09a8263 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -1673,7 +1673,28 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>>
>>       /* pass ownership to the completion handler */
>>       urb->status = status;
>> -     urb->complete (urb);
>> +
>> +     /*
>> +      * We disable local IRQs here in case of running complete() by
>> +      * tasklet to avoid possible deadlock because drivers may call
>> +      * spin_lock() to hold lock which might be acquired in one hard
>> +      * interrupt handler.
>> +      *
>> +      * The local_irq_save()/local_irq_restore() around complete()
>> +      * will be removed if current USB drivers have been cleaned up
>> +      * and no one may trigger the above deadlock situation when
>> +      * running complete() in tasklet.
>> +      */
>> +     if (hcd_giveback_urb_in_bh(hcd)) {
>> +             unsigned long flags;
>> +
>> +             local_irq_save(flags);
>> +             urb->complete (urb);
>> +             local_irq_restore(flags);
>> +     } else {
>> +             urb->complete (urb);
>> +     }
>> +
>
> There's no reason to bother with the test.  You might as well always do
> the local_irq_save.

Looks fine.

Thanks,
--
Ming Lei
