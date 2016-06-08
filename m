From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 8 Jun 2016 07:40:52 +0000
Subject: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <20160607070841.GJ16910@localhost>
References: <1464765839-29018-1-git-send-email-appanad@xilinx.com>
 <1464765839-29018-2-git-send-email-appanad@xilinx.com>
 <20160607070841.GJ16910@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review...

> 
> On Wed, Jun 01, 2016 at 12:53:59PM +0530, Kedareswara rao Appana wrote:
> > +config XILINX_ZYNQMP_DMA
> > +	tristate "Xilinx ZynqMP DMA Engine"
> > +	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> > +	select DMA_ENGINE
> > +	help
> > +	  Enable support for Xilinx ZynqMP DMA controller.
> 
> Kconfig and makefile is sorted alphabetically, pls update this

Ok Sure will fix in the next version...

> 
> > +#include <linux/bitops.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dma/xilinx_dma.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +#include <linux/clk.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> 
> do you really need so many headers?

Will remove unwanted header files in the next version...

> 
> > +static inline void zynqmp_dma_writeq(struct zynqmp_dma_chan *chan, u32
> reg,
> > +				     u64 value)
> > +{
> > +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
> > +	writeq(value, chan->regs + reg);
> > +#else
> > +	lo_hi_writeq(value, chan->regs + reg); #endif
> 
> why do you need this? can you explain..

writeq is available only on 64-bit platforms to make it work for every platform I have modified like this.
Will fix in the next version will use only lo_hi_writeq which is available across all the platforms.

> 
> > +static inline bool zynqmp_dma_chan_is_idle(struct zynqmp_dma_chan
> > +*chan) {
> > +	return chan->idle;
> > +
> 
> empty line not required

OK will fix...
> 
> 
> > +static void zynqmp_dma_desc_config_eod(struct zynqmp_dma_chan *chan,
> > +void *desc)
> 
> eod? 80 line?

It is exactly 80lines and check patch.pl didn't complained about it

> 
> 
> > +	val = 0;
> > +	if (chan->config.has_sg)
> > +		val |= ZYNQMP_DMA_POINT_TYPE_SG;
> 
> why not val = and get rid of assign to 0 above

Ok Will fix in the next version.

> 
> > +	writel(val, chan->regs + ZYNQMP_DMA_CTRL0);
> 
> okay why write 0 for no sg mode?

Ok will fix in the next version..

> 
> > +
> > +	val = 0;
> > +	if (chan->is_dmacoherent) {
> > +		val |= ZYNQMP_DMA_AXCOHRNT;
> > +		val = (val & ~ZYNQMP_DMA_AXCACHE) |
> > +			(ZYNQMP_DMA_AXCACHE_VAL <<
> ZYNQMP_DMA_AXCACHE_OFST);
> > +	}
> > +	writel(val, chan->regs + ZYNQMP_DMA_DSCR_ATTR);
> 
> same comments here too

Ok will fix in the next version..

> 
> > +	spin_lock_bh(&chan->lock);
> > +	desc = list_first_entry(&chan->free_list, struct zynqmp_dma_desc_sw,
> > +				 node);
> 
> how about:
> 
> 	desc = list_first_entry(&chan->free_list,
> 			struct zynqmp_dma_desc_sw, node);

Ok will fix...

> 
> > +	chan->desc_free_cnt++;
> > +	list_add_tail(&sdesc->node, &chan->free_list);
> > +	list_for_each_entry_safe(child, next, &sdesc->tx_list, node) {
> > +		chan->desc_free_cnt++;
> > +		INIT_LIST_HEAD(&child->tx_list);
> > +		list_move_tail(&child->node, &chan->free_list);
> > +	}
> > +	INIT_LIST_HEAD(&sdesc->tx_list);
> 
> why are you initializing list in free?

Will fix in the next version of the patch...

> 
> > +static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan) {
> > +	struct zynqmp_dma_chan *chan = to_chan(dchan);
> > +	struct zynqmp_dma_desc_sw *desc;
> > +	int i;
> > +
> > +	chan->sw_desc_pool = kzalloc(sizeof(*desc) *
> ZYNQMP_DMA_NUM_DESCS,
> > +				     GFP_KERNEL);
> > +	if (!chan->sw_desc_pool)
> > +		return -ENOMEM;
> 
> empty line here pls

Ok will fix...

> 
> > +static enum dma_status zynqmp_dma_tx_status(struct dma_chan *dchan,
> > +				      dma_cookie_t cookie,
> > +				      struct dma_tx_state *txstate) {
> > +	return dma_cookie_status(dchan, cookie, txstate);
> 
> why do you need this wrapper, assign dma_cookie_status as your status
> callback.

Ok will fix...

> 
> > +int zynqmp_dma_channel_set_config(struct dma_chan *dchan,
> > +				  struct zynqmp_dma_config *cfg)
> > +{
> > +	struct zynqmp_dma_chan *chan = to_chan(dchan);
> > +
> > +	chan->config.ovrfetch = cfg->ovrfetch;
> > +	chan->config.has_sg = cfg->has_sg;
> 
> is this HW capability? if so why would anyone not like to use it!

Yes it is HW capability. It can be either in simple mode or SG mode
Earlier In the driver this configuration is read from the device-tree 
But as per lars and your suggestion moved it as runtime config parameters.

> 
> > +	chan->config.ratectrl = cfg->ratectrl;
> > +	chan->config.src_issue = cfg->src_issue;
> > +	chan->config.src_burst_len = cfg->src_burst_len;
> > +	chan->config.dst_burst_len = cfg->dst_burst_len;
> 
> can you describe these parameters?
ratectl:
Rate control can be independently enabled per channel. When rate control is enabled, the
DMA channel uses the rate control count to schedule successive data read transactions.
src_issue:
Tells outstanding transaction on SRC.
Burst_len: 
Configures the burst length of the src and dst transfers...

> 
> How would a client know how to configure them?

With the default values of the config parameters driver will work.
If user has specific requirement to change these parameters they can pass
It to the driver using set_config API and all these parameters are
Documented in the include/linux/dma/xilinx_dma.h file...

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(zynqmp_dma_channel_set_config);
> 
> Not _GPL?

Ok will fix in the next version...

> 
> > +	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
> > +	chan->config.src_issue = ZYNQMP_DMA_SRC_ISSUE_RST_VAL;
> > +	chan->config.dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
> > +	chan->config.src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
> > +	err = of_property_read_u32(node, "xlnx,bus-width", &chan-
> >bus_width);
> > +	if ((err < 0) && ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
> > +			  (chan->bus_width !=
> ZYNQMP_DMA_BUS_WIDTH_128))) {
> > +		dev_err(zdev->dev, "invalid bus-width value");
> > +		return err;
> > +	}
> > +
> > +	chan->bus_width = chan->bus_width / 8;
> 
> ?
> 
> why not update it once?

Ok will fix in the next version...


Regards,
Kedar.
