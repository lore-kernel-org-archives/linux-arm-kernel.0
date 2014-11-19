From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Nov 2014 19:06:01 +0000
Subject: [PATCH v8 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <546C58DB.5080204@linaro.org>
References: <1416273038-15590-1-git-send-email-takahiro.akashi@linaro.org>
 <1416273038-15590-3-git-send-email-takahiro.akashi@linaro.org>
 <20141118140425.GM18842@arm.com> <546C58DB.5080204@linaro.org>
Message-ID: <20141119190601.GM15985@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 08:46:19AM +0000, AKASHI Takahiro wrote:
> On 11/18/2014 11:04 PM, Will Deacon wrote:
> > On Tue, Nov 18, 2014 at 01:10:34AM +0000, AKASHI Takahiro wrote:
> >>
> >> +	if (((int)regs->syscallno == -1) && (orig_syscallno == -1)) {
> >> +		/*
> >> +		 * user-issued syscall(-1):
> >> +		 * RESTRICTION: We always return ENOSYS whatever value is
> >> +		 *   stored in x0 (a return value) at this point.
> >> +		 * Normally, with ptrace off, syscall(-1) returns -ENOSYS.
> >> +		 * With ptrace on, however, if a tracer didn't pay any
> >> +		 * attention to user-issued syscall(-1) and just let it go
> >> +		 * without a hack here, it would return a value in x0 as in
> >> +		 * other system call cases. This means that this system call
> >> +		 * might succeed and see any bogus return value.
> >> +		 * This should be definitely avoided.
> >> +		 */
> >> +		regs->regs[0] = -ENOSYS;
> >> +	}
> >
> > I'm still really uncomfortable with this, and it doesn't seem to match what
> > arch/arm/ does either.
> 
> Yeah, I know but
> as I mentioned before, syscall(-1) will be signaled on arm, and so we don't
> have to care about a return value :)

What does x86 do?

> > Doesn't it also prevent a tracer from skipping syscall(-1)?
> 
> Syscall(-1) will return -ENOSYS whether or not a syscallno is explicitly
> replaced with -1 by a tracer, and, in this sense, it is *skipped*.

Ok, but now userspace sees -ENOSYS for a skipped system call in that case,
whereas it would usually see whatever the trace put in x0, right?

Will
