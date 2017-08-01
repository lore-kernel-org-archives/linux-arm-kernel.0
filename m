From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 1 Aug 2017 11:30:11 +0200
Subject: [PATCHv2 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <20170531124430.GG9723@arm.com>
References: <1496190860-5116-1-git-send-email-apinski@cavium.com>
 <20170531124430.GG9723@arm.com>
Message-ID: <20170801093011.GC18024@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On 31.05.17 13:44:30, Will Deacon wrote:
> Thanks for posting this, but please try to cc the maintainers in future -- I
> almost missed it!
> 
> On Tue, May 30, 2017 at 05:34:19PM -0700, Andrew Pinski wrote:
> > This allows the compiler to optimize the divide by 1000.
> > And remove the other divide.
> > 
> > On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
> > gettimeofday improves by 18%.
> > 
> > Note I noticed a bug in the old implementation of __kernel_clock_getres;
> > it was checking only the lower 32bits of the pointer; this would work
> > for most cases but could fail in a few.
> > 
> > Changes from v1:
> > * Fixed bug in __kernel_clock_getres for checking the pointer argument.
> > * Fix comments to refer to functions in arm64.
> 
> I tested this patch on a few platforms I have access to and didn't see the
> perf regressions I saw when I looked at this in the past with an older
> toolchain (it was mostly about the same, with a couple of improvements).
> 
> So, in principle, I'm not opposed to moving this into C. However, we're
> currently close to a "vDSO-explosion" on arm64 with people wanting a compat
> variant and also an ILP32 variant. When Kevin posted his compat variant
> (also in C):
> 
>   http://lkml.kernel.org/r/20161206160353.14581-1-kevin.brodsky at arm.com

from a technical pov there are no issues in a convertion to C. Since
this fixes bad syscall performance and an alternative solution as
pointed out here is not in sight very soon, would you be willing to
get this series upstream. Should we update to latest kernel and resend
the patches for v4.14?

Thanks,

-Robert

> 
> Nathan (who apparently needs to set his mail host address ;) was concerned
> about duplication between arm and arm64:
> 
>   http://lkml.kernel.org/r/87r35jmv3e.fsf at wedge.i-did-not-set--mail-host-address--so-tickle-me
> 
> I'm firmly of the opinion that we should try to write an arch-agnostic vDSO
> implementation in core code (lib/vdso or something) where the arch header
> provides things like:
> 
>   * The mechanism to read the counter
>   * The mechanism to issue a syscall
>   * A function to determine whether or not the current clocksource is
>     suitable
> 
> I think the datapage format could be defined in core code and it would be
> worth looking to see how much the virtual mapping code can be consolidated
> too.
> 
> If we can get something that works for arm native, arm64 native, arm64
> compat and arm64 ilp32 then it's probably going to be useful for other
> architectures too, even if we need to add more customisation points in
> future.
> 
> I've spoken to Kevin about this, but I'm not sure whether he's had a chance
> to look at knocking up a prototype. A first stab could just unconditionally
> fallback to the system call.
> 
> Will
