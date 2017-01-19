From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 19 Jan 2017 18:01:11 +0900
Subject: [PATCH v29 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20170117082629.GA7012@dhcp-128-65.nay.redhat.com>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043734.27535-1-takahiro.akashi@linaro.org>
 <20170112153944.GB12249@leverpostej>
 <20170113091339.GK20972@linaro.org>
 <20170113111756.GC26120@leverpostej>
 <20170116082505.GL20972@linaro.org>
 <20170117082629.GA7012@dhcp-128-65.nay.redhat.com>
Message-ID: <20170119090110.GO20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 04:26:29PM +0800, Dave Young wrote:
> On 01/16/17 at 05:25pm, AKASHI Takahiro wrote:
> > On Fri, Jan 13, 2017 at 11:17:56AM +0000, Mark Rutland wrote:
> > > On Fri, Jan 13, 2017 at 06:13:49PM +0900, AKASHI Takahiro wrote:
> > > > On Thu, Jan 12, 2017 at 03:39:45PM +0000, Mark Rutland wrote:
> > > > > On Wed, Dec 28, 2016 at 01:37:34PM +0900, AKASHI Takahiro wrote:
> > > > > > +linux,crashkernel-base
> > > > > > +linux,crashkernel-size
> > > > > > +----------------------
> > > > > > +
> > > > > > +These properties (currently used on PowerPC and arm64) indicates
> > > > > > +the base address and the size, respectively, of the reserved memory
> > > > > > +range for crash dump kernel.
> > > > > 
> > > > > From this description, it's not clear to me what the (expected)
> > > > > consumers of this property are, nor what is expected to provide it.
> > > > > 
> > > > > In previous rounds of review, I had assumed that this was used to
> > > > > describe a preference to the first kernel as to what region of memory
> > > > > should be used for a subsequent kdump kernel. Looking around, I'm not
> > > > > sure if I was correct in that assessment.
> > > > > 
> > > > > I see that arch/powerpc seems to consume this property to configure
> > > > > crashk_res, but it also rewrites it based on crashk_res, presumably for
> > > > > the benefit of userspace. It's not clear to me how on powerpc the kdump
> > > > > kernel knows its memory range -- is more DT modification done in the
> > > > > kernel and/or userspace?
> > > > 
> > > > I don't believe that powerpc will rewrite the property any way.
> > > > As far as I know from *the source code*, powerpc kernel retrieves
> > > > the memory range for crash dump kernel from a kernel command line, i.e.
> > > > crashkernel=, and then exposes it through DT to userspace (assuming
> > > > kexec-tools).
> > > 
> > > The rewriting I describe is in export_crashk_values() in
> > > arch/powerpc/kernel/machine_kexec.c, where the code deletes existing the
> > > properties, and adds new ones, to the DT exposed to userspace.
> > > 
> > > So I think we're just quibbling over the definition of "rewrite".
> > 
> > Gotcha
> > 
> > > > > arm64 we should either ensure that /proc/iomem is consistently usable
> > > > > (and have userspace consistently use it), or we should expose a new file
> > > > > specifically to expose this information.
> > > > 
> > > > The thing that I had in my mind when adding this property is that
> > > > /proc/iomem would be obsolete in the future, then we should have
> > > > an alternative in hand.
> > > 
> > > Ok.
> > > 
> > > My disagreement is with using the DT as a channel to convey information
> > > from the kernel to userspace.
> > > 
> > > I'm more than happy for a new file or other mechanism to express this
> > > information. For example, we could add
> > > /sys/kernel/kexec_crash_{base,size} or similar.
> > 
> > It may make sense because /sys/kernel/kexec_crash_size already exists,
> > so why not kexec_crash_base?
> > My concern, however, is that this kind of interface might prevent us from
> > allowing multiple regions to be reserved for crash dump kernel in the future.
> > (There is an assumption that we have only one region at least on arm64 though.)
> 
> In x86 there could be two ranges, one for softiotlb under 4G and another
> for range over 4G, but kexec_crash_size only shows the size of
> over-4g-range.
> 
> It is better to use /proc/iomem, most arches use /proc/iomem. Do you
> have any reason why it will be obsolete? At least for the time being it
> is fine.

I don't know.
I just think that I might have seen that someone said so somewhere
and that more _powerful_ (structured) tool could supersede it :)

-Takahiro AKASHI

> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > 
> > > > > Further, I do not think we need this property. It makes more sense to me
> > > > > for the preference of a a region to be described to the *first* kernel
> > > > > using the command line consistently.
> > > > > 
> > > > > So I think we should drop this property, and not use it on arm64. Please
> > > > > document this as powerpc only.
> > > > 
> > > > OK, but if we drop the property from arm64 code, we have no reason
> > > > to leave its description in this patch.
> > > > (In fact, there are a few more (undocumented) properties that only ppc
> > > > uses for kdump.)
> > > 
> > > I'm happy to drop it, then.
> > > 
> > > > > > +linux,usable-memory-range
> > > > > > +-------------------------
> > > > > > +
> > > > > > +This property (currently used only on arm64) holds the memory range,
> > > > > > +the base address and the size, which can be used as system ram on
> > > > > > +the *current* kernel. Note that, if this property is present, any memory
> > > > > > +regions under "memory" nodes in DT blob or ones marked as "conventional
> > > > > > +memory" in EFI memory map should be ignored.
> > > > > 
> > > > > Could you please replace this with:
> > > > > 
> > > > >   This property (arm64 only) holds a base address and size, describing a
> > > > >   limited region in which memory may be considered available for use by
> > > > >   the kernel. Memory outside of this range is not available for use.
> > > > >   
> > > > >   This property describes a limitation: memory within this range is only
> > > > >   valid when also described through another mechanism that the kernel
> > > > >   would otherwise use to determine available memory (e.g. memory nodes
> > > > >   or the EFI memory map). Valid memory may be sparse within the range.
> > > > 
> > > > Sure.
> > > 
> > > Cheers!
> > > 
> > > Thanks,
> > > Mark.
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
