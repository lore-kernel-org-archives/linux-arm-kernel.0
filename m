From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 24 Jun 2013 11:17:36 -0400 (EDT)
Subject: [PATCH v2 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <1372066925-23579-2-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306241102340.1406-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Jun 2013, Ming Lei wrote:

> This patch implements the mechanism of giveback of URB in
> tasklet context, so that hardware interrupt handling time for
> usb host controller can be saved much, and HCD interrupt handling
> can be simplified.

Changes from v1 to v2?


> +static void usb_giveback_urb_bh(unsigned long param)
> +{
> +	struct giveback_urb_bh *bh = (struct giveback_urb_bh *)param;
> +	unsigned long flags;
> +	struct list_head local_list;
> +
> +	spin_lock_irqsave(&bh->lock, flags);
> +	bh->running = 1;
> + restart:
> +	list_replace_init(&bh->head, &local_list);
> +	spin_unlock_irqrestore(&bh->lock, flags);

Tasklet routines are always called with interrupts enabled, right?  
Therefore you don't need to use the "flags" argument here or below.

> @@ -1667,25 +1721,40 @@ int usb_hcd_unlink_urb (struct urb *urb, int status)
>   */
>  void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  {
> -	urb->hcpriv = NULL;
> -	if (unlikely(urb->unlinked))
> -		status = urb->unlinked;
> -	else if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
> -			urb->actual_length < urb->transfer_buffer_length &&
> -			!status))
> -		status = -EREMOTEIO;
> +	struct giveback_urb_bh *bh;
> +	bool sched, high_prio_bh;
>  
> -	unmap_urb_for_dma(hcd, urb);
> -	usbmon_urb_complete(&hcd->self, urb, status);
> -	usb_unanchor_urb(urb);
> +	/* pass status to tasklet via unlinked */
> +	if (likely(!urb->unlinked))
> +		urb->unlinked = status;
>  
> -	/* pass ownership to the completion handler */
> -	urb->status = status;
> -	urb->complete (urb);
> -	atomic_dec (&urb->use_count);
> -	if (unlikely(atomic_read(&urb->reject)))
> -		wake_up (&usb_kill_urb_queue);
> -	usb_put_urb (urb);
> +	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
> +		__usb_hcd_giveback_urb(urb);
> +		return;
> +	}
> +
> +	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
> +		bh = &hcd->high_prio_bh;
> +		high_prio_bh = 1;
> +	} else {
> +		bh = &hcd->low_prio_bh;
> +		high_prio_bh = 0;
> +	}

Bool values should be assigned "true" or "false", not "1" or "0".

> +
> +	spin_lock(&bh->lock);
> +	list_add_tail(&urb->urb_list, &bh->head);
> +	if (bh->running)
> +		sched = 0;
> +	else
> +		sched = 1;
> +	spin_unlock(&bh->lock);

How about calling this variable "running" instead of "sched"?  Then you 
could just say:

	running = bh->running;

with no "if" statement.

> +
> +	if (!sched)
> +		;
> +	else if (high_prio_bh)
> +		tasklet_hi_schedule(&bh->bh);
> +	else
> +		tasklet_schedule(&bh->bh);
>  }
>  EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
>  
> @@ -2307,6 +2376,42 @@ EXPORT_SYMBOL_GPL (usb_hc_died);
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static void __init_giveback_urb_bh(struct giveback_urb_bh *bh)
> +{
> +
> +	spin_lock_init(&bh->lock);
> +	INIT_LIST_HEAD(&bh->head);
> +	tasklet_init(&bh->bh, usb_giveback_urb_bh, (unsigned long)bh);
> +}
> +
> +static void init_giveback_urb_bh(struct usb_hcd *hcd)
> +{
> +	if (!hcd_giveback_urb_in_bh(hcd))
> +		return;

As you mentioned, there's not much point in skipping this code when
it's not needed.  In fact, you could just put the two lines below
directly into usb_create_shared_hcd(), and get rid of the "__" from the
beginning of the name.

> +
> +	__init_giveback_urb_bh(&hcd->high_prio_bh);
> +	__init_giveback_urb_bh(&hcd->low_prio_bh);
> +}
> +
> +static void exit_giveback_urb_bh(struct usb_hcd *hcd)
> +{
> +	if (!hcd_giveback_urb_in_bh(hcd))
> +		return;
> +
> +	/*
> +	 * tasklet_kill() isn't needed here because:
> +	 * - driver's disconnec() called from usb_disconnect() should

Misspelled "disconnect".

> +	 *   make sure its URBs are completed during the disconnect()
> +	 *   callback
> +	 *
> +	 * - it is too late to run complete() here since driver may have
> +	 *   been removed already now
> +	 *
> +	 * Using tasklet to run URB's complete() doesn't change this
> +	 * behavior of usbcore.
> +	 */
> +}

Why have a separate subroutine for doing nothing?  Simply put this 
comment directly into usb_remove_hcd().  (And you can remove the last 
two lines of the comment; they don't make sense in this context.)

Alan Stern
