From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Sep 2014 21:27:16 +0530
Subject: [PATCH v3 2/2] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <CA+mB=1KarJGUYTZu=2k46gqt3oMAuYawfq+H=Lxa7YVqcThjCw@mail.gmail.com>
References: <1406549869-24422-1-git-send-email-sthokal@xilinx.com>
 <1406549869-24422-2-git-send-email-sthokal@xilinx.com>
 <20140819170346.GS13288@intel.com>
 <CA+mB=1L14Os=ZdJzj8_+XXa+oq4ZOS_kadQHpKQ2yws2tqGVSQ@mail.gmail.com>
 <20140904063613.GD1610@intel.com>
 <CA+mB=1KarJGUYTZu=2k46gqt3oMAuYawfq+H=Lxa7YVqcThjCw@mail.gmail.com>
Message-ID: <20140909155716.GN1610@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 12:52:16AM +0530, Srikanth Thokala wrote:
> Hi Vinod,
> 
> On Thu, Sep 4, 2014 at 12:06 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Sep 03, 2014 at 12:17:43PM +0530, Srikanth Thokala wrote:
> >> Hi Vinod,
> >>
> >> Apologies for the delay.
> >>
> >> On Tue, Aug 19, 2014 at 10:33 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> >> > On Mon, Jul 28, 2014 at 05:47:49PM +0530, Srikanth Thokala wrote:
> >> >> +struct xilinx_dma_chan {
> >> >> +     struct xilinx_dma_device *xdev;
> >> >> +     u32 ctrl_offset;
> >> >> +     spinlock_t lock;
> >> >> +     struct list_head pending_list;
> >> >> +     struct xilinx_dma_tx_descriptor *active_desc;
> >> >> +     struct xilinx_dma_tx_descriptor *allocated_desc;
> >> >> +     struct list_head done_list;
> >> >> +     struct list_head free_seg_list;
> >> >> +     struct dma_chan common;
> >> >> +     struct xilinx_dma_tx_segment *seg_v;
> >> >> +     dma_addr_t seg_p;
> >> >> +     struct device *dev;
> >> >> +     int irq;
> >> >> +     int id;
> >> >> +     enum dma_transfer_direction direction;
> >> > This looks suspect. Why should channel have direction, for a descriptor it
> >> > makes sense though.
> >>
> >> The channel only supports transfers in one direction. Either from memory to
> >> peripheral or from peripheral to memory, that's fixed and can't be changed
> >> at runtime.  So, the driver needs to know which direction the channel supports
> >> and hence it can reject transfers with the wrong direction.
> > But you already have this information in descriptor so why duplicate?
> 
> Our descriptor doesn't have the information of channel direction, we have this
> information only in the chan structure (struct xilinx_dma_chan) which
> is populated
> while parsing the DT.  So, we use this information to ensure if we are servicing
> proper channel (in prep_slave_sg call).
One of the argument of prep_slave_sg call is direction. You need to use that
and store in in your descriptor for using it afterwards

> FYI: We also need the direction of the channel so that we can select SRC/DST
> register address in the issue_pending() call.
And you have the descriptor there as well so can use it

-- 
~Vinod
