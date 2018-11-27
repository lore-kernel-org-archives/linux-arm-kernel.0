From: Brian.Starkey@arm.com (Brian Starkey)
Date: Tue, 27 Nov 2018 10:35:52 +0000
Subject: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
Message-ID: <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liam,

On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> On Tue, 20 Nov 2018, Brian Starkey wrote:
> 
> > Hi Liam,
> > 
> > I'm missing a bit of context here, but I did read the v1 thread.
> > Please accept my apologies if I'm re-treading trodden ground.
> > 
> > I do know we're chasing nebulous ion "problems" on our end, which
> > certainly seem to be related to what you're trying to fix here.
> > 
> > On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> > >Based on the suggestions from Laura I created a first draft for a change
> > >which will attempt to ensure that uncached mappings are only applied to
> > >ION memory who's cache lines have been cleaned.
> > >It does this by providing cached mappings (for uncached ION allocations)
> > >until the ION buffer is dma mapped and successfully cleaned, then it
> > drops
> > >the userspace mappings and when pages are accessed they are faulted back
> > >in and uncached mappings are created.
> > 
> > If I understand right, there's no way to portably clean the cache of
> > the kernel mapping before we map the pages into userspace. Is that
> > right?
> > 
> 
> Yes, it isn't always possible to clean the caches for an uncached mapping 
> because a device is required by the DMA APIs to do cache maintenance and 
> there isn't necessarily a device available (dma_buf_attach may not yet 
> have been called).
> 
> > Alternatively, can we just make ion refuse to give userspace a
> > non-cached mapping for pages which are mapped in the kernel as cached?
> 
> These pages will all be mapped as cached in the kernel for 64 bit (kernel 
> logical addresses) so you would always be refusing to create a non-cached mapping.

And that might be the sane thing to do, no?

AFAIK there are still pages which aren't ever mapped as cached (e.g.
dma_declare_coherent_memory(), anything under /reserved-memory marked
as no-map). If those are exposed as an ion heap, then non-cached
mappings would be fine, and permitted.

> 
> > Would userspace using the dma-buf sync ioctl around its accesses do
> > the "right thing" in that case?
> > 
> 
> I don't think so, the dma-buf sync ioctl require a device to peform cache 
> maintenance, but as mentioned above a device may not be available.
> 

If a device didn't attach yet, then no cache maintenance is
necessary. The only thing accessing the memory is the CPU, via a
cached mapping, which should work just fine. So far so good.

If there are already attachments, then ion_dma_buf_begin_cpu_access()
will sync for CPU access against all of the attached devices, and
again the CPU should see the right thing.

In the other direction, ion_dma_buf_end_cpu_access() will sync for
device access for all currently attached devices. If there's no
attached devices yet, then there's nothing to do until there is (only
thing accessing is CPU via a CPU-cached mapping).

When the first (or another) device attaches, then when it maps the
buffer, the map_dma_buf callback should do whatever sync-ing is needed
for that device.

I might be way off with my understanding of the various DMA APIs, but
this is how I think they're meant to work.

> > Given that as you pointed out, the kernel does still have a cached
> > mapping to these pages, trying to give the CPU a non-cached mapping of
> > those same pages while preserving consistency seems fraught. Wouldn't
> > it be better to make sure all CPU mappings are cached, and have CPU
> > clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> > consistency where needed?
> > 
> 
> It is fraught, but unfortunately you can't rely on 
> dma_buf_{begin,end}_cpu_access() to do cache maintenance as these calls 
> require a device, and a device is not always available.

As above, if there's really no device, then no syncing is needed
because only the CPU is accessing the buffer, and only ever via cached
mappings.

> 
> > >
> > >This change has the following potential disadvantages:
> > >- It assumes that userpace clients won't attempt to access the buffer
> > >while it is being mapped as we are removing the userpspace mappings at
> > >this point (though it is okay for them to have it mapped)
> > >- It assumes that kernel clients won't hold a kernel mapping to the
> > buffer
> > >(ie dma_buf_kmap) while it is being dma-mapped. What should we do if
> > there
> > >is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> > >- There may be a performance penalty as a result of having to fault in
> > the
> > >pages after removing the userspace mappings.
> > 
> > I wonder if the dma-buf sync ioctl might provide a way for userspace
> > to opt-in to when the zap/fault happens. Zap on (DMA_BUF_SYNC_WRITE |
> > DMA_BUF_SYNC_WRITE_END) and fault on (DMA_BUF_SYNC_READ |
> > DMA_BUF_SYNC_START)
> > 
> 
> Not sure I understand, can you elaborate. 
> Are you also adding a requirment that ION pages can't be mmaped during a
> call to dma_buf_map_attachment?

I was only suggesting that zapping the mappings "at random" (from
userspace's perspective), and then faulting them back in (also "at
random"), might cause unexpected and not-controllable stalls in the
app. We could use the ioctl hooks as an explicit indication from the
app that now is a good time to zap the mapping and/or fault back in
the whole buffer. begin_cpu_access is allowed to be a "slow"
operation, so apps should already be expecting to get stalled on the
sync ioctl.

Cheers,
-Brian

> 
> > >
> > >It passes basic testing involving reading writing and reading from
> > >uncached system heap allocations before and after dma mapping.
> > >
> > >Please let me know if this is heading in the right direction and if there
> > >are any concerns.
> > >
> > >Signed-off-by: Liam Mark <lmark@codeaurora.org>
> > >---
> > > drivers/staging/android/ion/ion.c | 146
> > +++++++++++++++++++++++++++++++++++++-
> > > drivers/staging/android/ion/ion.h |   9 +++
> > > 2 files changed, 152 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/drivers/staging/android/ion/ion.c
> > b/drivers/staging/android/ion/ion.c
> > >index 99073325b0c0..3dc0f5a265bf 100644
> > >--- a/drivers/staging/android/ion/ion.c
> > >+++ b/drivers/staging/android/ion/ion.c
> > >@@ -96,6 +96,7 @@ static struct ion_buffer *ion_buffer_create(struct
> > ion_heap *heap,
> > > 	}
> > >
> > > 	INIT_LIST_HEAD(&buffer->attachments);
> > >+	INIT_LIST_HEAD(&buffer->vmas);
> > > 	mutex_init(&buffer->lock);
> > > 	mutex_lock(&dev->buffer_lock);
> > > 	ion_buffer_add(dev, buffer);
> > >@@ -117,6 +118,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
> > > 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
> > > 	}
> > > 	buffer->heap->ops->free(buffer);
> > >+	vfree(buffer->pages);
> > > 	kfree(buffer);
> > > }
> > >
> > >@@ -245,11 +247,29 @@ static void ion_dma_buf_detatch(struct dma_buf
> > *dmabuf,
> > > 	kfree(a);
> > > }
> > >
> > >+static bool ion_buffer_uncached_clean(struct ion_buffer *buffer)
> > >+{
> > >+	return buffer->uncached_clean;
> > >+}
> > 
> > nit: The function name sounds like a verb to me - as in "calling this
> > will clean the buffer". I feel ion_buffer_is_uncached_clean() would
> > read better.
> > 
> 
> Yes, that would be cleaner.
> 
> Liam
> 
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
