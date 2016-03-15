From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 15 Mar 2016 09:10:22 +0000
Subject: [PATCH] dmaengine: pl330: Fix some race conditions in residue
 calculation
In-Reply-To: <20160311074328.GU11154@localhost>
References: <1456319674.2867.15.camel@linaro.org>
 <20160308041238.GL11154@localhost> <1457433611.2818.83.camel@linaro.org>
 <20160308141551.GP11154@localhost> <1457452241.2818.128.camel@linaro.org>
 <20160311074328.GU11154@localhost>
Message-ID: <1458033022.2823.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-11 at 13:13 +0530, Vinod Koul wrote:
> On Tue, Mar 08, 2016 at 03:50:41PM +0000, Jon Medhurst (Tixy) wrote:
> 
> > > The reside is requested for "a descriptor". For example if you have prepared
> > > two descriptors A and B and submitted them, then you can request status and
> > > reside for A and you need to calculate that for A only and not take into
> > > account status of B
> > 
> > But, in the case of the pl330 driver, A and B may each consist of
> > multiple internal/hidden descriptors. So the residue calculation has to
> > sum up the residue of all these internal/hidden descriptors as well.
> > This is what the current pl330_tx_status() function does, but has bugs.
> > 
> > I've only just managed to clearly understand all the above details
> > whilst writing this email, and this confusion obviously means the code
> > and any commit messages need to explain things better.
> 
> Okay I relooked at the code, the driver is creating descriptor per period,
> so yes while calculating that should be taken into account but only for
> cyclic case and not for rest, as it will break reside values for for them.

So not for scatter gather lists passed to pl330_prep_slave_sg? It seems
to me, that as for the cyclic case, the descriptors used for each
element in the list are equally internal to the pl330 driver and not
exposed to users.

pl330_tx_submit() only returns the cookie for the last descriptor, how
do users get the cookies for the other elements so they can pass them to
pl330_tx_status()?

To me, the implementation of the pl330 driver looks consistent with the
APIs I can see in header files and the Documentation directory, namely:

- dmaengine_prep_* functions prepare a DMA transactions and return
  a descriptor (struct dma_async_tx_descriptor)

- The transaction is queued for processing by passing that descriptor to
  dmaengine_submit() which returns 'cookie' (dma_cookie_t)

- The current status of a transaction can be queried by passing it's
  cookie to dmaengine_tx_status

Now, I've never looked at DMA API's or their working before I started
investigating the bug I'm trying to fix, so I may very well have missed
something. 

In fact, the more I look, the more uncertain I am. From
Documentation/dmaengine/provider.txt it describes:

   * device_tx_status
     - Should report the bytes left to go over on the given channel
     - Should only care about the transaction descriptor passed as
       argument, not the currently active one on a given channel
     - The tx_state argument might be NULL
     - Should use dma_set_residue to report it
     - In the case of a cyclic transfer, it should only take into
       account the current period.

So that's saying residue for cyclic transfers residue is only for the
current period?

I tried looking at other DMA drivers for inspiration, and it seems that
some at least (e.g. drivers/dma/mmp_pdma.c) do things the same way as
pl330, but that could just be a case of people copying broken code.

-- 
Tixy
