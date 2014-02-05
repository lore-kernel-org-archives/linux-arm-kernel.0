From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Feb 2014 10:09:45 +0000
Subject: [PATCH v2 1/2] arm64: vdso: fix coarse clock handling
In-Reply-To: <1391579584-412-1-git-send-email-nathan_lynch@mentor.com>
References: <1391456932-17815-2-git-send-email-nathan_lynch@mentor.com>
 <1391579584-412-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140205100945.GA28623@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 05:53:04AM +0000, Nathan Lynch wrote:
> When __kernel_clock_gettime is called with a CLOCK_MONOTONIC_COARSE or
> CLOCK_REALTIME_COARSE clock id, it returns incorrectly to whatever the
> caller has placed in x2 ("ret x2" to return from the fast path).  Fix
> this by saving x30/LR to x2 only in code that will call
> __do_get_tspec, restoring x30 afterward, and using a plain "ret" to
> return from the routine.
> 
> Also: while the resulting tv_nsec value for CLOCK_REALTIME and
> CLOCK_MONOTONIC must be computed using intermediate values that are
> left-shifted by cs_shift (x12, set by __do_get_tspec), the results for
> coarse clocks should be calculated using unshifted values
> (xtime_coarse_nsec is in units of actual nanoseconds).  The current
> code shifts intermediate values by x12 unconditionally, but x12 is
> uninitialized when servicing a coarse clock.  Fix this by setting x12
> to 0 once we know we are dealing with a coarse clock id.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---

Thanks for the quick update Nathan!

  Acked-by: Will Deacon <will.deacon@arm.com>

Catalin: both of these are candidates for stable.

Will
