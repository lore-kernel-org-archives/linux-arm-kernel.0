From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 12:51:49 -0400 (EDT)
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1371567833-9077-6-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306181246140.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Ming Lei wrote:

> Given interrupt URB will be resubmitted from tasklet context which
> is scheduled by ehci hardware interrupt handler, and commonly only
> one interrupt URB is scheduled on qh, so the qh may be unlinked
> immediately once qh_completions() returns from ehci_irq(), then
> the intr URB to be resubmitted in complete() can only be scheduled
> and linked to hardware until the qh unlink is completed.
> 
> This patch applied the QH_STATE_UNLINK_WAIT(not used by interrupt qh)
> state to improve this above situation, and the qh will wait for 5
> milliseconds before being unlinked from hardware, if one URB is submitted
> during the period, the qh is move out of unlink wait state and the
> interrupt transfer can be scheduled immediately, not like before: the
> transfer is only linked to hardware until previous unlink is completed.
> 
> Only enable the improvement in case that HCD supports to run
> giveback of URB in tasklet context.

The approach used in this patch is wrong.  You shouldn't start the 
unlink, then wait, then finish the unlink.  Consider what would happen 
if an URB were submitted during the delay: It would have to wait until 
the QH was completely unlinked.  Instead, you should wait first, then 
do the entire unlink.

For example, scan_async() in ehci-q.c doesn't immediately begin to 
unlink empty async QHs.  It merely marks them as being empty and starts 
a timer to check them later.  It they are still empty at that point, 
then they are unlinked.

Also, it's silly to check whether or not giveback uses a tasklet.  We 
know that following the 6/6 patch it will.  Even if it doesn't, there's 
no harm in waiting a little while before unlinking an empty interrupt 
QH.

Alan Stern
