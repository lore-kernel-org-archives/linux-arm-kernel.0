From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 17 May 2018 18:27:11 +0100
Subject: [PATCH v3] arm64: signal: Report signal frame size to userspace
 via auxv
In-Reply-To: <20180517162532.GE17671@n2100.armlinux.org.uk>
References: <1526571941-9816-1-git-send-email-Dave.Martin@arm.com>
 <20180517162532.GE17671@n2100.armlinux.org.uk>
Message-ID: <20180517172710.GU7753@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 05:25:32PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 17, 2018 at 04:45:41PM +0100, Dave Martin wrote:
> > Stateful CPU architecture extensions may require the signal frame
> > to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> > However, changing this #define is an ABI break.
> > 
> > To allow userspace the option of determining the signal frame size
> > in a more forwards-compatible way, this patch adds a new auxv entry
> > tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> > size that the process can observe during its lifetime.
> > 
> > If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> > assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> > a consistent interface with older kernels that do not provide
> > AT_MINSIGSTKSZ.
> > 
> > The idea is that libc could expose this via sysconf() or some
> > similar mechanism.
> > 
> > There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> > about userspace's own stack overheads and should not pretend to
> > know.
> 
> I'm really not sure I follow your logic here.
> 
> POSIX requirements are here:
> 
> http://pubs.opengroup.org/onlinepubs/000095399/functions/sigaltstack.html
> 
> and the requirement there is that the MINSIGSTKSZ constant is defined
> in signal.h to indicate to user programs the minimum signal stack size
> that the system requires.

At the birth of an arch, someone has to make a prescient guess about how
big the signal frame will ever grow, or risk ABI breaks or new
personalities that would require the userspace world to be rebuilt.

POSIX doesn't envisage that an arch's user register state can possibly
grow (or at least, not that much).

Unfortunately, predicting the future isn't that easy.

MINSIGSTKSZ has been wrong in the past, too.

arm64's linux MINSIGSTKSZ was 4K for quite a while even though the arm64
signal frame is always bigger than that.  This bug was hidden by a
different definition (5K) in glibc that was subsequently backported
into the kernel headers.  But userspace doesn't use that definition, so
this tells us little about how much would break out there if the
definition is changed.

IIUC, x86's MINSIGSTKSZ (2K) isn't big enough for AVX-512 (possibly not
big enough even without AVX-512, though I haven't figured it out).

According to Michael Ellerman, powerpc may have a similar issue at some
point.

> I don't see how passing the minimum signal stack size via AT_MINSIGSTKSZ
> helps in any way, since you propose to make programs use a sysconf()
> call to get that, and that is not covered by POSIX.  So you're asking
> programs to do something special for ARM64.

My idea is indeed to recommend that this gets hidden behind sysconf(),
so that programs can get a sensible value from there without needing to
know which architecture they are running on.  I have a glibc patch that
I intend to post for discussion soon.


This would mean something like

	#include <signal.h>
	#include <unistd.h>

	long size;

	#ifdef _SC_MINSIGSTKSZ
	size = sysconf(_SC_MINSIGSTKSZ);
	#else
	size = MINSIGSTKSZ;
	#endif

Programs would of course have to migrate to this over time.  I'm not
saying it's a magic bullet.

> Simply increasing MINSIGSTKSZ doesn't cause an ABI break - new programs
> built against an increased MINSIGSTKSZ results in more stack being
> allocated, which doesn't break the ABI in any way.  The problem comes

Maybe not per se, but if userspace exchanges pointers to stacks across
object boundaries and assumes that they are MINSIGSTKSZ in size (say),
then a prorgam may disagree with a library about what this size is.
And it's hard to guarantee that there is no software abusing MINSIGSTKSZ
or using it for dubious purposes such as sizing objects that are not
bare stacks.

	Consider:

	struct thread {
		/* ... */
		char stack[MINSIGSTKSZ];
		/* ... */
	};

	/* lib.so */
	void dup_thread(struct thread *dest, struct thread const *src)
	{
		*dest = *src;
	}

	/* application */
	
	/* ... */

		struct thread t1, t2;

		dup_thread(&t1, &t2);


I don't say whether this kind of thing is a good idea, but POSIX does
nothing to forbid it.  If lib.so was built more recently and uses the
new, larger MINSIGSTKSZ, while the application uses the old, smaller
value then the call to dup_thread will trigger a buffer overflow.

Changing MINSIGSTKSZ also papers over the problem of ucontext_t
perhaps not covering the whole signal frame.  If ucontexts ar
exchanged across object boundaries that use different definitions
of the type, then buffer overruns could easily happen.  If ucontext_t is
not redefined, part of the context will fall outside it.

I plan to propose some ucontext API extensions for glibc to help
mitigate this, but again, software would need to be ported to use
them.

> when old programs built with the old MINSIGSTKSZ are run against a
> kernel requiring a larger MINSIGSTKSZ.  It's almost the reverse problem
> - the kernel needs to know the MINSIGSTKSZ value that the problem was
> built with, but we don't have that facility either.
> 
> > For arm64:
> > 
> > The primary motivation for this interface is the Scalable Vector
> > Extension, which can require at least 4KB or so of extra space
> > in the signal frame for the largest hardware implementations.
> 
> Presumably you only include the SVE state if the application makes use
> of SVE?  Otherwise, you'd be saving and restoring a lot of state for
> features that are not being used.

Yes.  A program has to actually execute an SVE instruction in order
for the full SVE register values to be context switched or included
in the signal frame.

> I suppose part of the issue is that SVE is supported but MINSIGSTKSZ
> is incorrect if this state has to be saved and restored, so there's
> apps out there using SVE with the too-small MINSIGSTKSZ value?

There's no hardware yet, so there should be no programs in the wild.

If we could simply change MINSIGSTKSZ, that would be great.  But
redefining ucontext_t is more of a problem, and the two are rather
interrelated.

My current approach is to hide this from software by default, by
limiting the SVE vector length to a value small enough that the SVE
state fits in the original (5K-ish) arm64 signal frame.  Only if the 
distro/admin decides that it is safe to bump up this default, or
if an application explicitly asks for a larger size via a prctl()
is this limit increased.  

This is not ideal, but there didn't seem to be any ideal solution.

In practice, MINSIGSTKSZ is hard to use correctly, and most programs
use SIGSTKSZ instead.  As luck would have it, arm64's SIGSTKSZ is big
enough to cover the largest possible SVE signal frame.

The first round of SVE implementations are unlikely to exceed a
vector size of 512 bits, which again hides the problem.

All this buys some time for arm64 at least.  This patch is more about
trying to find a better approach for the future.


If there's a better option available, I'd love to hear about it!

Cheers
---Dave
