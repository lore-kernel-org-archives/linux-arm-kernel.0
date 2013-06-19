From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 11:36:31 +0800
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <Pine.LNX.4.44L0.1306181246140.1157-100000@iolanthe.rowland.org>
References: <1371567833-9077-6-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181246140.1157-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOMDbWRWErkF5iDqtsJVBwD4B4fn22ZR1vupb78bKoDiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:51 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 18 Jun 2013, Ming Lei wrote:
>
>> Given interrupt URB will be resubmitted from tasklet context which
>> is scheduled by ehci hardware interrupt handler, and commonly only
>> one interrupt URB is scheduled on qh, so the qh may be unlinked
>> immediately once qh_completions() returns from ehci_irq(), then
>> the intr URB to be resubmitted in complete() can only be scheduled
>> and linked to hardware until the qh unlink is completed.
>>
>> This patch applied the QH_STATE_UNLINK_WAIT(not used by interrupt qh)
>> state to improve this above situation, and the qh will wait for 5
>> milliseconds before being unlinked from hardware, if one URB is submitted
>> during the period, the qh is move out of unlink wait state and the
>> interrupt transfer can be scheduled immediately, not like before: the
>> transfer is only linked to hardware until previous unlink is completed.
>>
>> Only enable the improvement in case that HCD supports to run
>> giveback of URB in tasklet context.
>
> The approach used in this patch is wrong.  You shouldn't start the
> unlink, then wait, then finish the unlink.  Consider what would happen

What you mentioned above is just what the patch is doing, :-)

start_unlink_intr() only sets the qh as QH_STATE_UNLINK_WAIT, puts
the qh into one wait list and starts a timer, if it is expired the qh will be
started to unlink, otherwise the qh can be recovered to QH_STATE_LINKED
immediately if there is one URB submitted.

So unlinking intr qh becomes a 3-stage process:

       - wait(qh return to linked state if URB is submitted during the period,
                  otherwise go to start unlink)
       - start unlink(do unlink, and wait for end of unlink)
       - end unlink

> if an URB were submitted during the delay: It would have to wait until

If an URB were submitted during the delay, the previous wait is canceled
immediately, and the qh state is recovered to linked state, please see
cancel_unlink_wait_intr() called in intr_submit().

> the QH was completely unlinked.  Instead, you should wait first, then
> do the entire unlink.

Yes, it is just what the patch is doing, :-)

>
> For example, scan_async() in ehci-q.c doesn't immediately begin to
> unlink empty async QHs.  It merely marks them as being empty and starts
> a timer to check them later.  It they are still empty at that point,
> then they are unlinked.

Yes, the patch starts to use QH_STATE_UNLINK_WAIT state for intr qh,
and previously the state is only used by async qh.

>
> Also, it's silly to check whether or not giveback uses a tasklet.  We
> know that following the 6/6 patch it will.  Even if it doesn't, there's
> no harm in waiting a little while before unlinking an empty interrupt
> QH.

It is still for the test reason, since the patch may cause recursion if
HCD_BH isn't set.

Thanks,
--
Ming Lei
