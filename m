From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 10 Jun 2013 14:05:43 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306091136450.13202-100000@netrider.rowland.org>
References: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306091136450.13202-100000@netrider.rowland.org>
Message-ID: <CACVXFVOrniwAUaJN1dkUZD4HzfV6StajzL3Okw2dNBpkSPRjNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 11:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 9 Jun 2013, Ming Lei wrote:
>
>> Hi,
>>
>> The patchset supports to run giveback of URB in tasklet context, so that
>> DMA unmapping/mapping on transfer buffer and compelte() callback can be
>> run with interrupt enabled, then time of HCD interrupt handler can be
>> saved much. Also this approach may simplify HCD since HCD lock needn't
>> be released any more before calling usb_hcd_giveback_urb().
>
> That's a lot of material.  However, you haven't specifically said
> _what_ you want to accomplish.  It sounds like you're trying to

All IRQs are disabled(locally) in hard interrupt context, but they are
enabled in softirq context, this patchset can decrease the time a lot.

> minimize the amount of time spent in hardirq context, but I can't be
> sure that is really what you want.
>
> If it is, this is not a good way to do it.  A better way to minimize
> the time spent in hardirq context is to use a threaded interrupt
> handler.  But why do you want to minimize this time in the first place?

Process context switch may have more cost than switching to softirq,
then USB performance may be effected, that is why I choose to use
tasklet.  Also now there is no any sleep in URB giveback, so it isn't
necessary to introduce process to handle the giveback or completion.

> The CPU will be still have to use at least as much time as before; the
> only difference is that it will be in softirq or in a high-priority
> thread instead of in hardirq.

Yes, as I said above, but we can allow other IRQs to be served in
handling URB giveback in softirq context, that is the value of softirq/tasklet.
Of course, system may have more important things to do during the time.
Generally speaking, for one driver, hard interrupt handler should always
consume less time as possible.

>
> Also, I don't see how you can avoid releasing the HCD's private lock
> before calling usb_hcd_giveback_urb().  When the completion handler

Please see patch 1/4, :-)

> tries to resubmit the URB, the HCD's enqueue routine will try to
> reacquire the private lock.  If it didn't release the lock earlier, it

Yes, but with the patchset, resubmitting is called in taskelet context,
instead of hardirq context, so there isn't any recursion any more.


Thanks,
--
Ming Lei
