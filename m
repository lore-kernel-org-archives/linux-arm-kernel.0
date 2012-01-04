From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 04 Jan 2012 19:17:49 +0530
Subject: [PATCH] dmaengine/dw_dmac: Add support for device_prep_dma_sg
In-Reply-To: <20120103134328.GR2914@n2100.arm.linux.org.uk>
References: <1323766064-13425-1-git-send-email-pratyush.anand@st.com>
 <1324655898.1633.11.camel@vkoul-udesk3> <4F0192F2.3010506@st.com>
 <1325503535.1540.17.camel@vkoul-udesk3>
 <20120103094048.GF2914@n2100.arm.linux.org.uk>
 <1325595816.1540.65.camel@vkoul-udesk3>
 <20120103134328.GR2914@n2100.arm.linux.org.uk>
Message-ID: <1325684869.1540.77.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-03 at 13:43 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 03, 2012 at 06:33:36PM +0530, Vinod Koul wrote:
> > On Tue, 2012-01-03 at 09:40 +0000, Russell King - ARM Linux wrote:
> > > Wait a moment.  This looks like a disaster waiting to happen.  The DMA
> > > engine code doesn't really handle the DMA API properly as it is - and
> > > that has lead to at least one recent oops report (and it still remains
> > > unresolved.)
> > > 
> > > The DMA API has the idea of buffer ownership: a buffer is either owned by
> > > the CPU, or the DMA device.  Only its owner may explicitly access the
> > > buffer.
> > > 
> > > Before a buffer can be used for DMA, it must be mapped to the DMA device
> > > (using dma_map_sg() or dma_map_single().)  Once this call returns, the
> > > mapping is setup and the CPU must not explicitly access the buffer until
> > > the buffer is unmapped via dma_unmap_sg() or dma_unmap_single().
wouldn't this cause issues with audio users of dmaengine API. They would
use DMA API to map the buffer and do a prepare (cyclic). And both cpu
and dma and accessing this?

> This is sub-optimal, because then you end up with:
> 
> - align_sg_list
> - map lists
> - prep_dma_sg
> - unmap lists
> - perform manual copy
> 
> which, if your map/unmap is non-trivial, means you take an unnecessary hit.
> 
> It would be much better if the dmaengine code exposed its alignment
> properties in such a way that:
> 
> (a) align_sg_list could be totally generic code
> (b) it can be found out whether the sg list can be handled by the DMA
>     engine
> 
> I'd also argue that align_sg_list() probably shouldn't even try to align
> a sg list - it should really just indicate whether the sg list _could_
> be handled by the DMA engine code or not.  (The case where the source
> and destination are identically mis-aligned is probably a rare corner
> case of the mis-aligned sg list.)
Yes, we could add something like dmaengine_check_align() which would
check if the given word alignment is supported by dmac or not.
Based on this peripheral driver can take a right decision on what needs
to be done.
Of-course, we would need controller to let dmaengine know the word
alignment constraints of the dmac.

-- 
~Vinod
