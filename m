From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 25 Jun 2013 19:56:11 +0800
Subject: [PATCH v2 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <Pine.LNX.4.44L0.1306241414240.1406-100000@iolanthe.rowland.org>
References: <1372066925-23579-4-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306241414240.1406-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMjTYAdTyihQV82QmJWJuDw_Ok1naecrSRZ46MhGuM-Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 2:53 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 24 Jun 2013, Ming Lei wrote:
>
>> Given interrupt URB will be resubmitted from tasklet context which
>> is scheduled by ehci hardware interrupt handler, and commonly only
>> one interrupt URB is scheduled on qh, so the qh may be unlinked
>> immediately once qh_completions() returns from ehci_irq(), then
>> the intr URB to be resubmitted in complete() can only be scheduled
>> and linked to hardware until the qh unlink is completed.
>>
>> This patch improves this above situation, and the qh will wait for 5
>> milliseconds before being unlinked from hardware, if one URB is submitted
>> during the period, the qh is move out of unlink wait list and the
>> interrupt transfer can be scheduled immediately, not like before: the
>> transfer is only linked to hardware until previous unlink is completed.
>
> This description is very hard to understand.  I suggest rewriting it,
> something like this:
>
> ehci-hcd currently unlinks an interrupt QH when it becomes empty, that
> is, after its last URB completes.  This works well because in almost
> all cases, the completion handler for an interrupt URB resubmits the
> URB; therefore the QH doesn't become empty and doesn't get unlinked.
>
> When we start using tasklets for URB completion, this scheme won't work
> as well.  The resubmission won't occur until the tasklet runs, which
> will be some time after the completion is queued with the tasklet.
> During that delay, the QH will be empty and so will be unlinked
> unnecessarily.
>
> To prevent this problem, this patch adds a 5-ms time delay before empty
> interrupt QHs are unlinked.  Most often, during that time the interrupt
> URB will be resubmitted and thus we can avoid unlinking the QH.

Excellent description about the change, and I will add it in V3,
also care to add your signed-off in the patch for the change log part?

>
>> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
>> index f80d033..5bf67e2 100644
>> --- a/drivers/usb/host/ehci-sched.c
>> +++ b/drivers/usb/host/ehci-sched.c
>> @@ -601,12 +601,24 @@ static void qh_unlink_periodic(struct ehci_hcd *ehci, struct ehci_qh *qh)
>>       list_del(&qh->intr_node);
>>  }
>>
>> -static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>> +/* must be called with holding ehci->lock */
>
> The comment should be:
>
> /* caller must hold ehci->lock */
>
> But in fact you can leave it out.  Almost all the code in this file
> runs with the lock held.

OK.

>
>> +static void cancel_unlink_wait_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>>  {
>> -     /* If the QH isn't linked then there's nothing we can do. */
>> -     if (qh->qh_state != QH_STATE_LINKED)
>> +     if (qh->qh_state != QH_STATE_LINKED || list_empty(&qh->unlink_node))
>>               return;
>>
>> +     list_del_init(&qh->unlink_node);
>> +
>> +     /* avoid unnecessary CPU wakeup */
>> +     if (list_empty(&ehci->intr_unlink_wait))
>> +             ehci_disable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR);
>
> If you don't mind, can we leave out ehci_disable_event() for now and
> add it after the rest of this series is merged?  It will keeps things a
> little simpler, and then we'll be able to use ehci_disable_event() for
> the IAA watchdog timer event as well as using it here.

I am fine, so this patch will become simpler and has less change.

>
>> +}
>> +
>> +static void start_do_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>> +{
>> +     /* if the qh is waitting for unlink, cancel it now */
>
> s/waitt/wait/
>
>> +     cancel_unlink_wait_intr(ehci, qh);
>> +
>>       qh_unlink_periodic (ehci, qh);
>>
>>       /* Make sure the unlinks are visible before starting the timer */
>> @@ -632,6 +644,45 @@ static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>>       }
>>  }
>>
>> +/*
>> + * It is common only one intr URB is scheduled on one qh, and
>> + * given complete() is run in tasklet context, introduce a bit
>> + * delay to avoid unlink qh too early.
>> + */
>> +static void __start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
>> +                             bool wait)
>> +{
>> +     /* If the QH isn't linked then there's nothing we can do. */
>> +     if (qh->qh_state != QH_STATE_LINKED)
>> +             return;
>> +
>> +     if (!wait)
>> +             return start_do_unlink_intr(ehci, qh);
>> +
>> +     qh->unlink_cycle = ehci->intr_unlink_wait_cycle;
>> +
>> +     /* New entries go at the end of the intr_unlink_wait list */
>> +     list_add_tail(&qh->unlink_node, &ehci->intr_unlink_wait);
>> +
>> +     if (ehci->rh_state < EHCI_RH_RUNNING)
>> +             ehci_handle_start_intr_unlinks(ehci);
>> +     else if (ehci->intr_unlink_wait.next == &qh->unlink_node) {
>> +             ehci_enable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR, true);
>> +             ++ehci->intr_unlink_wait_cycle;
>> +     }
>> +}
>> +
>> +static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>> +{
>> +     __start_unlink_intr(ehci, qh, false);
>> +}
>> +
>> +static void start_unlink_intr_wait(struct ehci_hcd *ehci,
>> +                                struct ehci_qh *qh)
>> +{
>> +     __start_unlink_intr(ehci, qh, true);
>> +}
>
> This is not what I had in mind.
>
> Instead, copy the qh->qh_state test into the beginning of
> start_unlink_intr() and move the rest of start_do_unlink_intr() there.
> Then you can rename __start_unlink_intr() to start_unlink_intr_wait()
> and get rid of the "wait" parameter.

