From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 16:55:00 +0900
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170123102314.GA16286@leverpostej>
References: <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
 <20170113081617.GI20972@linaro.org>
 <20170113113914.GB26804@leverpostej>
 <20170117082043.GM20972@linaro.org>
 <20170117115441.GC11939@leverpostej>
 <20170119094941.GP20972@linaro.org>
 <20170119112850.GD11176@leverpostej>
 <20170123095145.GA23406@linaro.org>
 <20170123102314.GA16286@leverpostej>
Message-ID: <20170124075458.GC23406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 10:23:15AM +0000, Mark Rutland wrote:
> On Mon, Jan 23, 2017 at 06:51:46PM +0900, AKASHI Takahiro wrote:
> > Mark,
> > 
> > On Thu, Jan 19, 2017 at 11:28:50AM +0000, Mark Rutland wrote:
> > > On Thu, Jan 19, 2017 at 06:49:42PM +0900, AKASHI Takahiro wrote:
> > > > On Tue, Jan 17, 2017 at 11:54:42AM +0000, Mark Rutland wrote:
> > > > > On Tue, Jan 17, 2017 at 05:20:44PM +0900, AKASHI Takahiro wrote:
> > > > > > On Fri, Jan 13, 2017 at 11:39:15AM +0000, Mark Rutland wrote:
> 
> > > > > I don't think we have much code useful for unmapping. We could re-use 
> > > > > create_mapping_late for this, passing a set of prot bits that means the
> > > > > entries are invalid (e.g. have a PAGE_KERNEL_INVALID).
> > > > 
> > > > Do you really think that we should totally invalidate mmu entries?
> > > > I guess that, given proper cache & TLB flush operations, RO attribute is
> > > > good enough for memory consistency, no?
> > > > (None accesses the region, as I said, except in the case of re-loading
> > > > crash dump kernel though.)
> > > 
> > > My worry is that the first kernel and kdump kernel may map (portions of)
> > > the region with potentially confliciting memory attributes. So it would
> > > be necessary to completely unmap the region.
> > 
> > I think that this can happen only if the second kernel boots up,
> > leaving non-crashed cpus still running for some reason.
> 
> Yes. I was considering a kdump case where a secondary was stuck in the
> first kernel.
> 
> > > You raise a good point that this would also mean we need to perform some
> > > cache maintenance, which makes that a little more painful. We'd need a
> > > sequence like:
> > > 
> > > * Unmap the region
> > > * TLB invalidation
> > > * Remap the region with non-cacheable attributes
> > > * Cache maintenance
> > > * Unmap the region
> > > * TLB invalidation
> > 
> > I don't get why we need to remap the region and do cache
> > maintenance here. Please elaborate a bit more?
> 
> I think I was wrong, and we don't need to. Sorry about that.
> 
> My thought was that to ensure that there aren't stale lines with
> differing attributes, we'd need to do a clean+invalidate while the
> caches are guaranteed to not allocate anything furthe. Hence, we'd need
> to use a non-cacheable mapping to perform the clean+invalidate.
> 
> However, I now think that so long as we unmap the range, this shouldn't
> matter. The new kernel can perform the maintenance if it wishes to use
> different attributes, similarly to what the first kernel must do per the
> boot protocol.
> 
> > My current implementation of arch_kexec_protect_crashkres() is:
> > 
> >         kexec_segment_flush(kexec_crash_image);
> >         create_mapping_late(crashk_res.start, ..., __pgprot(0));
> >                                                 or PAGE_KERNEL_INVALID
> >         flush_tlb_all();
> > 
> > kexec_segment_flush() will eventually do dcache-flush for all the modified
> > data in crash dump kernel memory.
> 
> I now think this should be fine, per the above.

OK.
I think that now I can see a light of the goal :)

-Takahiro AKASHI

> Thanks,
> Mark.
