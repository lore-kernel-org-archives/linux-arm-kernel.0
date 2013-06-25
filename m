From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 25 Jun 2013 10:54:05 -0400 (EDT)
Subject: [PATCH v2 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <CACVXFVMjTYAdTyihQV82QmJWJuDw_Ok1naecrSRZ46MhGuM-Ag@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306251048380.1340-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Ming Lei wrote:

> On Tue, Jun 25, 2013 at 2:53 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 24 Jun 2013, Ming Lei wrote:
> >
> >> Given interrupt URB will be resubmitted from tasklet context which
> >> is scheduled by ehci hardware interrupt handler, and commonly only
> >> one interrupt URB is scheduled on qh, so the qh may be unlinked
> >> immediately once qh_completions() returns from ehci_irq(), then
> >> the intr URB to be resubmitted in complete() can only be scheduled
> >> and linked to hardware until the qh unlink is completed.
> >>
> >> This patch improves this above situation, and the qh will wait for 5
> >> milliseconds before being unlinked from hardware, if one URB is submitted
> >> during the period, the qh is move out of unlink wait list and the
> >> interrupt transfer can be scheduled immediately, not like before: the
> >> transfer is only linked to hardware until previous unlink is completed.
> >
> > This description is very hard to understand.  I suggest rewriting it,
> > something like this:
> >
> > ehci-hcd currently unlinks an interrupt QH when it becomes empty, that
> > is, after its last URB completes.  This works well because in almost
> > all cases, the completion handler for an interrupt URB resubmits the
> > URB; therefore the QH doesn't become empty and doesn't get unlinked.
> >
> > When we start using tasklets for URB completion, this scheme won't work
> > as well.  The resubmission won't occur until the tasklet runs, which
> > will be some time after the completion is queued with the tasklet.
> > During that delay, the QH will be empty and so will be unlinked
> > unnecessarily.
> >
> > To prevent this problem, this patch adds a 5-ms time delay before empty
> > interrupt QHs are unlinked.  Most often, during that time the interrupt
> > URB will be resubmitted and thus we can avoid unlinking the QH.
> 
> Excellent description about the change, and I will add it in V3,
> also care to add your signed-off in the patch for the change log part?

You have my permission to add it.

> >> +static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
> >> +{
> >> +     __start_unlink_intr(ehci, qh, false);
> >> +}
> >> +
> >> +static void start_unlink_intr_wait(struct ehci_hcd *ehci,
> >> +                                struct ehci_qh *qh)
> >> +{
> >> +     __start_unlink_intr(ehci, qh, true);
> >> +}
> >
> > This is not what I had in mind.
> >
> > Instead, copy the qh->qh_state test into the beginning of
> > start_unlink_intr() and move the rest of start_do_unlink_intr() there.
> > Then you can rename __start_unlink_intr() to start_unlink_intr_wait()
> > and get rid of the "wait" parameter.
> 
> The current code can do the check centrally, but it isn't big deal, and I
> will follow your suggestion.

Copying the check adds two lines of code (plus a comment and a blank 
line).  Your two extra function headers, extra parameter, and extra 
test add more than that.

> OK.
> 
> BTW, indenting two tab might cause more lines, and looks many subsystems
> don't do that. But, anyway, I am fine with two tab, :-)

I admit, it isn't a perfect system and sometimes I don't use it.  But
it does have the advantage that changes to the first line don't require
the continuation line to be changed as well, just to keep the desired
alignment.  Furthermore, aligning the continuation with the first
parameter of a function call can often require _more_ than two extra
tab stops of indentation.

Alan Stern
