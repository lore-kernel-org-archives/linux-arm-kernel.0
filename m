From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 26 May 2011 10:43:41 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <alpine.LFD.2.02.1105251836030.3078@ionos>
References: <20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
	<alpine.LFD.2.02.1105242239230.3078@ionos>
	<20110525150153.GE29179@elte.hu>
	<alpine.LFD.2.02.1105251836030.3078@ionos>
Message-ID: <20110526084341.GD26775@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > We do _NOT_ make any decision based on the trace point so 
> > > what's the "pre-existing" active role in the syscall entry 
> > > code?
> > 
> > The seccomp code we are discussing in this thread.
> 
> That's proposed code and has absolutely nothing to do with the 
> existing trace point semantics.

So because it's proposed code it does not exist?

If the feature is accepted (and given Linus's opinion it's not clear 
at all it's accepted in any form) then it's obviously a very 
legitimate technical concern whether we do:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Where seccomp_check_syscall_event() duplicates much of the machinery 
that is behind trace_syscall_event().

Or we do the more intelligent:

	ret = check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

Where we have the happy side effects of:

  - less code at the call site

  - (a lot of!) shared infrastructure between the proposed seccomp 
    code and event filters.

  - we'd also be able to trace at security check boundaries - which
    has obvious bug analysis advantages.

In fact i do not see *any* advantages in keeping this needlessly 
bloaty and needlessly inconsistently sampled form of instrumentation:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Do you?

Thanks,

	Ingo
