From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 28 Jun 2013 13:36:13 -0400 (EDT)
Subject: [PATCH v3 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1372410473-30920-4-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306281315180.1047-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, Ming Lei wrote:

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

There a few, relatively minor issues...

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 246e124..e2fccc0 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -484,6 +484,7 @@ static int ehci_init(struct usb_hcd *hcd)
>  	ehci->periodic_size = DEFAULT_I_TDPS;
>  	INIT_LIST_HEAD(&ehci->async_unlink);
>  	INIT_LIST_HEAD(&ehci->async_idle);
> +	INIT_LIST_HEAD(&ehci->intr_unlink_wait);
>  	INIT_LIST_HEAD(&ehci->intr_unlink);
>  	INIT_LIST_HEAD(&ehci->intr_qh_list);
>  	INIT_LIST_HEAD(&ehci->cached_itd_list);

The ehci_endpoint_disable() routine can be improved.  In the 
QH_STATE_LINNKED or QH_STATE_COMPLETING case, we now need to handle 
interrupt QHs -- the comment about "periodic qh self-unlinks on empty" 
isn't entirely correct any more, because now the unlink doesn't occur 
until the QH has been empty for 5 ms.

To start with, I think the QH_STATE_COMPLETING case label can be moved 
to the QH_STATE_UNLINK section.  That case should never happen anyway; 
endpoints aren't supposed to be disabled while they are in use.

Next, the search through the async list can be removed.  If an async QH 
is in the LINKED state then it must be on the async list.  Likewise, if 
an intr QH is in the LINKED state then it must be on the intr_qh_list.

So all we have to do is figure out whether the QH is async or intr.  If 
it is async, call start_unlink_async(), otherwise call 
start_unlink_intr().  We shouldn't have to wait 5 ms for an interrupt 
QH to be unlinked.

> @@ -632,6 +649,31 @@ static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
>  	}
>  }
>  
> +/*
> + * It is common only one intr URB is scheduled on one qh, and
> + * given complete() is run in tasklet context, introduce a bit
> + * delay to avoid unlink qh too early.
> + */
> +static void start_unlink_intr_wait(struct ehci_hcd *ehci,
> +				   struct ehci_qh *qh)
> +{
> +	/* If the QH isn't linked then there's nothing we can do. */
> +	if (qh->qh_state != QH_STATE_LINKED)
> +		return;

This test isn't needed.  This routine is called from only one spot, and 
there we know that the state is LINKED.

> @@ -921,7 +966,7 @@ static void scan_intr(struct ehci_hcd *ehci)
>  			temp = qh_completions(ehci, qh);
>  			if (unlikely(temp || (list_empty(&qh->qtd_list) &&
>  					qh->qh_state == QH_STATE_LINKED)))
> -				start_unlink_intr(ehci, qh);
> +				start_unlink_intr_wait(ehci, qh);

This is not quite right.  If temp is nonzero then we want to unlink the 
QH right away (because a fault occurred), so we should call 
start_unlink_intr().  Otherwise, if the qh->qtd_list is empty and the 
state is LINKED then we can call start_unlink_intr_wait().

> @@ -98,7 +99,6 @@ static void ehci_enable_event(struct ehci_hcd *ehci, unsigned event,
>  	}
>  }
>  
> -
>  /* Poll the STS_ASS status bit; see when it agrees with CMD_ASE */
>  static void ehci_poll_ASS(struct ehci_hcd *ehci)
>  {

This blank line should remain.

Alan Stern
