From: agross@codeaurora.org (Andy Gross)
Date: Fri, 7 Mar 2014 17:07:59 -0600
Subject: [Patch v8 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <531A485D.9010508@mm-sol.com>
References: <1393828245-18766-1-git-send-email-agross@codeaurora.org>
 <1393828245-18766-3-git-send-email-agross@codeaurora.org>
 <531A485D.9010508@mm-sol.com>
Message-ID: <20140307230759.GC3241@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 08, 2014 at 12:29:49AM +0200, Stanimir Vabanov wrote:
> > +#define BAM_IRQ_SRCS_EE(pipe)		(0x0800 + ((pipe) * 0x80))
> > +#define BAM_IRQ_SRCS_MSK_EE(pipe)	(0x0804 + ((pipe) * 0x80))
> 
> s/pipe/ee ?
> 

Ah good catch.  I'll fix that.

> > +struct bam_chan {
> > +	struct virt_dma_chan vc;
> > +
> > +	struct bam_device *bdev;
> > +
> > +	/* configuration from device tree */
> > +	u32 id;
> > +	u32 ee;
> > +
> 
> do we need per channel ee? I'm asking because failed to find references
> to it.
> 

You're right.  This is dead variable.  I had transitioned from channel to
device when I modified the bindings.  Device is where it belongs.  I'll fix
this.

<snip>
> > +
> > +/**
> > + * bam_alloc_chan - Allocate channel resources for DMA channel.
> > + * @chan: specified channel
> > + *
> > + * This function allocates the FIFO descriptor memory
> > + */
> > +static int bam_alloc_chan(struct dma_chan *chan)
> > +{
> > +	struct bam_chan *bchan = to_bam_chan(chan);
> > +	struct bam_device *bdev = bchan->bdev;
> > +
> 
> you could invert the logic and avoid extra indentation.
> 	if (bchan->fifo_virt)
> 		return 0;
> 

True.  I'll flip that.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
