From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Oct 2013 16:44:02 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2
 page fault
In-Reply-To: <CAAhSdy2nfnDuAZW6XWz0Xc4ehcU9YcHKLv7WVSCgk3+b8AD7Hw@mail.gmail.com>
References: <CAAhSdy0EZpzGOpVFOo-GWPs97XLHB8_uTZ7BTu0gP958y8JPeA@mail.gmail.com>
 <525667DB.7090705@arm.com> <20131010112425.GB21380@arm.com>
 <CAAhSdy20=U3+LZd=3i8dfqfSEaX7V+2z_y641NBLj7PkYZBadQ@mail.gmail.com>
 <20131011123839.GH12308@darko.cambridge.arm.com>
 <CAAhSdy1Sm2N68ZB5r9BmansGYnUgFO0ZFdUL=XB7RhJ258AAFA@mail.gmail.com>
 <20131011143721.GD15803@arm.com>
 <CAAhSdy1RS58HxDD2sKC5NP=vZ-fn=Zc4qEYZoFHR2usGqiQMFA@mail.gmail.com>
 <5258125E.4040709@arm.com>
 <CAAhSdy2nfnDuAZW6XWz0Xc4ehcU9YcHKLv7WVSCgk3+b8AD7Hw@mail.gmail.com>
Message-ID: <20131011154401.GE15803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 04:32:48PM +0100, Anup Patel wrote:
> On Fri, Oct 11, 2013 at 8:29 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 11/10/13 15:50, Anup Patel wrote:
> >> On Fri, Oct 11, 2013 at 8:07 PM, Catalin Marinas
> >> <catalin.marinas@arm.com> wrote:
> >>> On Fri, Oct 11, 2013 at 03:27:16PM +0100, Anup Patel wrote:
> >>>> On Fri, Oct 11, 2013 at 6:08 PM, Catalin Marinas
> >>>> <catalin.marinas@arm.com> wrote:
> >>>>> On Thu, Oct 10, 2013 at 05:09:03PM +0100, Anup Patel wrote:
> >>>>>> Coming back to where we started, the actual problem was that when
> >>>>>> Guest starts booting it sees wrong contents because it is runs with
> >>>>>> MMU disable and correct contents are still in external L3 cache of X-Gene.
> >>>>>
> >>>>> That's one of the problems and I think the easiest to solve. Note that
> >>>>> contents could still be in the L1/L2 (inner) cache since whole cache
> >>>>> flushing by set/way isn't guaranteed in an MP context.
> >>>>>
> >>>>>> How about reconsidering the approach of flushing Guest RAM (entire or
> >>>>>> portion of it) to PoC by VA once before the first run of a VCPU ?
> >>>>>
> >>>>> Flushing the entire guest RAM is not possible by set/way
> >>>>> (architecturally) and not efficient by VA (though some benchmark would
> >>>>> be good). Marc's patch defers this flushing when a page is faulted in
> >>>>> (at stage 2) and I think it covers the initial boot.
> >>>>>
> >>>>>> OR
> >>>>>> We can also have KVM API using which user space can flush portions
> >>>>>> of Guest RAM before running the VCPU. (I think this was a suggestion
> >>>>>> from Marc Z initially)
> >>>>>
> >>>>> This may not be enough. It indeed flushes the kernel image that gets
> >>>>> loaded but the kernel would write other pages (bss, page tables etc.)
> >>>>> with MMU disabled and those addresses may contain dirty cache lines that
> >>>>> have not been covered by the initial kvmtool flush. So you basically
> >>>>> need all guest non-cacheable accesses to be flushed.
> >>>>>
> >>>>> The other problems are the cacheable aliases that I mentioned, so even
> >>>>> though the guest does non-cacheable accesses with the MMU off, the
> >>>>> hardware can still allocate into the cache via the other mappings. In
> >>>>> this case the guest needs to invalidate the areas of memory that it
> >>>>> wrote with caches off (or just use the DC bit to force memory accesses
> >>>>> with MMU off to be cacheable).
> >>>>
> >>>> Having looked at all the approaches, I would vote for the approach taken
> >>>> by this patch.
> >>>
> >>> But this patch alone doesn't solve the other issues. OTOH, the DC bit
> >>> would solve your initial problem and a few others.
> >>
> >> DC bit might solve the initial problem but it can be problematic because
> >> setting DC bit would mean Guest would have Caching ON even when Guest
> >> MMU is disabled. This will be more problematic if Guest is running a
> >> bootloader (uboot, grub, UEFI, ..) which does pass-through access to a
> >> DMA-capable device and we will have to change the bootloader in this
> >> case and put explicit flushes in bootloader for running inside Guest.
> >
> > Well, as Catalin mentioned, we'll have to do some cache maintenance in
> > the guest in any case.
> 
> This would also mean that we will have to change Guest bootloader for
> running as Guest under KVM ARM64.

Yes.

> In x86 world, everything that can run natively also runs as Guest OS
> even if the Guest has pass-through devices.

I guess on x86 the I/O is also coherent, in which case we could use the
DC bit.

-- 
Catalin
