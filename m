From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 20:49:34 +0200
Subject: [PATCH] sched,
 time: fix build error with 64 bit cputime_t on 32 bit systems
In-Reply-To: <20140930134011.232bc7bf@annuminas.surriel.com>
References: <2547036.UshV4pXvhf@wuerfel>
 <20140930134011.232bc7bf@annuminas.surriel.com>
Message-ID: <6735433.ACfjMtVDYF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 13:40:11 Rik van Riel wrote:
> On Tue, 30 Sep 2014 13:56:37 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > A recent change to update the stime/utime members of task_struct
> > using atomic cmpxchg broke configurations on 32-bit machines with
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN set, because that uses 64-bit
> > nanoseconds, leading to a link-time error:
> > 
> > kernel/built-in.o: In function `cputime_adjust':
> > :(.text+0x25234): undefined reference to `__bad_cmpxchg'
> 
> Arnd, this should fix your problem, while still ensuring that
> the cpu time counters only ever go forward.
> 
> I do not have cross compiling toolchains set up here, but I assume
> this fixes your bug.
> 
> Ingo & Peter, if this patch fixes the bug for Arnd, could you please
> merge it into -tip?
> 
> Linus, the changeset causing the problem is only in -tip right now,
> and this patch will not apply to your tree.

It compiles and links on arm32 with both 32-bit and 64-bit cputime_t,
but I now get a new warning for the former case:

kernel/sched/cputime.c: In function 'cputime_advance':
kernel/sched/cputime.c:576:29: warning: passing argument 1 of '__cmpxchg64_mb' from incompatible pointer type
    cmpxchg64(counter, old, new);
                             ^
In file included from /git/arm-soc/arch/arm/include/asm/atomic.h:19:0,
                 from /git/arm-soc/include/linux/atomic.h:4,
                 from /git/arm-soc/include/linux/debug_locks.h:5,
                 from /git/arm-soc/include/linux/lockdep.h:23,
                 from /git/arm-soc/include/linux/spinlock_types.h:18,
                 from /git/arm-soc/include/linux/spinlock.h:81,
                 from /git/arm-soc/include/linux/seqlock.h:35,
                 from /git/arm-soc/include/linux/time.h:5,
                 from /git/arm-soc/include/uapi/linux/timex.h:56,
                 from /git/arm-soc/include/linux/timex.h:56,
                 from /git/arm-soc/include/linux/sched.h:19,
                 from /git/arm-soc/kernel/sched/cputime.c:2:
/git/arm-soc/arch/arm/include/asm/cmpxchg.h:255:105: note: expected 'long long unsigned int *' but argument is of type 'cputime_t *'
 static inline unsigned long long __cmpxchg64_mb(unsigned long long *ptr,
       kernel/sched/cputime.c:576:5: warning: value computed is not used [-Wunused-value]
    cmpxchg64(counter, old, new);
     ^
                                                                                                  ^
I suspect there is no solution that doesn't involve the preprocessor.
How about adding a cputime_cmpxchg() helper next to the cputime_t
definition?

	Arnd
