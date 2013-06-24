From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Jun 2013 12:55:22 +0800
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <Pine.LNX.4.44L0.1306211516190.1020-100000@iolanthe.rowland.org>
References: <CACVXFVOp_zPRA65QBwLdD7pPLR1efK1_HSg1CmHbYCpmY+JJqw@mail.gmail.com>
 <Pine.LNX.4.44L0.1306211516190.1020-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMPrsBD75V=QAONWZeZho4AMutv-5gDhWO+kOzSaVqRcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 4:16 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 20 Jun 2013, Ming Lei wrote:
>
>> IMO, there is no any side effect when we change the state to
>> QH_STATE_UNLINK_WAIT and later change back to QH_STATE_LINKED
>> later under this situation.
>
> I don't like the idea of changing an invariant.
>
>> The reason why I use QH_STATE_UNLINK_WAIT here is for avoiding
>> unnecessary CPU wakeup.  Without the state, the unlink wait timer
>> is still triggered to check if there are intr QHs to be unlinked, but in most of
>> situations, there aren't QHs to be unlinked since tasklet is surely run
>> before the wait timer is expired. So generally, without knowing the wait state,
>> CPU wakeup events may be introduced unnecessarily.
>
> Avoiding unnecessary timer events is a good thing, but I don't
> understand how it is connected with QH_STATE_UNLINK_WAIT.  Doesn't this
> revised patch avoid the events without using this state?
>
> Besides, don't you already know the wait state by checking whether
> qh->unlink_node is empty?
>
>> Considered that the interval of interrupt endpoint might be very
>> small(e.g. 125us,
>> 1ms) and some devices have very frequent intr event, I think we
>> need to pay attention to the problem.
>
> Yes, we do.  The hrtimer code in ehci-timer is written specifically to
> handle that sort of situation.
>
>> Even on async QH situation, we might need to consider the problem too
>> since some application(eg. bulk only mass storage on xhci) may have
>> thousands of interrupts per seconds during data transfer, so CPU wakeup
>> events could be increased much by letting wait timer expire unnecessarily.
>
> I suspect it's the other way around.  Letting the timer expire
> _reduces_ the amount of work, because we don't have to start and stop
> the timer as often.
>
> It's a tradeoff.  One approach starts and cancels the timer N times
> (where N can be fairly large); the other approach starts the timer
> once and lets it expire, and then the handler routine does almost no
> work.  Which approach uses more CPU time?  I don't know; I haven't
> measured it.
>
>> Also the async QH unlink approach has another disadvantage:
>>
>> - if there are several QHs which are become empty during one wait period,
>> the hrtimer has to be scheduled several times for starting unlink one qh
>> each time.
>
> That's because the driver unlinks only one async QH at a time.  It is
> unavoidable.  In earlier kernels the driver would unlink multiple async
> QHs simultaneously, and it needed to schedule the timer only once.
> For some reason (I still don't understand why), this did not work on
> some systems.
>
>>  And after introducing the unlink wait list like the patch, we only
>> need schedule the hrtimer one time for unlinking all these empty QHs.
>
> The async code used to work that way, before I changed it to unlink
> only one async QH at a time.
>
>> Finally, unlink wait for intr qh is only needed when the qh is completed
>> right now, and other cases(eg. unlink) needn't the wait.
>
> Right.
>
>> The attached patch removes the QH_STATE_UNLINK_WAIT, and can
>> avoid the above disadvantages of async QH unlink, could you comment
>> on the new patch?
>
> Okay...

Thanks for your review.

>
>> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
>> index 246e124..35b4148 100644
>> --- a/drivers/usb/host/ehci-hcd.c
>> +++ b/drivers/usb/host/ehci-hcd.c
>> @@ -304,7 +304,8 @@ static void end_unlink_async(struct ehci_hcd *ehci);
>>  static void unlink_empty_async(struct ehci_hcd *ehci);
>>  static void unlink_empty_async_suspended(struct ehci_hcd *ehci);
>>  static void ehci_work(struct ehci_hcd *ehci);
>> -static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);
>> +static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
>> +                           bool wait);
>
> Adding a "wait" argument is a bad approach.  You should create a new
> function: start_unlink_intr_wait() or something like that.  After all,
> it is used in only one place.

OK.

>
>> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
>> index acff5b8..5dfda56 100644
>> --- a/drivers/usb/host/ehci-sched.c
>> +++ b/drivers/usb/host/ehci-sched.c
>> @@ -548,6 +548,9 @@ static void qh_link_periodic(struct ehci_hcd
>> *ehci, struct ehci_qh *qh)
>>
>>       list_add(&qh->intr_node, &ehci->intr_qh_list);
>>
>> +     /* unlink need this node to be initialized */
>> +     INIT_LIST_HEAD(&qh->unlink_node);
>
> This should be done only once, when the QH is created.  And the comment
> is unnecessary.

OK, I will move it into ehci_qh_alloc().

>
>> @@ -98,6 +99,17 @@ static void ehci_enable_event(struct ehci_hcd
>> *ehci, unsigned event,
>>       }
>>  }
>>
>> +/* Warning: don't call this function from hrtimer handler context */
>> +static void ehci_disable_event(struct ehci_hcd *ehci, unsigned event)
>> +{
>> +     if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)))
>> +             return;
>
> This test looks really ugly, and it won't be needed after the driver
> switches over to tasklets.  Of course, there's a problem before we
> switch over: this routine will be called by an interrupt URB
> submission, which could occur during a giveback in the timer handler
> context.
>
> Perhaps the best approach is to leave this routine out until after the
> driver switches over.

Considered without this patch, enabling BH_HCD isn't very good
for interrupt transfer, I will remove the check in 6/6.

>
>> +
>> +     ehci->enabled_hrtimer_events &= ~(1 << event);
>> +     if (!ehci->enabled_hrtimer_events)
>
> Here you need to add:
>
>                 ehci->next_hrtimer_event = EHCI_HRTIMER_NO_EVENT;

Good catch.

>
>> +             hrtimer_cancel(&ehci->hrtimer);
>> +}
>
> This could also be useful for the IAA watchdog timer in the STS_IAA
> code in ehci_irq().

Right, it might be useful for any ehci timers which won't expire at
most of times, especially when the timer's frequency is high.

>
>> @@ -215,6 +227,36 @@ static void ehci_handle_controller_death(struct
>> ehci_hcd *ehci)
>>       /* Not in process context, so don't try to reset the controller */
>>  }
>>
>> +/* start to unlink interrupt QHs  */
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
>> +             if (!stopped &&
>> +                 qh->unlink_cycle == ehci->intr_unlink_wait_cycle)
>> +                     break;
>
> The style in this driver is to add two tab stops to continuation lines,
> not to line them up with respect to the previous line.

OK.

> Otherwise this seems to be about right.

Thanks,
--
Ming Lei
