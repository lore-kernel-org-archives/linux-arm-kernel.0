From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 19 Mar 2012 10:53:47 +0000
Subject: [PATCH] arm: Add unwinding support for memset and memzero.
In-Reply-To: <4F63767E.3020706@codeaurora.org>
References: <1331574027-28542-1-git-send-email-lauraa@codeaurora.org>
 <20120314111504.GA2033@linaro.org>
 <4F63767E.3020706@codeaurora.org>
Message-ID: <20120319105346.GA2124@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 10:21:02AM -0700, Laura Abbott wrote:
> On 3/14/2012 4:15 AM, Dave Martin wrote:
> >
> >For functions like this, the unwinding requirements are different
> >depending on where we are in the function.  But the unwinder annotations
> >don't remember exact instruction locations; only the extent of the
> >whole unwind block is recorded, along with the sequence (but not
> >location) of unwinder directives.
> >
> >As is, the unwinding may be wrong depending on which part of the function
> >is executing when the fault occurs.
> >
> 
> Hmmmm, I thought I could get away with only one annotation based on
> the structure of memset/memzero but looking again you are right, it
> really requires multiple annotations to be correct.
> 
> >It may be possible to split the function into multiple unwind blocks,
> >e.g.:
> >
> >ENTRY(somefunc)
> >UNWIND(.fnstart)
> >
> >UNWIND(.save {r4,lr})
> >	stfmd	sp!, {r4,lr}
> >
> >	/* check something */
> >
> >	blt	_the_other_way
> >	/* maybe carry out our job this way */
> >
> >	ldmfd	sp!, {r4,lr}
> >UNWIND(.fnend)
> >
> >_the_other_way:
> >UNWIND(.fnstart)
> >UNWIND(.save {r4,lr})
> >UNWIND(.save {r5-r8})
> >	stmfd	sp!, {r5-r8}	/* !! */
> >
> >	/* carry out our job the other way */
> >
> >	ldmfd	sp!, {r5-r8}
> >	ldmfd	sp!, {r4,pc}	/* !! */
> >UNWIND(.fnend)
> >
> >
> >This is still not exactly right (it's hard to be exactly right,
> >since the unwind tables are not meant for handling asynchronous
> >unwinding), but unwinding should be correct for the main bits of code
> >where most time is spent and/or faults are most likely (the "carry out
> >our job" comments).
> >
> 
> Would a compiler be able to generate code such as this and still
> generate correct completely unwinding annotations? Or if the
> compiler knows unwinding is necessary, is the only option to
> generate code in 'unwindable blocks'? (alternatively, no compiler is
> smart/stupid enough to generate this code?)

I believe the compiler will typically generate a single unwind block per
function, with single save/restore sequences at the entry and exit
points which save/restore everything the function could possibly
use.  This means that unless a fault occurs in the save/restore
sequences (this would imply a stack overflow etc.) then the resulting
backtrace should be sensible.

In assembly functions, we do sometimes optimise things further, so
that if there is a fast path through the function we don't necessarily
do the full save/restore on that path.  However, deferring state save
like this doesn't fit the "single unwind block per function" model.

The unusual thing about the function being considered here is that
it has two parts where non-stack faults can reasonably occur, with
different save/restore frames in each part.

Cheers
---Dave
