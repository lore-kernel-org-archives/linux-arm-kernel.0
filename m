From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 22 Jul 2011 11:12:10 +0530
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY058yBZnmYcqbqFCfsBUcxU=JbTZmopLApZaaKim+MMfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 4:16 PM, Boojin Kim <boojin.kim@samsung.com> wrote:
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?drivers/dma/pl330.c | ? 53 +++++++++++++++++++++++++++++++++++++-------------
> ?1 files changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 586ab39..880f010 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -256,25 +256,50 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
> ?static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
> ?{
> ? ? ? ?struct dma_pl330_chan *pch = to_pchan(chan);
> - ? ? ? struct dma_pl330_desc *desc;
> + ? ? ? struct dma_pl330_desc *desc, *_dt;
> ? ? ? ?unsigned long flags;
> + ? ? ? struct dma_pl330_dmac *pdmac = pch->dmac;
> + ? ? ? struct dma_slave_config *slave_config;
> + ? ? ? struct dma_pl330_peri *peri;
> + ? ? ? LIST_HEAD(list);
>
> - ? ? ? /* Only supports DMA_TERMINATE_ALL */
> - ? ? ? if (cmd != DMA_TERMINATE_ALL)
> - ? ? ? ? ? ? ? return -ENXIO;
> -
> - ? ? ? spin_lock_irqsave(&pch->lock, flags);
> -
> - ? ? ? /* FLUSH the PL330 Channel thread */
> - ? ? ? pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> + ? ? ? switch (cmd) {
> + ? ? ? case DMA_TERMINATE_ALL:
> + ? ? ? ? ? ? ? spin_lock_irqsave(&pch->lock, flags);
>
> - ? ? ? /* Mark all desc done */
> - ? ? ? list_for_each_entry(desc, &pch->work_list, node)
> - ? ? ? ? ? ? ? desc->status = DONE;
> + ? ? ? ? ? ? ? /* FLUSH the PL330 Channel thread */
> + ? ? ? ? ? ? ? pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
>
> - ? ? ? spin_unlock_irqrestore(&pch->lock, flags);
> + ? ? ? ? ? ? ? /* Mark all desc done */
> + ? ? ? ? ? ? ? list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
> + ? ? ? ? ? ? ? ? ? ? ? desc->status = DONE;
> + ? ? ? ? ? ? ? ? ? ? ? pch->completed = desc->txd.cookie;
> + ? ? ? ? ? ? ? ? ? ? ? list_move_tail(&desc->node, &list);
> + ? ? ? ? ? ? ? }
>
> - ? ? ? pl330_tasklet((unsigned long) pch);
> + ? ? ? ? ? ? ? list_splice_tail_init(&list, &pdmac->desc_pool);
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&pch->lock, flags);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case DMA_SLAVE_CONFIG:
> + ? ? ? ? ? ? ? slave_config = (struct dma_slave_config *)arg;
> + ? ? ? ? ? ? ? peri = pch->chan.private;
> +
> + ? ? ? ? ? ? ? if (slave_config->direction == DMA_TO_DEVICE) {
> + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->dst_addr;
> + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr_width)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->dst_addr_width);
> + ? ? ? ? ? ? ? } else if (slave_config->direction == DMA_FROM_DEVICE) {
> + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->src_addr;
> + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr_width)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->src_addr_width);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
   As discussed yesterday, DMA_SLAVE_CONFIG is assumed to be madatory,
so please dismantle the 'struct dma_pl330_peri', move fifo_addr,
burst_sz and rqtype
to 'struct dma_pl330_chan' and poison them - that will force clients
to do DMA_SLAVE_CONFIG. Move 'peri_id' to 'struct dma_pl330_platdata'
  And protect the changes to channel parameters with lock.
