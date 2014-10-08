From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Oct 2014 17:37:57 +0530
Subject: [PATCH v2 2/2] Documentation: dmaengine: Add a documentation
 for the dma controller API
In-Reply-To: <20141007145226.GA17925@lukather>
References: <1411746035-15882-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411746035-15882-2-git-send-email-maxime.ripard@free-electrons.com>
 <7725507.nuHj4C7OxF@avalon> <5433D9AF.8020508@atmel.com>
 <20141007145226.GA17925@lukather>
Message-ID: <20141008120757.GT1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 04:52:26PM +0200, Maxime Ripard wrote:
> > >> +Moreover, some DMA controllers, whenever the RAM is involved, can
> > > 
> > > s/the RAM is involved/RAM is used as a source or destination/ ?
> > > 
> > >> +group the reads or writes in memory into a buffer, so instead of
> > >> +having a lot of small memory accesses, which is not really efficient,
> > >> +you'll get several bigger transfers. This is done using a parameter
> > >> +called the burst size, that defines how many single reads/writes it's
> > >> +allowed to do in a single clock cycle.
> > 
> > Yes, here "single" word is used for different concepts and can have
> > several meanings. We usually make the difference between "single"
> > accesses and "burst" accesses.
> 
> Which was kind of what I was explaining, but it was probably not clear
> enough.
The burst can be in multiple clock cycles as well, so any reference to
clocks may not be right across various dma controllers.

Generically burst size is defined as a chunk of data transfer dma
controller would perform in single shot (may happen in 1 or multiple clock
cycles). The dma controller won't break this.

This has a very special meaning wrt slave usages as it involves FIFO (not
much of importance in memory copy ops where you want max burst for
performance). DMA transfer should not push data more than FIFO capacity,
ditto for pull as well.

Consider FIFO of 16 data items (beware not bytes), and burst being 8 and
watermark 8. So we will transfer 8 then 8 and so on.. ensures FIFO is
typically full or half.

> > >> +         + DMA_TERMINATE_ALL
> > >> +           + Aborts all the pending and ongoing transfers on the
> > >> +             channel
> > >> +           + This command should operate synchronously on the channel,
> > >> +             terminating right away all the channels
> > 
> > Is it a strong requirement to "terminate right away" all the transfers
> > on the channel? Must the ongoing transfer be stopped of can it ends its
> > current chunk?
> 
> Since it's blocking, I guess it's fine to wait for the current chunk
> to end as long as you block. But I'm not 100% sure on that. Russell? Vinod?
Typically terminate_all would be called in error or timeout scenario. So
current transfer may not complete, so aborting right away would be the right
approach


-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/a4a6e279/attachment.sig>
