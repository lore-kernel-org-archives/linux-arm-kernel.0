From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 17 Apr 2018 11:43:56 +0000
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <20180411090854.GY6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
Message-ID: <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Wednesday, April 11, 2018 2:39 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams at intel.com; michal.simek at xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars at metafoo.de; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
> words to netdev dma client
> 
> On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:
> 
> > +
> > +		if (chan->xdev->has_axieth_connected) {
> > +			seg = list_first_entry(&desc->segments,
> > +					struct xilinx_axidma_tx_segment,
> node);
> > +			if (cb.callback_param) {
> > +				app_w = (u32 *) cb.callback_param;
> 
> why are you interpreting callback_param? This is plainly wrong.
> we do not know what is the interpretation of callback_param and it is
> internal to submitter.
In design, if AXI DMA is connected to AXI Ethernet IP there are certain
AXI4-Stream Status fields (RX) that we need to pass to ethernet driver
along with data buffer. An example includes: checksum fields, packet
length etc. To pass these control words there is a structure defined
between dmaengine and client. Before calling the client callback
stream control words are copied to dma client callback_param struct
(only if axieth is connected).

I understand it's not an ideal way and we shouldn't be interpreting
callback_param but couldn't find any better alternative of passing
custom information from dmaengine to client driver and still be 
aligned to the framework.

> 
> What exactly is the problem you are trying to solve?
As mentioned above we need to pass AXI4-stream words(custom
data) from dmaengine driver to dma client driver(ethernet) for
each DMA descriptor. Current solution populates callback_param
struct (only if axieth is connected). Please let me know if there is
an alternate solution. 

> 
> > +				hw = &seg->hw;
> > +				*app_w = hw->status &
> XILINX_DMA_MAX_TRANS_LEN;
> > +				memcpy(app_w, hw->app, sizeof(u32) *
> > +					XILINX_DMA_NUM_APP_WORDS);
> > +			}
> 
> --
> ~Vinod
