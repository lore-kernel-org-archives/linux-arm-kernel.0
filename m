From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 20 Jun 2013 09:50:55 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <Pine.LNX.4.44L0.1306191134170.2026-100000@iolanthe.rowland.org>
References: <CACVXFVNV=hSGGsY3oyuFR3SAzj4fTNa7Mf3aYEn35KvbqQ7Orw@mail.gmail.com>
 <Pine.LNX.4.44L0.1306191134170.2026-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOMYA9e2qiJoFCx+v7=fSWpjwpha5hKdcxX+4s5qAT83w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 11:37 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 19 Jun 2013, Ming Lei wrote:
>
>> >> @@ -835,9 +839,11 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>> >>                       hcd->status_urb = NULL;
>> >>                       usb_hcd_unlink_urb_from_ep(hcd, urb);
>> >>
>> >> -                     spin_unlock(&hcd_root_hub_lock);
>> >> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> >> +                             spin_unlock(&hcd_root_hub_lock);
>> >>                       usb_hcd_giveback_urb(hcd, urb, status);
>> >> -                     spin_lock(&hcd_root_hub_lock);
>> >> +                     if (!hcd_giveback_urb_in_bh(hcd))
>> >> +                             spin_lock(&hcd_root_hub_lock);
>> >>               }
>> >>       }
>> >>   done:
>> >
>> > None of these tests are necessary.  Root hubs are different from normal
>> > devices; their URBs are handled mostly by usbcore.  The only part done
>> > by the HCD is always synchronous.  And we know that root-hub URBs
>>
>> Looks not always synchronous, control transfer is synchronous, and
>> interrupt transfer is still asynchronous. No drivers(hub, usbfs) depend
>> on that,  and IMO, treating root hub same as hub will simplify HCD core,
>> and finally we can remove all the above lock releasing & acquiring if
>> all HCDs set HCD_BH.
>>
>> Also there is very less roothub transfers and always letting tasklet
>> handle URB giveback of roothub won't have performance problem, so
>> how about keeping the above tests?
>
> If you want to use the tasklets for root-hub URBs, okay.  There's no
> reason to check the HCD_BH flag, though, because HCDs have only minimal
> involvement in root-hub URBs.  In particular, HCD's don't call
> usb_hcd_giveback_urb() for them.

Looks both root hub's control and interrupt transfer call usb_hcd_giveback_urb()
to complete URBs, don't they?

> So you can use the tasklets for _all_ root-hub URBs.  Then the tests
> above aren't necessary, and neither are the spinlock operations.

Yes, that is what I am going to do.

>
>> >> @@ -2573,6 +2687,16 @@ int usb_add_hcd(struct usb_hcd *hcd,
>> >>                       && device_can_wakeup(&hcd->self.root_hub->dev))
>> >>               dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
>> >>
>> >> +     if (usb_hcd_is_primary_hcd(hcd)) {
>> >> +             retval = init_giveback_urb_bh(hcd);
>> >> +             if (retval)
>> >> +                     goto err_init_giveback_bh;
>> >> +     } else {
>> >> +             /* share tasklet handling with primary hcd */
>> >> +             hcd->async_bh = hcd->primary_hcd->async_bh;
>> >> +             hcd->periodic_bh = hcd->primary_hcd->periodic_bh;
>> >> +     }
>> >
>> > Is there any reason why a secondary HCD can't have its own tasklets?
>>
>> I didn't do that because both primary and secondary HCDs share one
>> hard interrupt handler, so basically there is no obvious advantage to
>> do that.
>
> If the bh structures are embedded directly in the hcd structure, it
> won't be possible for a secondary hcd to share its tasklets with the
> primary hcd.  Not sharing seems simpler, and there's no obvious
> disadvantage either.

OK, I will let secondary HCD have its own tasklet in v2.

Thanks,
--
Ming Lei
