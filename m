From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 4 Jul 2018 10:39:14 +0800
Subject: [PATCH v22 4/4] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1530665257.24157.7.camel@mhfsdcap03>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
 <1530098172-31385-5-git-send-email-houlong.wei@mediatek.com>
 <1530182516.8518.11.camel@mtksdaap41>
 <1530228739.21991.14.camel@mhfsdcap03>
 <1530264123.22098.12.camel@mtksdaap41>
 <1530665257.24157.7.camel@mhfsdcap03>
Message-ID: <1530671954.8732.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Houlong:

On Wed, 2018-07-04 at 08:47 +0800, houlong wei wrote:
> On Fri, 2018-06-29 at 17:22 +0800, CK Hu wrote:
> > Hi, Houlong:
> > 
> > On Fri, 2018-06-29 at 07:32 +0800, houlong wei wrote:
> > > On Thu, 2018-06-28 at 18:41 +0800, CK Hu wrote:
> > > > Hi, Houlong:
> > > > 
> > > > Some inline comment.
> > > > 
> > > > On Wed, 2018-06-27 at 19:16 +0800, Houlong Wei wrote:
> > > > > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> > > > > 
> > > > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > > > ---
> > > > >  drivers/soc/mediatek/Kconfig           |   12 ++
> > > > >  drivers/soc/mediatek/Makefile          |    1 +
> > > > >  drivers/soc/mediatek/mtk-cmdq-helper.c |  258 ++++++++++++++++++++++++++++++++
> > > > >  include/linux/soc/mediatek/mtk-cmdq.h  |  132 ++++++++++++++++
> > > > >  4 files changed, 403 insertions(+)
> > > > >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> > > > >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> > > > > 
> > > > > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > > > > index a7d0667..17bd759 100644
> > > > > --- a/drivers/soc/mediatek/Kconfig
> > > > > +++ b/drivers/soc/mediatek/Kconfig
> > > > > @@ -4,6 +4,18 @@
> > > > >  menu "MediaTek SoC drivers"
> > > > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > >  
> > > > 
> > 
> > [...]
> > 
> > > > > +
> > > > > +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> > > > > +{
> > > > > +	int err;
> > > > > +
> > > > > +	if (cmdq_pkt_is_finalized(pkt))
> > > > > +		return 0;
> > > > > +
> > > > > +	/* insert EOC and generate IRQ for each command iteration */
> > > > > +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> > > > > +	if (err < 0)
> > > > > +		return err;
> > > > > +
> > > > > +	/* JUMP to end */
> > > > > +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> > > > > +	if (err < 0)
> > > > > +		return err;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
> > > > > +			 cmdq_async_flush_cb cb, void *data)
> > > > > +{
> > > > > +	int err;
> > > > > +	struct device *dev;
> > > > > +	dma_addr_t dma_addr;
> > > > > +
> > > > > +	err = cmdq_pkt_finalize(pkt);
> > > > > +	if (err < 0)
> > > > > +		return err;
> > > > > +
> > > > > +	dev = client->chan->mbox->dev;
> > > > > +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->cmd_buf_size,
> > > > > +		DMA_TO_DEVICE);
> > > > 
> > > > You map here, but I could not find unmap, so the unmap should be done in
> > > > client driver. I would prefer a symmetric map/unmap which means that
> > > > both map and unmap are done in client driver. I think you put map here
> > > > because you should map after finalize. 
> > > 
> > > The unmap is done before callback to client, in function
> > > cmdq_task_exec_done, mtk-cmdq-mailbox.c.
> > 
> > You put unmap in mailbox controller, and map here (here would be mailbox
> > client), so this is not symmetric. If the code is asymmetric, it's easy
> > to cause bug and not easy to maintain. So I would like move both
> > map/unmap to client driver.
> > 
> 
> Since map/unmap is common code for client drivers, can we move unmap to
> CMDQ helper and do not put in client driver?
> 
> > > 
> > > > Therefore, export
> > > > cmdq_pkt_finalize() to client driver and let client do finalize, so
> > > > there is no finalize in flush function. This method have a benefit that
> > > > if client reuse command buffer, it need not to map/unmap frequently.
> > > 
> > > If client reuse command buffer or cmdq_pkt(command queue packet), client
> > > will add new commands to the cmdq_pkt, so map/unmap are necessary for
> > > each cmdq_pkt flush.
> > 
> > If the buffer size is 4K bytes, client driver could map the whole 4K at
> > initialization. Before it write new command, it call
> > dma_sync_single_for_cpu(), after it write new command, it call
> > dma_sync_single_for_device(). And then it could flush this buffer to
> > mailbox controller. So client driver just call dma sync function when it
> > reuse the command buffer. dma sync function is much lightweight then dma
> > map because map would search the memory area which could be mapped.
> > 
> > Regards,
> > CK
> 
> Maybe we can do dma map/unmap/sync in cmdq helper, and make client
> driver simple.
> 

Why are map/unmap common code for client drivers? I've mentioned that
some client driver may just call dma sync function before flush, so it
does not map for every flush. Frequently map/unmap has some drawback:

1. Waste CPU resource: this also waste power.
2. Risk of mapping fail: to reduce this risk, client driver could map at
initialization.

I think reducing these drawback is more important than making client
driver simple.

Regards,
CK

> > 
> > > 
> > > > 
> > > > Regards,
> > > > CK
> > > > 
> > > > > +	if (dma_mapping_error(dev, dma_addr)) {
> > > > > +		dev_err(client->chan->mbox->dev, "dma map failed\n");
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +
> > > > > +	pkt->pa_base = dma_addr;
> > > > > +	pkt->cb.cb = cb;
> > > > > +	pkt->cb.data = data;
> > > > > +
> > > > > +	mbox_send_message(client->chan, pkt);
> > > > > +	/* We can send next packet immediately, so just call txdone. */
> > > > > +	mbox_client_txdone(client->chan, 0);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(cmdq_pkt_flush_async);
> > > > > +
> > > > > +struct cmdq_flush_completion {
> > > > > +	struct completion cmplt;
> > > > > +	bool err;
> > > > > +};
> > > > > +
> > > > > +static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> > > > > +{
> > > > > +	struct cmdq_flush_completion *cmplt = data.data;
> > > > > +
> > > > > +	cmplt->err = data.err;
> > > > > +	complete(&cmplt->cmplt);
> > > > > +}
> > > > > +
> > > > > +int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
> > > > > +{
> > > > > +	struct cmdq_flush_completion cmplt;
> > > > > +	int err;
> > > > > +
> > > > > +	init_completion(&cmplt.cmplt);
> > > > > +	err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
> > > > > +	if (err < 0)
> > > > > +		return err;
> > > > > +	wait_for_completion(&cmplt.cmplt);
> > > > > +
> > > > > +	return cmplt.err ? -EFAULT : 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(cmdq_pkt_flush);
> > > > 
> > > > [...]
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 
