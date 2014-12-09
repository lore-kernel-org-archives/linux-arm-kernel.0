From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 9 Dec 2014 10:50:30 +0100
Subject: [PATCH 2/3] dmaengine: at_xdmac: simplify channel configuration
 stuff
In-Reply-To: <20141209061308.GY16827@intel.com>
References: <1417018949-24246-1-git-send-email-ludovic.desroches@atmel.com>
 <1417018949-24246-3-git-send-email-ludovic.desroches@atmel.com>
 <20141208103918.GF16827@intel.com>
 <20141208140500.GF27228@ldesroches-Latitude-E6320>
 <20141209061308.GY16827@intel.com>
Message-ID: <20141209095030.GI27228@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 11:43:08AM +0530, Vinod Koul wrote:
> On Mon, Dec 08, 2014 at 03:05:00PM +0100, Ludovic Desroches wrote:
> > On Mon, Dec 08, 2014 at 04:09:18PM +0530, Vinod Koul wrote:
> > > On Wed, Nov 26, 2014 at 05:22:28PM +0100, Ludovic Desroches wrote:
> > > > Using the cc field of the descriptor simplifies the management of the channel
> > > > configuration.
> > > > 
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > ---
> > > >  drivers/dma/at_xdmac.c | 33 +++++++++++++--------------------
> > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > > > index bc4b018..94b714e 100644
> > > > --- a/drivers/dma/at_xdmac.c
> > > > +++ b/drivers/dma/at_xdmac.c
> > > > @@ -200,6 +200,7 @@ struct at_xdmac_chan {
> > > >  	u8				memif;		/* Memory Interface */
> > > >  	u32				per_src_addr;
> > > >  	u32				per_dst_addr;
> > > > +	u32				save_cc;
> > > >  	u32				save_cim;
> > > >  	u32				save_cnda;
> > > >  	u32				save_cndc;
> > > > @@ -357,14 +358,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
> > > >  	 */
> > > >  	if (is_slave_direction(first->direction)) {
> > > >  		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
> > > > -		if (first->direction == DMA_MEM_TO_DEV)
> > > > -			atchan->cfg[AT_XDMAC_CUR_CFG] =
> > > > -				atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
> > > > -		else
> > > > -			atchan->cfg[AT_XDMAC_CUR_CFG] =
> > > > -				atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
> > > > -		at_xdmac_chan_write(atchan, AT_XDMAC_CC,
> > > > -				    atchan->cfg[AT_XDMAC_CUR_CFG]);
> > > > +		at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
> > > how is this related to adding cc field?
> > 
> > It is not directly related to adding save_cc field but to use the lld cc
> > field which is lld.mbr_cfg instead of cfg[AT_XDMAC_CUR_CFG].
> > 
> > > 
> > > >  	} else {
> > > >  		/*
> > > >  		 * No need to write AT_XDMAC_CC reg, it will be done when the
> > > > @@ -568,7 +562,6 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > > >  	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > > >  	struct scatterlist	*sg;
> > > >  	int			i;
> > > > -	u32			cfg;
> > > >  	unsigned int		xfer_size = 0;
> > > >  
> > > >  	if (!sgl)
> > > > @@ -615,17 +608,17 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > > >  		if (direction == DMA_DEV_TO_MEM) {
> > > >  			desc->lld.mbr_sa = atchan->per_src_addr;
> > > >  			desc->lld.mbr_da = mem;
> > > > -			cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
> > > > +			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
> > > >  		} else {
> > > >  			desc->lld.mbr_sa = mem;
> > > >  			desc->lld.mbr_da = atchan->per_dst_addr;
> > > > -			cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
> > > > +			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
> > > >  		}
> > > > -		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1		/* next descriptor view */
> > > > -			| AT_XDMAC_MBR_UBC_NDEN				/* next descriptor dst parameter update */
> > > > -			| AT_XDMAC_MBR_UBC_NSEN				/* next descriptor src parameter update */
> > > > -			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)	/* descriptor fetch */
> > > > -			| len / (1 << at_xdmac_get_dwidth(cfg));	/* microblock length */
> > > > +		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1			/* next descriptor view */
> > > > +			| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
> > > > +			| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
> > > > +			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)		/* descriptor fetch */
> > > > +			| len / (1 << at_xdmac_get_dwidth(desc->lld.mbr_cfg));	/* microblock length */
> > > >  		dev_dbg(chan2dev(chan),
> > > >  			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
> > > >  			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
> > > > @@ -889,7 +882,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > >  	enum dma_status		ret;
> > > >  	int			residue;
> > > >  	u32			cur_nda, mask, value;
> > > > -	u8			dwidth = at_xdmac_get_dwidth(atchan->cfg[AT_XDMAC_CUR_CFG]);
> > > > +	u8			dwidth = 0;
> > > >  
> > > >  	ret = dma_cookie_status(chan, cookie, txstate);
> > > >  	if (ret == DMA_COMPLETE)
> > > > @@ -933,6 +926,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > >  	 */
> > > >  	descs_list = &desc->descs_list;
> > > >  	list_for_each_entry_safe(desc, _desc, descs_list, desc_node) {
> > > > +		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
> > > >  		residue -= (desc->lld.mbr_ubc & 0xffffff) << dwidth;
> > > >  		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
> > > >  			break;
> > > > @@ -1276,6 +1270,7 @@ static int atmel_xdmac_suspend(struct device *dev)
> > > >  	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
> > > >  		struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> > > >  
> > > > +		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
> > > okay finally we end us using the new field, the code before that seems to
> > > use existing lld.mbr_cfg, shouldnt this be another change explaining the
> > > changes...
> > 
> > This patch is not only about adding save_cc field but trying to simplify
> > the way cc register is managed. In my mind, both parts are tied, I have
> > added the save_cc field because I thought it is easier and probably
> > safer to do it in this way instead of relying on cfg[AT_XDMAC_CUR_CFG].
> > 
> > > 
> > > >  		if (at_xdmac_chan_is_cyclic(atchan)) {
> > > >  			if (!at_xdmac_chan_is_paused(atchan))
> > > >  				at_xdmac_device_pause(chan);
> > > > @@ -1298,7 +1293,6 @@ static int atmel_xdmac_resume(struct device *dev)
> > > >  	struct at_xdmac_chan	*atchan;
> > > >  	struct dma_chan		*chan, *_chan;
> > > >  	int			i;
> > > > -	u32			cfg;
> > > >  
> > > >  	clk_prepare_enable(atxdmac->clk);
> > > >  
> > > > @@ -1313,8 +1307,7 @@ static int atmel_xdmac_resume(struct device *dev)
> > > >  	at_xdmac_write(atxdmac, AT_XDMAC_GE, atxdmac->save_gs);
> > > >  	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
> > > >  		atchan = to_at_xdmac_chan(chan);
> > > > -		cfg = atchan->cfg[AT_XDMAC_CUR_CFG];
> > > > -		at_xdmac_chan_write(atchan, AT_XDMAC_CC, cfg);
> > > > +		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
> > > only thing here wer are saving and restoring from save_cc. How does that
> > > impact rest of the code above?
> this part is the only one which is clear. I think right way would be to
> split these changes and explain in each one why we are doing them. Down
> the line when someone is working on this will know precisely why this change
> was made. Two years is a long time, even we will forget. So good changelog
> and splitting patches to do just one thing is very helpful

I don't see why this patch should be split. The goal is to remove the
configuration register snapshot and to put it in the lli descriptor.
Because I am removing this snapshot, I have to update suspend/resume and
the way I have chosen is to directly get the value from the hardware
register. If it is a blocking point I'll split it. I think you want me
to put the addition of the save_cc field into another patches but I have
no reason to do it before patch 2 since I have not encountered any bug
yet (even if I think it is safer). And if I don't do it in patch 2,
suspend/resume will be broken.


About the commit message I could elaborate a bit more:

This patch simplifies the channel configuration register management.
Relying on a "software snapshot" of the configuration is not safe and
too complex.

Multiple dwidths will be introduced for slave transfers. In this case,
it becomes quite difficult to have an accurate snapshot of the channel
configuration register in the way it is done. Using the channel
configuration available in the lli descriptor simplifies this stuff.


Regards

Ludovic
