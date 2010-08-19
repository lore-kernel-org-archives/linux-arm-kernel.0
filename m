From: rene.sapiens@ti.com (Sapiens, Rene)
Date: Thu, 19 Aug 2010 11:09:34 -0500
Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead
	of global
In-Reply-To: <1281489169-15945-1-git-send-email-x0095840@ti.com>
References: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Message-ID: <D2943F03B81C9C458E44DFB213905E02B7637B6D@dlee04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

This patch already contains the missed changes due to previous rebases.
Thanks.

Regards,
Rene

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
> Sent: Tuesday, August 10, 2010 8:13 PM
> To: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Cc: hiroshi.doyu at nokia.com; ohad at wizery.com; Guzman Lugo, Fernando
> Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead of
> global
> 
> As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
> global variable, so if there are multiple mailbox users
> there will be conflics. Now there is a full flag per
> mailbox queue.
> 
> Version 2:
> - Rebase to the latest.
> 
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/mailbox.h |    1 +
>  arch/arm/plat-omap/mailbox.c              |   10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-
> omap/include/plat/mailbox.h
> index 9976565..261f6b8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -48,6 +48,7 @@ struct omap_mbox_queue {
>  	struct tasklet_struct	tasklet;
>  	int	(*callback)(void *);
>  	struct omap_mbox	*mbox;
> +	bool	full;
>  };
> 
>  struct omap_mbox {
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index d2fafb8..c59c9c3 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -33,7 +33,6 @@
> 
>  static struct workqueue_struct *mboxd;
>  static struct omap_mbox **mboxes;
> -static bool rq_full;
> 
>  static int mbox_configured;
>  static DEFINE_MUTEX(mbox_configured_lock);
> @@ -145,7 +144,12 @@ static void mbox_rx_work(struct work_struct *work)
>  	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
>  		len = kfifo_out(&mq->fifo, (unsigned char *)&msg,
> sizeof(msg));
>  		WARN_ON(len != sizeof(msg));
> -
> +		spin_lock_irq(&mq->lock);
> +		if (mq->full) {
> +			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
> +			mq->full = false;
> +		}
> +		spin_unlock_irq(&mq->lock);
>  		if (mq->callback)
>  			mq->callback((void *)msg);
>  	}
> @@ -170,7 +174,7 @@ static void __mbox_rx_interrupt(struct omap_mbox
> *mbox)
>  	while (!mbox_fifo_empty(mbox)) {
>  		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
>  			omap_mbox_disable_irq(mbox, IRQ_RX);
> -			rq_full = true;
> +			mq->full = true;
>  			goto nomem;
>  		}
> 
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
