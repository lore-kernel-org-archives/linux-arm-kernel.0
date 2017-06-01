From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu, 1 Jun 2017 10:25:44 -0500
Subject: [PATCHv2 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <20170531124430.GG9723@arm.com>
References: <20170531124430.GG9723@arm.com>
Message-ID: <87o9u7ybk7.fsf@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:
> On Tue, May 30, 2017 at 05:34:19PM -0700, Andrew Pinski wrote:
>> Note I noticed a bug in the old implementation of __kernel_clock_getres;
>> it was checking only the lower 32bits of the pointer; this would work
>> for most cases but could fail in a few.
>> 
>> Changes from v1:
>> * Fixed bug in __kernel_clock_getres for checking the pointer argument.
>> * Fix comments to refer to functions in arm64.

FWIW: despite asking around, I've never been able to determine the
original rationale for putting clock_getres in a vdso.  It seems like it
originated in powerpc and crept into other implementations.  I think
clock_getres should be dropped from new vdso implementations unless its
inclusion can be justified.


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

I was thinking something like CONFIG_GENERIC_VDSO that arches can opt
into over time makes sense.  But the generic code needs to be amenable
to being "sourced" by the arch code for multiple ABIs (compat, ILP32) in
a single build.

There are some additional (likely somewhat dated) considerations here,
from one of the arm vdso discusssions:

https://marc.info/?l=linux-arm-kernel&m=140972320130624&w=2
