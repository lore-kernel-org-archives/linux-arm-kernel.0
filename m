From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 28 Oct 2010 15:57:41 -0500
Subject: [PATCH 6/7] omap:mailbox-add notification support for multiple
	readers
In-Reply-To: <1287108808-32119-7-git-send-email-h-kanigeri2@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-7-git-send-email-h-kanigeri2@ti.com>
Message-ID: <4CC9E3C5.7000208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/14/2010 9:13 PM, Hari Kanigeri wrote:
> @@ -252,41 +253,39 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
...
> +	if (!mbox->use_count++) {
> +		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> +					mbox->name, mbox);
...
> @@ -296,29 +295,36 @@ fail_alloc_txq:
...
>   static void omap_mbox_fini(struct omap_mbox *mbox)
>   {
> +	if (!--mbox->use_count) {
> +		tasklet_kill(&mbox->txq->tasklet);
> +		flush_work(&mbox->rxq->work);
> +		mbox_queue_free(mbox->txq);
> +		mbox_queue_free(mbox->rxq);
> +	}
> +
> +	if (likely(mbox->ops->shutdown)) {
> +		if (!--mbox_configured) {
> +			free_irq(mbox->irq, mbox);

Above hunks will create an imbalance of free_irq, as request_irq can be 
called per registered mailbox and free_irq is only done for the last 
caller releasing the mailbox handle.

e.g.: mbox-1, mbox-N will request a shared irq on the same interrupt 
line, but only the last caller of omap_mbox_put will free its irq, 
leaving the other one there.

This can be fixed if the free is moved to be executed within the 
following block:

	if (!--mbox->use_count) {
		...
		free_irq(mbox->irq, mbox);
	}

Regards,

Omar
