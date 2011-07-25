From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 25 Jul 2011 21:34:27 +0900
Subject: [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <20110725103629.GF9653@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
	<20110725092749.GB9653@n2100.arm.linux.org.uk>
	<002001cc4ab6$0d7cd590$287680b0$%kim@samsung.com>
	<20110725103629.GF9653@n2100.arm.linux.org.uk>
Message-ID: <002201cc4ac7$319f1bc0$94dd5340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux Wrote:
> Sent: Monday, July 25, 2011 7:36 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; 'Kukjin Kim'; 'Vinod Koul'; 'Jassi Brar'; 'Grant
> Likely'; 'Mark Brown'; 'Dan Williams'
> Subject: Re: [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
>
> On Mon, Jul 25, 2011 at 07:31:45PM +0900, Boojin Kim wrote:
> > > On Mon, Jul 25, 2011 at 10:28:22AM +0900, Boojin Kim wrote:
> > > > +static void pl330_tasklet_cyclic(unsigned long data)
> > > > +{
> > > > +	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> > > > +	struct dma_pl330_desc *desc, *_dt;
> > > > +	unsigned long flags;
> > > > +	LIST_HEAD(list);
> > > > +
> > > > +	spin_lock_irqsave(&pch->lock, flags);
> > > ...
> > > > +			callback = desc->txd.callback;
> > > > +			if (callback)
> > > > +				callback(desc->txd.callback_param);
> > >
> > > On this again - what if the callback wants to terminate the DMA
> activity
> > > because there's no more audio data to be sent/received from the
> device?
> >
> > Do you mean what is happened if the callback() is called after
> channel is
> > terminated ?
> > Or What is happened if Callback() calls 'dma_release_channel()' to
> terminate
> > DMA?
>
> No.  I mean what if the callback wants to call
> dmaengine_terminate_all().
I found the deadlock problem that you and Vinod post. I will fix it.

>
> > > > +	if (!pch->cyclic_task) {
> > > > +		pch->cyclic_task =
> > > > +			kmalloc(sizeof(struct tasklet_struct),
> GFP_KERNEL);
> > > > +		tasklet_init(pch->cyclic_task,
> > > > +			pl330_tasklet_cyclic, (unsigned int)pch);
> > >
> > > Here you allocate memory for the cyclic task.  Above you set this
> pointer
> > > to NULL.  That sounds like a memory leak to me.  Why are you
> kmallocing
> > > this memory - why can't it be part of the dma_pl330_chan structure?
> It's
> > > only 28 bytes.
> >
> > It's my mistake. I should have been free of the memory.
> >
> > And the reason why I use kmalloc for 'cyclic_task' is following.
> > This memory size for 'cyclic_tasklet' is the 896 bytes ( = the
> number of
> > channel * sizeof(struct tasklet_struct)= 32*28) for each DMAC. And
> This
> > memory size is increased according to the number of DMAC.
> > And Samsung has the DMAC that is dedicated for Mem-to-Mem operation.
> If I
> > make 'cyclic_task' be part of dma_pl330_chan, this DMAC that is
> dedicated
> > for Mem-to-Mem operation should hold unused data.
> > So, I think it's loss that all dma channels hold own 'cyclic_task'.
>
> Could you re-use the tasklet that already exists?
Yes, It can be re-used. But, This tasklet should be initialized on each
request by using 'tasklet_init()' because it needs the own channel as its
parameter.
