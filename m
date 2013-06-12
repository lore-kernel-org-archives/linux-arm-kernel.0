From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Jun 2013 15:35:42 +0530
Subject: MUSB multiplatform work?
In-Reply-To: <CACRpkdaUegc7B8awUiQTvFRJHPMWv6hEEsE-2AHtZCDXVEMN9g@mail.gmail.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <CACRpkdZHupVFS+pNADpaJjunPa3fEtyCqLwbL-etHs3gt8EW0Q@mail.gmail.com>
 <20130530203132.GC6467@atomide.com>
 <CACRpkdaUegc7B8awUiQTvFRJHPMWv6hEEsE-2AHtZCDXVEMN9g@mail.gmail.com>
Message-ID: <20130612100542.GV4107@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 11:19:33PM +0200, Linus Walleij wrote:
> On Thu, May 30, 2013 at 10:31 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > There are many devices where the device FIFO is memory mapped to the
> > GPMC bus on omaps, like TUSB, OneNAND, smc911x etc. I believe the
> > only reason why these have not been converted to the dmaengine is
> > the fact that dmaengine cannot configure the DMA hardware to do
> > autoincrement and loop over the device FIFO.
> 
> OK that seems like something pretty generic that we could just add
> to the struct dma_slave_config actually, something like:
> 
> u32 src_fifoloop;
> u32 dst_fifoloop;
Yes for genric but not for loop. For most of our cases we are considering the
FIFO address as a constant. Typically DMA controllers have this ability to
perform incremental/decremental/constant FIFO address.

What would make sense to have is:

enum dmaengine_slave_addr_mode {
	DMAENGINE_SLAVE_ADDR_CONSTANT = 0,
	DMAENGINE_SLAVE_ADDR_INCREMANT,
	DMAENGINE_SLAVE_ADDR_DECREMENT,
};

and add these to struct dma_slave_config:
	enum dmaengine_slave_addr_mode src_mode;
	enum dmaengine_slave_addr_mode dstn_mode;

For loopover we can have:
	u32 loop_counter;

on 0 means no loop, and valid value tells when to loopover (offset).

will this help for all of the above controllers and their conversion?
 
> Given in # of words on the src/dst address simply, left as zero
> for hitting a constant address over and over again.
> 
> We'd need both to make space for device->device transfers.
> 
> If this is all that is needed to convert them do DMAengine
> I'd surely ACK it (FWIW).

--
~Vinod
