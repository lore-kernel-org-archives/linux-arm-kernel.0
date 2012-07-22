From: will.deacon@arm.com (Will Deacon)
Date: Sun, 22 Jul 2012 16:09:54 +0100
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <500BFF6B.3040602@xenomai.org>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
 <5009C26B.6080901@xenomai.org> <500AAC2B.5060300@xenomai.org>
 <20120721143517.GB26790@mudshark.cambridge.arm.com>
 <500ABF78.10208@xenomai.org> <500AC109.3060708@xenomai.org>
 <20120722130355.GA29138@mudshark.cambridge.arm.com>
 <500BFF6B.3040602@xenomai.org>
Message-ID: <20120722150954.GB29535@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 02:26:03PM +0100, Gilles Chanteperdrix wrote:
> On 07/22/2012 03:03 PM, Will Deacon wrote:
> > On Sat, Jul 21, 2012 at 03:47:37PM +0100, Gilles Chanteperdrix wrote:
> >> On 07/21/2012 04:40 PM, Gilles Chanteperdrix wrote:
> >>> On 07/21/2012 04:35 PM, Will Deacon wrote:
> >>>> It may be writable, but we never actually write to it after it has been
> >>>> initialised so there's no need to worry about caching issues (the cache is
> >>>> flushed in devicemaps_init).
> >>>
> >>> Except if CONFIG_TLS_REG_EMUL is enabled
> >>
> >> is disabled I mean.
> > 
> > Well spotted! I disagree about the address being flushed though -- it looks
> > to me like we flush from 0xffff0000 - 0xffff1000, which is what we want. Why
> > do you think we're flushing from the linear mapping?
> 
> I do not think we're flushing from the linear mapping, I believe the
> address used by the elf_core_dump function (elf_core_dump -> kmap ->
> page_address), to copy the page data to the core is the linear mapping
> address, which is the reason why we need the flush at all.

Ok, good, sounds like we're singing the same tune at last. If you're happy
with my proposed change to the original patch and Uros could re-test, then I
think we're in business again.

Cheers,

Will