The current code can do the check centrally, but it isn't big deal, and I
will follow your suggestion.

>
>> @@ -881,6 +932,9 @@ static int intr_submit (
>>                       goto done;
>>       }
>>
>> +     /* put back qh from unlink wait list */
>> +     cancel_unlink_wait_intr(ehci, qh);
>
> It might be better to change this line into an "else" clause for the
> "if (qh->qh_state == QH_STATE_IDLE)" statement after the BUG_ON below.

OK.

>
>> +
>>       /* then queue the urb's tds to the qh */
>>       qh = qh_append_tds(ehci, urb, qtd_list, epnum, &urb->ep->hcpriv);
>>       BUG_ON (qh == NULL);
>
>> +static void ehci_handle_start_intr_unlinks(struct ehci_hcd *ehci)
>> +{
>> +     bool            stopped = (ehci->rh_state < EHCI_RH_RUNNING);
>> +
>> +     /*
>> +      * Process all the QHs on the intr_unlink list that were added
>> +      * before the current unlink cycle began.  The list is in
>> +      * temporal order, so stop when we reach the first entry in the
>> +      * current cycle.  But if the root hub isn't running then
>> +      * process all the QHs on the list.
>> +      */
>> +     while (!list_empty(&ehci->intr_unlink_wait)) {
>> +             struct ehci_qh  *qh;
>> +
>> +             qh = list_first_entry(&ehci->intr_unlink_wait,
>> +                                   struct ehci_qh, unlink_node);
>
> As I mentioned before, this line should be indented by two tab stops
> beyond the preceding line.

Looks I forget this one.

>
>> +             if (!stopped &&
>> +                             (qh->unlink_cycle ==
>
> This doesn't need to be on a separate line at all.
>
>> +                                     ehci->intr_unlink_wait_cycle))
>
> And this should also be indented by two tab stops beyond the preceding
> line.

OK.

BTW, indenting two tab might cause more lines, and looks many subsystems
don't do that. But, anyway, I am fine with two tab, :-)

>
>> --- a/drivers/usb/host/ehci.h
>> +++ b/drivers/usb/host/ehci.h
>> @@ -88,6 +88,7 @@ enum ehci_hrtimer_event {
>>       EHCI_HRTIMER_POLL_DEAD,         /* Wait for dead controller to stop */
>>       EHCI_HRTIMER_UNLINK_INTR,       /* Wait for interrupt QH unlink */
>>       EHCI_HRTIMER_FREE_ITDS,         /* Wait for unused iTDs and siTDs */
>> +     EHCI_HRTIMER_START_UNLINK_INTR, /* wait for new intr schedule */
>
> The comment should be:                  /* Unlink empty interrupt QHs */

OK

>
>>       EHCI_HRTIMER_ASYNC_UNLINKS,     /* Unlink empty async QHs */
>>       EHCI_HRTIMER_IAA_WATCHDOG,      /* Handle lost IAA interrupts */
>>       EHCI_HRTIMER_DISABLE_PERIODIC,  /* Wait to disable periodic sched */
>> @@ -143,6 +144,8 @@ struct ehci_hcd {                 /* one per controller */
>>       unsigned                i_thresh;       /* uframes HC might cache */
>>
>>       union ehci_shadow       *pshadow;       /* mirror hw periodic table */
>> +     struct list_head        intr_unlink_wait;
>> +     unsigned                intr_unlink_wait_cycle;
>>       struct list_head        intr_unlink;
>>       unsigned                intr_unlink_cycle;
>>       unsigned                now_frame;      /* frame from HC hardware */
>
> To avoid an alignment gap on 64-bit systems, put intr_unlink_wait_cycle
> after intr_unlink.

Good catch.

Thanks,
--
Ming Lei
