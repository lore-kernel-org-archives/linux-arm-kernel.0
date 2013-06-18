From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 18 Jun 2013 19:13:46 +0400
Subject: [RFC PATCH v1 2/6] USB: disable IRQs deliberately when calling
 complete()
In-Reply-To: <1371567833-9077-3-git-send-email-ming.lei@canonical.com>
References: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
 <1371567833-9077-3-git-send-email-ming.lei@canonical.com>
Message-ID: <51C0792A.9030409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-06-2013 19:03, Ming Lei wrote:

> We disable local IRQs here in case of running complete() by
> tasklet to avoid possible deadlock because drivers may call
> spin_lock() to hold lock which might be acquired in one hard
> interrupt handler.

> The local_irq_save()/local_irq_restore() around complete()
> will be removed if current USB drivers have been cleaned up
> and no one may trigger the above deadlock situation when
> running complete() in tasklet.

> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>   drivers/usb/core/hcd.c |   23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)

> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index a272968..09a8263 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1673,7 +1673,28 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>
>   	/* pass ownership to the completion handler */
>   	urb->status = status;
> -	urb->complete (urb);
> +
> +	/*
> +	 * We disable local IRQs here in case of running complete() by
> +	 * tasklet to avoid possible deadlock because drivers may call
> +	 * spin_lock() to hold lock which might be acquired in one hard
> +	 * interrupt handler.
> +	 *
> +	 * The local_irq_save()/local_irq_restore() around complete()
> +	 * will be removed if current USB drivers have been cleaned up
> +	 * and no one may trigger the above deadlock situation when
> +	 * running complete() in tasklet.
> +	 */
> +	if (hcd_giveback_urb_in_bh(hcd)) {
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +		urb->complete (urb);

    I guess you didn't run the patch thru scripts/checkpatch.pl, did you?
It would complain about the space before (.

WBR, Sergei
