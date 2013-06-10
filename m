From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 10 Jun 2013 17:10:56 +0800
Subject: [RFC PATCH 2/4] USB: EHCI: don't release ehci->lock if URB
 giveback in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306091158480.13202-100000@netrider.rowland.org>
References: <1370791112-18464-3-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306091158480.13202-100000@netrider.rowland.org>
Message-ID: <CACVXFVPxyw4uQQis6owm_cwuJ5F0=TnPaDTrMj8ZUrWoDBGRxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:06 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 9 Jun 2013, Ming Lei wrote:
>
>> If HCD_BH is set for HC driver's flags, URB giveback will be
>> done in tasklet context instead of interrupt context, so the
>> ehci->lock needn't to be released any more before calling
>> usb_hcd_giveback_urb().
>
> Ah, this is the reason why you don't need to release the private lock.
> I'm not sure that this will save much time overall.

I did't mention this 3/4 patch can save much time. In fact, without this
patch, handling URB giveback still can work. But releasing the
private lock can make hard irq handler become random long,
since reacquiring the lock may busy wait quite a while until other
CPUs released the lock.

>
> With the existing code, the main reason for lock contention would be if
> (for example) CPU 2 submitted or cancelled an URB while the giveback
> was occurring on CPU 1.  Then CPU 1 would be forced to wait while CPU 2
> finished its submission or cancellation.
>
> With this patch, it's the other way around.  CPU 2 would be forced to
> wait while CPU 1 does all the rest of the work in its interrupt
> handler.  The total time spent holding the lock will be the same; it
> will just be distributed differently among the CPUs.  Hence it is not
> at all clear that this change will save any time.

Generally the interrupt handler without URB giveback consumes not
much time, and the time consumed is about 10~20us on fast machine,
and <40us on slow machine averagely per my tests in 4/4 commit log.

You may ague the situation would become worse if there are many
URBs to be handled in ehci_irq() on CPU1, but I think it should be
very very rare to happen attributed to this patchset: HCD hard interrupt
handler takes much less time than general HCD irq interval(for example,
in EHCI, generally there won't have many URBs to be completed in one
uFrame, and the URBs completed in next uFrame will interrupt CPUs
125us later)

Also we may introduce another lock/flags to let CPU1 handle CPU2's
interrupts and let CPU2 return IRQ_HANDLED immediately, but I am
not sure if it is necessary.

Thanks,
--
Ming Lei
