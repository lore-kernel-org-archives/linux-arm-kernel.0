From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 27 Jul 2016 11:01:05 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160726165543.GG2423@e104818-lin.cambridge.arm.com>
Message-ID: <20160727100048.GA7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 05:55:43PM +0100, Catalin Marinas wrote:
> On Tue, Jul 26, 2016 at 10:50:08AM +0100, Daniel Thompson wrote:
> > On 25/07/16 18:13, Catalin Marinas wrote:
> > >On Fri, Jul 22, 2016 at 11:51:32AM -0400, David Long wrote:
> > >>OK, it sounds like an improvement. I do worry a little about unexpected side
> > >>effects.
> > >
> > >You get more unexpected side effects by not saving/restoring the whole
> > >stack. We looked into this on Friday and came to the conclusion that
> > >there is no safe way for kprobes to know which arguments passed on the
> > >stack should be preserved, at least not with the current API.

[...]

Jumping cheekily onto this thread, what if some function does this:

void go_on_jprobe_me()
{
}

void foo()
{
	struct bar baz;

	start_io(&baz);

	/* ... */

	go_on_jprobe_me();

	end_io(&baz);
}

If some I/O is being done on baz asynchronously, via DMA or via another
thread, a jprobe implementation that attempts to save/restore the stack
beyond the arguments of the probed function is going to race with such
I/O and can corrupt data.

This is a risk whenever any thread triggers some other master to operate
on objects on the first thread's stack -- I/O is a contrived example, but
there are likely other ways similar asynchronous access can happen to
a thread's stack.

Worse, annotating go_on_jprobe_me() as un-jprobeable doesn't help --
the un-jprobeableness is a property not of the function itself, but
rather a property of the set of callers of that function.  That set can
change at runtime (consider out-of-tree modules).

Cheers
---Dave
