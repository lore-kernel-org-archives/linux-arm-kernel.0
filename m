From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 17:27:28 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1888740.dKYctKO5at@linux-5eaq.site>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <21763864.rYYOf1P6VP@linux-5eaq.site>
 <CACVXFVNgzb=VVf9PY_sAHXPtXnqFVXbnB_L4i4xvK0dN1-8T2A@mail.gmail.com>
 <1888740.dKYctKO5at@linux-5eaq.site>
Message-ID: <CACVXFVMxAddaHdjfi2rOOEW46-XA3KozULjFtLvEpo-MZC7+Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 4:49 PM, Oliver Neukum <oliver@neukum.org> wrote:
> On Tuesday 11 June 2013 16:14:25 Ming Lei wrote:
>> On Tue, Jun 11, 2013 at 3:18 PM, Oliver Neukum <oliver@neukum.org> wrote:
>> > On Tuesday 11 June 2013 13:40:20 Ming Lei wrote:
>> >> On Tue, Jun 11, 2013 at 1:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >> > On Mon, 10 Jun 2013, Ming Lei wrote:
>> >
>> >> If complete() callback runs in one tasklet context, spin_lock() inside
>> >> complete() is enough, just like hard irq, the tasklet itself is disabled
>> >> during complete(), if the percpu tasklet is converted to single tasklet.
>> >> So no problem when the lock is to protect shared resources between
>> >> complete().
>> >
>> > We also have exclusion between complete() and other contexts, i.e. timers.
>>
>> The patch also converts the complete() called in timers to tasklet context too.
>>
>> So could you let me know if that eases your concern? If not, could you explain
>> your concern about other contexts in a bit detail?
>
> The driver itself may have submitted a timer and race against it.
> What locking do you need in complete() and a timer to lock against
> each other?

Good catch.

The problem will come if only spin_lock() is called inside complete(),
I will check main USB drivers in tree to see if there is such use case.

>
>> > Even now we cannot guarantee that all calls to complete() are in irq.
>> > There is the case of HCD hotunplug and other cases, like timeouts.
>> > They will have to be verified.
>>
>> All URBs are completed via usb_hcd_giveback_urb(), so there should
>> be no differences between these cases and the common one about
>> introducing the patchset.
>
> But it makes no sense to go to a tasklet when you are already in task context.
> In those cases you need to do something, essentially blocking the tasklet.

At least now, always doing complete() in tasklet handler can simplify
implementation since these cases aren't in hot path.

Thanks,
--
Ming Lei
