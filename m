From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 15 Jun 2016 22:11:31 +0530
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160615160837.64377829@free-electrons.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
 <20160615160837.64377829@free-electrons.com>
Message-ID: <20160615164131.GB16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 04:08:37PM +0200, Thomas Petazzoni wrote:
 
> > > +			(xor_dev->desc_size * desq_ptr));
> > > +
> > > +	memcpy(dest_hw_desc, &sw_desc->hw_desc, xor_dev->desc_size);
> > > +
> > > +	/* update the DMA Engine with the new descriptor */
> > > +	mv_xor_v2_add_desc_to_desq(xor_dev, 1);
> > > +
> > > +	/* unlock enqueue DESCQ */
> > > +	spin_unlock_bh(&xor_dev->push_lock);  
> > 
> > and if IIUC, you are pushing this to HW as well, that is not quite right if
> > thats the case. We need to do this in issue_pending
> 
> This is probably the only thing that I have not changed. The mv_xor
> driver is already using the same strategy, and enqueuing in
> issue_pending() would force us to add the request to a temporary linked
> list, which would be dequeued in issue_pending(). This is quite a bit
> of additional processing, while pushing the new requests directly to
> the engine works fine.

Well that is wrong! And patch is welcome for mv_xor as well :)

The DMAengine API mandates that we should submit a descriptor to a queue and
then push them by invoking issue_pending.

The users are also expected to follow this

-- 
~Vinod
