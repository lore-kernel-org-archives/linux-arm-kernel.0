From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jun 2013 19:29:25 +0100
Subject: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization
 framework
In-Reply-To: <CAAQKjZNJD4HpnJQ7iE+Gez36066M6U0YQeUEdA0+UcSOKqeghg@mail.gmail.com>
References: <20130617182127.GM2718@n2100.arm.linux.org.uk>
 <007301ce6be4$8d5c6040$a81520c0$%dae@samsung.com>
 <20130618084308.GU2718@n2100.arm.linux.org.uk>
 <008a01ce6c02$e00a9f50$a01fddf0$%dae@samsung.com>
 <1371548849.4276.6.camel@weser.hi.pengutronix.de>
 <008601ce6cb0$2c8cec40$85a6c4c0$%dae@samsung.com>
 <1371637326.4230.24.camel@weser.hi.pengutronix.de>
 <00ae01ce6cd9$f4834630$dd89d290$%dae@samsung.com>
 <1371645247.4230.41.camel@weser.hi.pengutronix.de>
 <CAAQKjZNJD4HpnJQ7iE+Gez36066M6U0YQeUEdA0+UcSOKqeghg@mail.gmail.com>
Message-ID: <20130619182925.GL2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 12:10:04AM +0900, Inki Dae wrote:
> On the other hand, the below shows how we could enhance the conventional
> way with my approach (just example):
> 
> CPU -> DMA,
>         ioctl(qbuf command)              ioctl(streamon)
>               |                                               |
>               |                                               |
>         qbuf  <- dma_buf_sync_get   start streaming <- syncpoint
> 
> dma_buf_sync_get just registers a sync buffer(dmabuf) to sync object. And
> the syncpoint is performed by calling dma_buf_sync_lock(), and then DMA
> accesses the sync buffer.
> 
> And DMA -> CPU,
>         ioctl(dqbuf command)
>               |
>               |
>         dqbuf <- nothing to do
> 
> Actual syncpoint is when DMA operation is completed (in interrupt handler):
> the syncpoint is performed by calling dma_buf_sync_unlock().
> Hence,  my approach is to move the syncpoints into just before dma access
> as long as possible.

What you've just described does *not* work on architectures such as
ARMv7 which do speculative cache fetches from memory at any time that
that memory is mapped with a cacheable status, and will lead to data
corruption.
