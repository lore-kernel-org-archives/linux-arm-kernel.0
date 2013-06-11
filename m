From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 19:19:29 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <4881808.FBe1KpJCmT@linux-5eaq.site>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <1888740.dKYctKO5at@linux-5eaq.site>
 <CACVXFVMxAddaHdjfi2rOOEW46-XA3KozULjFtLvEpo-MZC7+Aw@mail.gmail.com>
 <4881808.FBe1KpJCmT@linux-5eaq.site>
Message-ID: <CACVXFVM_xse47F2Ti8-nvQbxYwK6YA2RUuzj1q6x6N+RGF1SqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 6:51 PM, Oliver Neukum <oliver@neukum.org> wrote:
> On Tuesday 11 June 2013 17:27:28 Ming Lei wrote:
>> On Tue, Jun 11, 2013 at 4:49 PM, Oliver Neukum <oliver@neukum.org> wrote:
>> > On Tuesday 11 June 2013 16:14:25 Ming Lei wrote:
>
>> > The driver itself may have submitted a timer and race against it.
>> > What locking do you need in complete() and a timer to lock against
>> > each other?
>>
>> Good catch.
>>
>> The problem will come if only spin_lock() is called inside complete(),
>> I will check main USB drivers in tree to see if there is such use case.
>
> All network drivers race against timeout. I think they just unlink the URB,
> but there's a lot of them.

usbnet is fine since no spin_lock() is used in complete() and the same lock
is acquired in timer handler.

As far as I think of, the problem only exists in the below situation:

complete():
     spin_lock(&A)
     ...
     spin_unlock(&A)

timer handler():
    spin_lock(&A)
     ....
    spin_unlock(&A)

And we need to replace spin_lock() in complete() with spin_lock_irqsave()
if the change is going to be introduced.

>
>> > But it makes no sense to go to a tasklet when you are already in task context.
>> > In those cases you need to do something, essentially blocking the tasklet.
>>
>> At least now, always doing complete() in tasklet handler can simplify
>> implementation since these cases aren't in hot path.
>
> Well, I am afraid this is not simply the case. These cases are partially
> synchronous. For example you need to make sure all calls to complete()
> are finished before you disconnect a HCD itself. The same applies to a device
> being disconnected.

That is fine since the coming giveback() in tasklet context will drop the URB's
reference count(urb->use_count) finally if the scheduled tasklet can't
be dropped.
(looks tasklet schedule can make sure that)

>
> It the same area, what happens if an URB is unlinked between the irq handler
> and the tasklet?

The unlink will return failure since the URB isn't in queue of ep->urb_list.

Thanks,
--
Ming Lei
