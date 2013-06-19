From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Jun 2013 11:44:08 -0400 (EDT)
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <CACVXFVOMDbWRWErkF5iDqtsJVBwD4B4fn22ZR1vupb78bKoDiQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306191138050.2026-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jun 2013, Ming Lei wrote:

> > The approach used in this patch is wrong.  You shouldn't start the
> > unlink, then wait, then finish the unlink.  Consider what would happen
> 
> What you mentioned above is just what the patch is doing, :-)
> 
> start_unlink_intr() only sets the qh as QH_STATE_UNLINK_WAIT, puts
> the qh into one wait list and starts a timer, if it is expired the qh will be
> started to unlink, otherwise the qh can be recovered to QH_STATE_LINKED
> immediately if there is one URB submitted.

Okay, maybe I was fooled by your use of QH_STATE_UNLINK_WAIT.  Setting
the state to that value means that the QH is going to be unlinked after
a time delay.  However, that's not what you mean; you mean that after a
time delay you will decide whether or not to unlink the QH.

I think you should copy the approach used for the async QHs.

> So unlinking intr qh becomes a 3-stage process:
> 
>        - wait(qh return to linked state if URB is submitted during the period,
>                   otherwise go to start unlink)
>        - start unlink(do unlink, and wait for end of unlink)
>        - end unlink
> 
> > if an URB were submitted during the delay: It would have to wait until
> 
> If an URB were submitted during the delay, the previous wait is canceled
> immediately, and the qh state is recovered to linked state, please see
> cancel_unlink_wait_intr() called in intr_submit().

Right.  But you're not allowed to do that after changing qh->state.  
One of the invariants of the driver is that once qh->state takes on any
value other than QH_STATE_LINKED (or, temporarily,
QH_STATE_COMPLETING), the QH must be unlinked.  The state can't change
back to QH_STATE_LINKED without first passing through QH_STATE_IDLE.

> > Also, it's silly to check whether or not giveback uses a tasklet.  We
> > know that following the 6/6 patch it will.  Even if it doesn't, there's
> > no harm in waiting a little while before unlinking an empty interrupt
> > QH.
> 
> It is still for the test reason, since the patch may cause recursion if
> HCD_BH isn't set.

How can it cause recursion?  The async unlink code doesn't.

Alan Stern
