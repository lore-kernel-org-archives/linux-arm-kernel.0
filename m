From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Oct 2014 13:57:44 +0000
Subject: [PATCH V2] arm64: xchg: Implement cmpxchg_double
In-Reply-To: <1414153340-19552-1-git-send-email-steve.capper@linaro.org>
References: <1413374323-2062-1-git-send-email-steve.capper@linaro.org>
 <1414153340-19552-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20141028135744.GB29706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:22:20PM +0100, Steve Capper wrote:
> The arm64 architecture has the ability to exclusively load and store
> a pair of registers from an address (ldxp/stxp). Also the SLUB can take
> advantage of a cmpxchg_double implementation to avoid taking some
> locks.
> 
> This patch provides an implementation of cmpxchg_double for 64-bit
> pairs, and activates the logic required for the SLUB to use these
> functions (HAVE_ALIGNED_STRUCT_PAGE and HAVE_CMPXCHG_DOUBLE).
> 
> Also definitions of this_cpu_cmpxchg_8 and this_cpu_cmpxchg_double_8
> are wired up to cmpxchg_local and cmpxchg_double_local (rather than the
> stock implementations that perform non-atomic operations with
> interrupts disabled) as they are used by the SLUB.
> 
> On a Juno platform running on only the A57s I get quite a noticeable
> performance improvement with 5 runs of hackbench on v3.17:
> 
>          Baseline | With Patch
>  -----------------+-----------
>  Mean    119.2312 | 106.1782
>  StdDev    0.4919 |   0.4494
> 
> (times taken to complete `./hackbench 100 process 1000', in seconds)
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V2, added the this_cpu_cmpxchg* definitions, these are used
> by the fast path of the SLUB (without this our hackbench mean goes up
> to 111.9 seconds).
> Cheers Liviu for pointing out this ommission!
> 
> The performance measurements were taken against a newer kernel running
> on a board with newer firmware, thus the baseline is faster than the
> one posted in V1.
> ---
>  arch/arm64/Kconfig               |  2 ++
>  arch/arm64/include/asm/cmpxchg.h | 71 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)

Thanks Steve, I'll queue this for 3.19.

On a related note, I spoke to Christoph at kernel summit and we decided that
we should have a go at implementing all of the per-cpu atomics using the atomic
instructions, as this is likely to be quicker than disabling interrupts,
especially since we don't require any barrier semantics.

Is that something you think you'll have a chance to look at, or shall I keep
it on my list?

Cheers,

Will
