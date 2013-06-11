From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 16:14:25 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <21763864.rYYOf1P6VP@linux-5eaq.site>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
 <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
 <21763864.rYYOf1P6VP@linux-5eaq.site>
Message-ID: <CACVXFVNgzb=VVf9PY_sAHXPtXnqFVXbnB_L4i4xvK0dN1-8T2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 3:18 PM, Oliver Neukum <oliver@neukum.org> wrote:
> On Tuesday 11 June 2013 13:40:20 Ming Lei wrote:
>> On Tue, Jun 11, 2013 at 1:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Mon, 10 Jun 2013, Ming Lei wrote:
>
>> If complete() callback runs in one tasklet context, spin_lock() inside
>> complete() is enough, just like hard irq, the tasklet itself is disabled
>> during complete(), if the percpu tasklet is converted to single tasklet.
>> So no problem when the lock is to protect shared resources between
>> complete().
>
> We also have exclusion between complete() and other contexts, i.e. timers.

The patch also converts the complete() called in timers to tasklet context too.

So could you let me know if that eases your concern? If not, could you explain
your concern about other contexts in a bit detail?

>
>> When the lock is to protect shared resources between complete() and
>> non-IRQ context, currently spin_lock_irqsave() is used in non-IRQ
>> context, which is enough to prevent tasklet from being run on the CPU,
>> so no problem for this situation too.
>>
>> When all HCDs support to run URB giveback in tasklet context, we can
>> change all spin_lock_irq*() to spin_lock() in drivers URB->complete(), and
>> in other places, the spin_lock_irq*() can be changed to spin_lock_bh().
>
> Even now we cannot guarantee that all calls to complete() are in irq.
> There is the case of HCD hotunplug and other cases, like timeouts.
> They will have to be verified.

All URBs are completed via usb_hcd_giveback_urb(), so there should
be no differences between these cases and the common one about
introducing the patchset.

Thanks,
--
Ming Lei
