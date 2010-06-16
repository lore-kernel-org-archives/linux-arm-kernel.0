From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 16 Jun 2010 16:17:58 -0500
Subject: [PATCH] mailbox: change full flag per mailbox queue instead of
	global
In-Reply-To: <1276534269-19179-1-git-send-email-x0095840@ti.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
Message-ID: <AANLkTimQrOIbsvQw7yv2x_KJmsv2p5KfNdcsNk2_DWGm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 11:51 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> As pointed by Ben Ohand, the variable rq_full flag is a global
> variable, so if there are multiple mailbox users there will be
> conflics. Now there is a full flag per mailbox queue.
>
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
> ?arch/arm/plat-omap/include/plat/mailbox.h | ? ?1 +
> ?arch/arm/plat-omap/mailbox.c ? ? ? ? ? ? ?| ? ?7 +++----
> ?2 files changed, 4 insertions(+), 4 deletions(-)


Thanks, Fernando, it looks good !

Since the original patch wasn't merged yet, it might make more sense
to squash it with this fix into a single patch, instead of introducing
this fix as a new patch. what do you think ?

>
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
> index 729166b..a6144b8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -47,6 +47,7 @@ struct omap_mbox_queue {
> ? ? ? ?struct tasklet_struct ? tasklet;
> ? ? ? ?int ? ? (*callback)(void *);
> ? ? ? ?struct omap_mbox ? ? ? ?*mbox;
> + ? ? ? bool ? ?full;
> ?};
>
> ?struct omap_mbox {
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 8d86b0b..a1e274e 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -30,7 +30,6 @@
>
> ?static struct omap_mbox *mboxes;
> ?static DEFINE_RWLOCK(mboxes_lock);
> -static bool rq_full;
>
> ?static int mbox_configured;
> ?static DEFINE_MUTEX(mbox_configured_lock);
> @@ -140,9 +139,9 @@ static void mbox_rx_work(struct work_struct *work)
> ? ? ? ?while (1) {
> ? ? ? ? ? ? ? ?spin_lock_irqsave(q->queue_lock, flags);
> ? ? ? ? ? ? ? ?rq = blk_fetch_request(q);
> - ? ? ? ? ? ? ? if (rq_full) {
> + ? ? ? ? ? ? ? if (mbox->rxq->full) {
> ? ? ? ? ? ? ? ? ? ? ? ?omap_mbox_enable_irq(mbox, IRQ_RX);
> - ? ? ? ? ? ? ? ? ? ? ? rq_full = false;
> + ? ? ? ? ? ? ? ? ? ? ? mbox->rxq->full = false;
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(q->queue_lock, flags);
> ? ? ? ? ? ? ? ?if (!rq)
> @@ -183,7 +182,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
> ? ? ? ? ? ? ? ?rq = blk_get_request(q, WRITE, GFP_ATOMIC);
> ? ? ? ? ? ? ? ?if (unlikely(!rq)) {
> ? ? ? ? ? ? ? ? ? ? ? ?omap_mbox_disable_irq(mbox, IRQ_RX);
> - ? ? ? ? ? ? ? ? ? ? ? rq_full = true;
> + ? ? ? ? ? ? ? ? ? ? ? mbox->rxq->full = true;
> ? ? ? ? ? ? ? ? ? ? ? ?goto nomem;
> ? ? ? ? ? ? ? ?}
>
> --
> 1.6.3.3
>
>
