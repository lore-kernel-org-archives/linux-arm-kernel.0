From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 5 Oct 2017 18:02:54 +0100
Subject: [PATCH v2 26/28] arm64/sve: Add documentation
In-Reply-To: <59D6603C.2040603@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-27-git-send-email-Dave.Martin@arm.com>
 <59D6603C.2040603@arm.com>
Message-ID: <20171005170254.GY3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 05:39:24PM +0100, Szabolcs Nagy wrote:
> On 31/08/17 18:00, Dave Martin wrote:

[...]

> > +	PR_SVE_SET_VL_ONEXEC
> > +
> > +	    Defer the requested vector length change until the next execve().
> > +	    This allows launching of a new program with a different vector
> > +	    length, while avoiding runtime side effects in the caller.
> > +
> > +	    This also overrides the effect of PR_SVE_SET_VL_INHERIT for the
> > +	    first execve().
> > +
> > +	    Without PR_SVE_SET_VL_ONEXEC, any outstanding deferred vector
> > +	    length change is cancelled.
> > +
> 
> based on later text it seems this works if exeve is
> called in the same thread as prctl was called in.
> 
> this is a bit weird from user-space pov so it may
> make sense to state it here explicitly.

True.  Looking at the prctl(2) man page it looks like other per-thread
properties are inherited across execve() in a similar way, but it's at
least worth a mention.  PR_SET_SECCOMP seems to work like this, for
example.

So, the intention is that you do a prctl(...ONEXEC) in the run up to
execve(), rather than doing it at other random times.  The primary
reason for ONEXEC is to avoid the side-effects of actually changing
the VL.


Looking at this though...
I wonder whether PR_SVE_SET_VL(... PR_SVE_SET_VL_ONEXEC) should return
the VL set for exec, rather than the current VL (which is unchanged by
definition in this case, thus uninteresting).

This would allow the ONEXEC flag to be used to probe for available VLs
without the other side-effects of changing VL, something like:

	int old = prctl(PR_SVE_GET_VL);
	int ret;

	ret = prctl(PR_SVE_SET_VL, 144 | PR_SVE_SET_VL_ONEXEC);
	if (ret == -1) {
		perror("PR_SVE_SET_VL");
		goto error;
	}

	if ((ret & PR_SVE_VL_LEN_MASK) == 144)
		have_vl_144 = true;

	if (prctl(PR_SVE_SET_VL, old | PR_SVE_SET_VL_ONEXEC) == -1) {
		perror("PR_SVE_SET_VL");
		goto error;
	}


This does _not_ do the expected thing right now, since there's no
direct way to retrieve thread.sve_vl_onexec directly from the kernel
(and it didn't really seem justified to add one).

Thoughts?

Cheers
---Dave
