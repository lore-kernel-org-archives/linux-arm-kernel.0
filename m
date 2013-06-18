From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 12:42:41 -0400 (EDT)
Subject: [RFC PATCH v1 3/6] USB: URB documentation: claim complete() may
 be run with IRQs enabled
In-Reply-To: <1371567833-9077-4-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306181236470.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Ming Lei wrote:

> There is no good reason to run complete() in hard interrupt
> disabled context.
> 
> After running complete() in tasklet, we will enable local IRQs
> when calling complete() since we can do it now.
> 
> Even though we still disable IRQs now when calling complete()
> in tasklet, the URB documentation is updated to claim complete()
> may be run in tasklet context and local IRQs may be enabled, so
> that USB drivers can know the change and avoid one deadlock caused
> by: assume IRQs disabled in complete() and call spin_lock() to
> hold lock which might be acquired in interrupt context.
> 
> Current spin_lock() usages in drivers' complete() will be cleaned
> up at the same time, and when the cleanup is finished, local IRQs
> will be enabled when calling complete() in tasklet.
> 
> Also fix description about type of usb_complete_t.

> @@ -210,12 +209,19 @@ have transferred successfully before the completion was called.
>  
>  
>  NOTE:  ***** WARNING *****
> -NEVER SLEEP IN A COMPLETION HANDLER.  These are normally called
> -during hardware interrupt processing.  If you can, defer substantial
> -work to a tasklet (bottom half) to keep system latencies low.  You'll
> -probably need to use spinlocks to protect data structures you manipulate
> -in completion handlers.
> -
> +NEVER SLEEP IN A COMPLETION HANDLER.  These are called during hardware
> +interrupt processing if HCD_BH isn't set in hcd->driver->flags, otherwise
> +called in tasklet context. If you can, defer substantial work to a tasklet
> +(bottom half) to keep system latencies low.  You'll probably need to use
> +spinlocks to protect data structures you manipulate in completion handlers.

You shouldn't go into so much detail here, partly because it doesn't 
matter for driver authors and partly because it is subject to change.  
Just say that completion handlers are usually called in an atomic 
context, so they must not sleep.

Also, the advice about deferring work to a tasklet seems out of place 
now, since many completion handlers will already be running in a 
tasklet.

> +Driver can't assume that local IRQs are disabled any more when running
> +complete(), for example, if drivers want to hold a lock which might be
> +acquired in hard interrupt handler, they have to use spin_lock_irqsave()
> +instead of spin_lock() to hold the lock.

Don't say so much.  Just mention that in the current kernel (3.10),
completion handlers always run with local interrupts disabled, but in
the future this is likely to change.  Therefore drivers should not make
any assumptions.

> +In the future, all HCD might set HCD_BH to run complete() in tasklet so
> +that system latencies can be kept low.

This does not need to be in the documentation.

Alan Stern
