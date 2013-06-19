From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 10:59:04 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <Pine.LNX.4.44L0.1306181139180.1157-100000@iolanthe.rowland.org>
References: <1371567833-9077-2-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181139180.1157-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVNV=hSGGsY3oyuFR3SAzj4fTNa7Mf3aYEn35KvbqQ7Orw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:05 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 18 Jun 2013, Ming Lei wrote:
>
>> This patch implements the mechanism of giveback of URB in
>> tasklet context, so that hardware interrupt handling time for
>> usb host controller can be saved much, and HCD interrupt handling
>> can be simplified.
>
> Okay.  I'd make a few relatively minor changes.
>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 014dc99..a272968 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -699,9 +699,11 @@ error:
>>        * Avoiding calls to local_irq_disable/enable makes the code
>>        * RT-friendly.
>>        */
>> -     spin_unlock(&hcd_root_hub_lock);
>> +     if (!hcd_giveback_urb_in_bh(hcd))
>> +             spin_unlock(&hcd_root_hub_lock);
>>       usb_hcd_giveback_urb(hcd, urb, status);
>> -     spin_lock(&hcd_root_hub_lock);
>> +     if (!hcd_giveback_urb_in_bh(hcd))
>> +             spin_lock(&hcd_root_hub_lock);
>>
>>       spin_unlock_irq(&hcd_root_hub_lock);
>>       return 0;
>> @@ -742,9 +744,11 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
>>                       memcpy(urb->transfer_buffer, buffer, length);
>>
>>                       usb_hcd_unlink_urb_from_ep(hcd, urb);
>> -                     spin_unlock(&hcd_root_hub_lock);
>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> +                             spin_unlock(&hcd_root_hub_lock);
>>                       usb_hcd_giveback_urb(hcd, urb, 0);
>> -                     spin_lock(&hcd_root_hub_lock);
>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> +                             spin_lock(&hcd_root_hub_lock);
>>               } else {
>>                       length = 0;
>>                       set_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
>> @@ -835,9 +839,11 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>                       hcd->status_urb = NULL;
>>                       usb_hcd_unlink_urb_from_ep(hcd, urb);
>>
>> -                     spin_unlock(&hcd_root_hub_lock);
>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> +                             spin_unlock(&hcd_root_hub_lock);
>>                       usb_hcd_giveback_urb(hcd, urb, status);
>> -                     spin_lock(&hcd_root_hub_lock);
>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> +                             spin_lock(&hcd_root_hub_lock);
>>               }
>>       }
>>   done:
>
> None of these tests are necessary.  Root hubs are different from normal
> devices; their URBs are handled mostly by usbcore.  The only part done
> by the HCD is always synchronous.  And we know that root-hub URBs

Looks not always synchronous, control transfer is synchronous, and
interrupt transfer is still asynchronous. No drivers(hub, usbfs) depend
on that,  and IMO, treating root hub same as hub will simplify HCD core,
and finally we can remove all the above lock releasing & acquiring if
all HCDs set HCD_BH.

Also there is very less roothub transfers and always letting tasklet
handle URB giveback of roothub won't have performance problem, so
how about keeping the above tests?

> always have a very short completion handler.  So we may as well

root hub's completion handler is same with hub's, and usb_submit_urb()
is still called to submit new schedule.

> continue to handle root-hub URBs the way we always have.



>
>> @@ -1648,6 +1654,60 @@ int usb_hcd_unlink_urb (struct urb *urb, int status)
>>
>>  /*-------------------------------------------------------------------------*/
>>
>> +static void __usb_hcd_giveback_urb(struct urb *urb)
>> +{
>> +     struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
>> +     int status = urb->status;
>> +
>> +     urb->hcpriv = NULL;
>> +     if (unlikely(urb->unlinked))
>> +             status = urb->unlinked;
>
> The way you're storing the status value isn't good.  We decided to make
> the status a separate argument because of drivers that abuse the
> urb->status field (they poll it instead of waiting for the completion
> handler to be called).  Hopefully there aren't any examples of drivers
> still doing this, but...
>
> This means you shouldn't store anything in urb->status until just
> before calling the completion handler.  What you can do instead is
> always store the status value in urb->unlinked.

Good point, will do it.

>
>> +     else if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
>> +                     urb->actual_length < urb->transfer_buffer_length &&
>> +                     !status))
>> +             status = -EREMOTEIO;
>> +
>> +     unmap_urb_for_dma(hcd, urb);
>> +     usbmon_urb_complete(&hcd->self, urb, status);
>> +     usb_unanchor_urb(urb);
>> +
>> +     /* pass ownership to the completion handler */
>> +     urb->status = status;
>> +     urb->complete (urb);
>
> You are supposed to disable local interrupts around the call to the
> completion handler.

I did it in the 2nd patch to highlight the change.

>
>> +     atomic_dec (&urb->use_count);
>> +     if (unlikely(atomic_read(&urb->reject)))
>> +             wake_up (&usb_kill_urb_queue);
>> +     usb_put_urb (urb);
>> +}
>> +
>> +static void usb_giveback_urb_bh(unsigned long param)
>> +{
>> +     struct giveback_urb_bh *bh = (struct giveback_urb_bh *)param;
>> +     unsigned long flags;
>> +     struct list_head local_list;
>> +
>> +     spin_lock_irqsave(&bh->lock, flags);
>> +     bh->running = 1;
>> +restart:
>
> I like to have statement labels indented by a single space character,
> so that tools like diff don't think the label marks the start of a new
> function.

OK.

>
>> @@ -1667,25 +1727,33 @@ int usb_hcd_unlink_urb (struct urb *urb, int status)
>>   */
>>  void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>>  {
>> -     urb->hcpriv = NULL;
>> -     if (unlikely(urb->unlinked))
>> -             status = urb->unlinked;
>> -     else if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
>> -                     urb->actual_length < urb->transfer_buffer_length &&
>> -                     !status))
>> -             status = -EREMOTEIO;
>> +     struct giveback_urb_bh *bh = hcd->async_bh;
>> +     bool async = 1;
>> +     bool sched = 1;
>
> I know this is a common way of doing things, but to me it makes more
> sense in this case to set these values later on, in an "if ... else
> ..." statement.

