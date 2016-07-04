From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jul 2016 18:12:51 +0100
Subject: [PATCH 1/2] arm64: Refactor vDSO time functions
In-Reply-To: <20160701134654.GA14829@e103592.cambridge.arm.com>
References: <1462797421-33103-1-git-send-email-kevin.brodsky@arm.com>
 <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
 <20160701134654.GA14829@e103592.cambridge.arm.com>
Message-ID: <20160704171251.GO1639@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:46:54PM +0100, Dave Martin wrote:
> On Mon, May 09, 2016 at 01:37:00PM +0100, Kevin Brodsky wrote:
> > Time functions are directly implemented in assembly in arm64, and it
> > is desirable to keep it this way for performance reasons (everything
> > fits in registers, so that the stack is not used at all). However, the
> > current implementation is quite difficult to read and understand (even
> > considering it's assembly).  Additionally, due to the structure of
> > __kernel_clock_gettime, which heavily uses conditional branches to
> > share code between the different clocks, it is difficult to support a
> > new clock without making the branches even harder to follow.
> > 
> > This commit completely refactors the structure of clock_gettime (and
> > gettimeofday along the way) while keeping exactly the same algorithms.
> > We no longer try to share code; instead, macros provide common
> > operations. This new approach comes with a number of advantages:
> > - In clock_gettime, clock implementations are no longer interspersed,
> >   making them much more readable. Additionally, macros only use
> >   registers passed as arguments or reserved with .req, this way it is
> >   easy to make sure that registers are properly allocated. To avoid a
> >   large number of branches in a given execution path, a jump table is
> >   used; a normal execution uses 3 unconditional branches.
> > - __do_get_tspec has been replaced with 2 macros (get_ts_clock_mono,
> >   get_clock_shifted_nsec) and explicit loading of data from the vDSO
> >   page. Consequently, clock_gettime and gettimeofday are now leaf
> >   functions, and saving x30 (lr) is no longer necessary.
> > - Variables protected by tb_seq_count are now loaded all at once,
> >   allowing to merge the seqcnt_read macro into seqcnt_check.
> > - For CLOCK_REALTIME_COARSE, removed an unused load of the wall to
> >   monotonic timespec.
> > - For CLOCK_MONOTONIC_COARSE, removed a few shift instructions.
> > 
> > Obviously, the downside of sharing less code is an increase in code
> > size. However since the vDSO has its own code page, this does not
> > really matter, as long as the size of the DSO remains below 4 kB. For
> > now this should be all right:
> >                     Before  After
> >   vdso.so size (B)  2776    2936
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Dave Martin <dave.martin@arm.com>
> > Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> I agree with Christopher that we shouldn't simply assume that code
> should stay in asm just because is was asm to begin with, but the
> refactoring seems reasonable here.

FWIW, we did do some benchmarking on a variety of microarchitectures
comparing the existing asm code with a version written in C. Whilst the
asm code tended to be a small amount faster in most cases, there were
some CPUs which showed a significant benefit from keeping things as they
are.

> There's no hard limit on the size of the vDSO AFAIK, but in any case
> the bloatation here is slight and the total number of clocks we'll ever
> support in the vDSO should be pretty small...
> 
> The code can always be ported to C later on if there's a compelling
> reason, and if the compiler is shown to do a good job on it.

One reason might be if we go down the route of offering a compat vdso,
but we'd also want to get to the bottom of any performance variations
as described above.

Will
