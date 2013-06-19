From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 19:50:02 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVNV=hSGGsY3oyuFR3SAzj4fTNa7Mf3aYEn35KvbqQ7Orw@mail.gmail.com>
References: <1371567833-9077-2-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181139180.1157-100000@iolanthe.rowland.org>
 <CACVXFVNV=hSGGsY3oyuFR3SAzj4fTNa7Mf3aYEn35KvbqQ7Orw@mail.gmail.com>
Message-ID: <CACVXFVMp+1MdW5MQ-gcjDKRTW9G2QfH+NmzEpZ5J3xYh4FhpzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 10:59 AM, Ming Lei <ming.lei@canonical.com> wrote:
> On Wed, Jun 19, 2013 at 12:05 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Tue, 18 Jun 2013, Ming Lei wrote:
>>
>>> This patch implements the mechanism of giveback of URB in
>>> tasklet context, so that hardware interrupt handling time for
>>> usb host controller can be saved much, and HCD interrupt handling
>>> can be simplified.
>>
>> Okay.  I'd make a few relatively minor changes.
>>
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index 014dc99..a272968 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>>> @@ -699,9 +699,11 @@ error:
>>>        * Avoiding calls to local_irq_disable/enable makes the code
>>>        * RT-friendly.
>>>        */
>>> -     spin_unlock(&hcd_root_hub_lock);
>>> +     if (!hcd_giveback_urb_in_bh(hcd))
>>> +             spin_unlock(&hcd_root_hub_lock);
>>>       usb_hcd_giveback_urb(hcd, urb, status);
>>> -     spin_lock(&hcd_root_hub_lock);
>>> +     if (!hcd_giveback_urb_in_bh(hcd))
>>> +             spin_lock(&hcd_root_hub_lock);
>>>
>>>       spin_unlock_irq(&hcd_root_hub_lock);
>>>       return 0;
>>> @@ -742,9 +744,11 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
>>>                       memcpy(urb->transfer_buffer, buffer, length);
>>>
>>>                       usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> -                     spin_unlock(&hcd_root_hub_lock);
>>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>>> +                             spin_unlock(&hcd_root_hub_lock);
>>>                       usb_hcd_giveback_urb(hcd, urb, 0);
>>> -                     spin_lock(&hcd_root_hub_lock);
>>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>>> +                             spin_lock(&hcd_root_hub_lock);
>>>               } else {
>>>                       length = 0;
>>>                       set_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
>>> @@ -835,9 +839,11 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>                       hcd->status_urb = NULL;
>>>                       usb_hcd_unlink_urb_from_ep(hcd, urb);
>>>
>>> -                     spin_unlock(&hcd_root_hub_lock);
>>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>>> +                             spin_unlock(&hcd_root_hub_lock);
>>>                       usb_hcd_giveback_urb(hcd, urb, status);
>>> -                     spin_lock(&hcd_root_hub_lock);
>>> +                     if (!hcd_giveback_urb_in_bh(hcd))
>>> +                             spin_lock(&hcd_root_hub_lock);
>>>               }
>>>       }
>>>   done:
>>
>> None of these tests are necessary.  Root hubs are different from normal
>> devices; their URBs are handled mostly by usbcore.  The only part done
>> by the HCD is always synchronous.  And we know that root-hub URBs
>
> Looks not always synchronous, control transfer is synchronous, and
> interrupt transfer is still asynchronous. No drivers(hub, usbfs) depend
> on that,  and IMO, treating root hub same as hub will simplify HCD core,
> and finally we can remove all the above lock releasing & acquiring if
> all HCDs set HCD_BH.

Actually, we can remove the above releasing and acquiring lock
unconditionally now.

>
> Also there is very less roothub transfers and always letting tasklet
> handle URB giveback of roothub won't have performance problem, so
> how about keeping the above tests?

thanks,
--
Ming Lei