OK, it is fine for me too.

>
>>
>> -     unmap_urb_for_dma(hcd, urb);
>> -     usbmon_urb_complete(&hcd->self, urb, status);
>> -     usb_unanchor_urb(urb);
>> -
>> -     /* pass ownership to the completion handler */
>>       urb->status = status;
>
> This should now be:
>
>         if (urb->unlinked == 0)
>                 urb->unlinked = status;
>
>> -     urb->complete (urb);
>> -     atomic_dec (&urb->use_count);
>> -     if (unlikely(atomic_read(&urb->reject)))
>> -             wake_up (&usb_kill_urb_queue);
>> -     usb_put_urb (urb);
>> +     if (!hcd_giveback_urb_in_bh(hcd)) {
>> +             __usb_hcd_giveback_urb(urb);
>> +             return;
>> +     }
>> +
>> +     if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
>> +             bh = hcd->periodic_bh;
>> +             async = 0;
>
> I don't like these names, for several reasons.  The difference between
> the two tasklets isn't that one is meant specifically for periodic URBs
> and the other for async URBs; the difference is that one runs with
> higher priority than the other.  The names should reflect this.  For
> example, you could call them hcd->low_prio_bh and hcd->high_prio_bh.

Yes, that is also what I am wanting to do, but forget to change the name,
thanks for pointing it out.

>
>> +     }
>> +
>> +     spin_lock(&bh->lock);
>> +     list_add_tail(&urb->urb_list, &bh->head);
>> +     if (bh->running)
>> +             sched = 0;
>> +     spin_unlock(&bh->lock);
>> +
>> +     if (sched) {
>> +             if (async)
>> +                     tasklet_schedule(&bh->bh);
>> +             else
>> +                     tasklet_hi_schedule(&bh->bh);
>> +     }
>
>
> Also, you could combine async and sched into a single variable.
> Using an enumerated type for sched, this would become:
>
>         if (!sched)
>                 ;       /* tasklet doesn't need to be scheduled */
>         else if (sched == HIGH_PRIO)
>                 tasklet_hi_schedule(&bh->bh);
>         else
>                 tasklet_schedule(&bh->bh);

Looks fine.

>
> Or you could turn this into a "switch" statement.
>
>> +static int init_giveback_urb_bh(struct usb_hcd *hcd)
>> +{
>> +     if (!hcd_giveback_urb_in_bh(hcd))
>> +             return 0;
>> +
>> +     hcd->periodic_bh = kzalloc(sizeof(*hcd->periodic_bh), GFP_KERNEL);
>> +     if (!hcd->periodic_bh)
>> +             return -ENOMEM;
>> +
>> +     hcd->async_bh = kzalloc(sizeof(*hcd->async_bh), GFP_KERNEL);
>> +     if (!hcd->async_bh) {
>> +             kfree(hcd->periodic_bh);
>> +             return -ENOMEM;
>> +     }
>
> I think these things can be stored directly in the usb_hcd struct
> instead of allocated separately.

Yes, the allocation is just inherited from last percpu allocation, :-)

>
>> +
>> +     __init_giveback_urb_bh(hcd->periodic_bh);
>> +     __init_giveback_urb_bh(hcd->async_bh);
>> +
>> +     return 0;
>> +}
>> +
>> +static void __exit_giveback_urb_bh(struct giveback_urb_bh *bh)
>> +{
>> +     tasklet_kill(&bh->bh);
>> +}
>> +
>> +static void exit_giveback_urb_bh(struct usb_hcd *hcd)
>> +{
>> +     if (!hcd_giveback_urb_in_bh(hcd))
>> +             return;
>> +
>> +     __exit_giveback_urb_bh(hcd->periodic_bh);
>> +     __exit_giveback_urb_bh(hcd->async_bh);
>
> You might as well put the tasklet_kill() call directly inline instead
> of going through a separate function.

OK.

>
>> +
>> +     kfree(hcd->periodic_bh);
>> +     kfree(hcd->async_bh);
>> +}
>> +
>>  /**
>>   * usb_create_shared_hcd - create and initialize an HCD structure
>>   * @driver: HC driver that will use this hcd
>> @@ -2573,6 +2687,16 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>                       && device_can_wakeup(&hcd->self.root_hub->dev))
>>               dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
>>
>> +     if (usb_hcd_is_primary_hcd(hcd)) {
>> +             retval = init_giveback_urb_bh(hcd);
>> +             if (retval)
>> +                     goto err_init_giveback_bh;
>> +     } else {
>> +             /* share tasklet handling with primary hcd */
>> +             hcd->async_bh = hcd->primary_hcd->async_bh;
>> +             hcd->periodic_bh = hcd->primary_hcd->periodic_bh;
>> +     }
>
> Is there any reason why a secondary HCD can't have its own tasklets?

I didn't do that because both primary and secondary HCDs share one
hard interrupt handler, so basically there is no obvious advantage to
do that.

Thanks,
--
Ming Lei
