From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 24 Jul 2018 11:20:36 +0200
Subject: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
In-Reply-To: <20180724071518.GA7300@gmail.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
Message-ID: <20180724092036.GN2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:15:18AM +0200, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > working after making the atomic_long interface type safe.
> > 
> > Needing casts is bad form, which made me look at the code. There are no
> > ld_semaphore::count users outside of these functions so there is no
> > reason why it can not be an atomic_long_t in the first place, obviating
> > the need for this cast.
> > 
> > That also ensures the loads use atomic_long_read(), which implies (at
> > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > 
> > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > very thin (the only difference is not changing *old on success, which
> > most callers don't seem to care about).
> > 
> > So rework the whole thing to use atomic_long_t and its accessors
> > directly.
> > 
> > While there, fixup all the horrible comment styles.
> > 
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
> >  include/linux/tty_ldisc.h |  4 +--
> >  2 files changed, 37 insertions(+), 49 deletions(-)
> > 
> > Note: Greg has queued this via the in the tty tree for v4.19, which can be seen at: 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=5fd691afdf929061c391d897fa627822c3b2fd5a
> 
> Can this patch be skipped, or do the others depend on it?

IIRC it depends on it, without this patch you get build issues due to
atomic_long_cmpxchg() getting picky about it's arguments (type safety
improved).
