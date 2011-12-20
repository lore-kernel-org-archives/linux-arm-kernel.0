From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Dec 2011 15:41:17 +0000
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <CAB2ybb_dU7BzJmPo6vA92pe1YCNerCLc+bv7Qi_EfkfGaik6bQ@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112121648.52126.arnd@arndb.de>
 <CAB2ybb_dU7BzJmPo6vA92pe1YCNerCLc+bv7Qi_EfkfGaik6bQ@mail.gmail.com>
Message-ID: <201112201541.17904.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 December 2011, Semwal, Sumit wrote:
> I didn't see a consensus on whether dma_buf should enforce some form
> of serialization within the API - so atleast for v1 of dma-buf, I
> propose to 'not' impose a restriction, and we can tackle it (add new
> ops or enforce as design?) whenever we see the first need of it - will
> that be ok? [I am bending towards the thought that it is a problem to
> solve at a bigger platform than dma_buf.]

The problem is generally understood for streaming mappings with a 
single device using it: if you have a long-running mapping, you have
to use dma_sync_*. This obviously falls apart if you have multiple
devices and no serialization between the accesses.

If you don't want serialization, that implies that we cannot have
use the  dma_sync_* API on the buffer, which in turn implies that
we cannot have streaming mappings. I think that's ok, but then
you have to bring back the mmap API on the buffer if you want to
allow any driver to provide an mmap function for a shared buffer.

	Arnd
