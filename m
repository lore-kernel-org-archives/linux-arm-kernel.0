From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 01 Feb 2017 13:56:36 +0100
Subject: [PATCH] dmaengine: pl330: Fix race in residue reporting
In-Reply-To: <20170201124349.21443-1-romain.perier@collabora.com>
References: <20170201124349.21443-1-romain.perier@collabora.com>
Message-ID: <1485953796.14092.24.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Romain,

I submitted this ages ago, but got distracted. Thanks for reviving.
Note that i remember Krzysztof had some review remarks, it's probably
worth digging up the old thread and making sure you address those.

On Wed, 2017-02-01 at 13:43 +0100, Romain Perier wrote:
> From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> When a transfer completes there is a small window between the
> descriptor
> being unset as the current active one in the thread and it being
> marked
> as done. This causes the residue to be incorrectly set when
> pl330_tx_status is run in that window. Practically this caused
> issue for me with audio playback as the residue goes up during a
> transfer (as the in-progress transfer is no longer accounted for),
> which makes the higher levels think the audio ringbuffer wrapped
> around
> and thus did a sudden big jump forward.
> 
> To resolve this, add a field protected by the dma engine lock to
> indicate the transfer is done but the status hasn't been updated yet.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> 
> Series-to: Vinod Koul <vinod.koul@intel.com>
> Series-cc: dmaengine at vger.kernel.org
> Series-cc: linux-kernel at vger.kernel.org
> Series-cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Series-cc: linux-rockchip at lists.infradead.org
> Series-cc: linux-samsung-soc at vger.kernel.org
> Series-cc:??linux-arm-kernel at vger.kernel.org

These are patman metadata, you probably want to drop these from the
commit message ;)



> ?drivers/dma/pl330.c | 9 ++++++++-
> ?1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 740bbb9..d942fac 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -521,6 +521,9 @@ struct dma_pl330_desc {
> ?
> ?	enum desc_status status;
> ?
> +	/* Transfer completed, but not yet moved to DONE state */
> +	bool xferred;
> +
> ?	int bytes_requested;
> ?	bool last;
> ?
> @@ -1508,6 +1511,9 @@ static void dma_pl330_rqcb(struct
> dma_pl330_desc *desc, enum pl330_op_err err)
> ?	spin_lock_irqsave(&pch->lock, flags);
> ?
> ?	desc->status = DONE;
> +	spin_lock(&pch->thread->dmac->lock);
> +	desc->xferred = false;
> +	spin_unlock(&pch->thread->dmac->lock);
> ?
> ?	spin_unlock_irqrestore(&pch->lock, flags);
> ?
> @@ -1640,6 +1646,7 @@ static int pl330_update(struct pl330_dmac
> *pl330)
> ?
> ?			/* Detach the req */
> ?			descdone = thrd->req[active].desc;
> +			descdone->xferred = true;
> ?			thrd->req[active].desc = NULL;
> ?
> ?			thrd->req_running = -1;
> @@ -2311,7 +2318,7 @@ pl330_tx_status(struct dma_chan *chan,
> dma_cookie_t cookie,
> ?
> ?	/* Check in pending list */
> ?	list_for_each_entry(desc, &pch->work_list, node) {
> -		if (desc->status == DONE)
> +		if (desc->xferred || desc->status == DONE)
> ?			transferred = desc->bytes_requested;
> ?		else if (running && desc == running)
> ?			transferred =

-- 
Sjoerd Simons
Collabora Ltd.
