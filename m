From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 21 Sep 2011 14:33:07 +0100
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <20110921115553.GF17169@n2100.arm.linux.org.uk>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1109191913210.12663@xanadu.home>
	<2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
	<20110921113906.GB2872@arm.com>
	<20110921115553.GF17169@n2100.arm.linux.org.uk>
Message-ID: <20110921133307.GD2872@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 12:55:53PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 21, 2011 at 12:39:09PM +0100, Dave Martin wrote:
> > Talking to Catalin a bit more, it sounds like prefetch aborts should not
> > happen in kernel code, and data aborts should not happen when accessing
> > the kernel stack.
> 
> No faults should happen in kernel code, except for:
> 
> 1. instructions specifically marked in the exception table, which are used
>    to access user memory.
> 2. instructions causing an 'undefined instruction' exception.
> 
> Standard ARM instructions like 'add', 'mov' etc should _never_ fault,
> and if they do that means your core isn't executing ARM instructions
> correctly (eg, the hardware design is faulty.)
> 
> Instructions such as VFP, kprobes tracing, etc are expected fault
> locations, and those are fairly well controlled where they can be placed.
> With things like ftrace, it certainly is the case that the unwinder can
> theoretically be called from almost anywhere in a function.
> 
> So I suggest that this does need to be fixed, and you can't rely on
> "prefetch aborts should not happen".  That's true of prefetch aborts
> but not of other aborts.

The important thing for the unwinder is that it can't cope well with faults
happening in the save/restore sequences at function entry and exit, and
we may not cope well with functions which don't have a simple SAVE,
EXECUTE, RESTORE, RETURN structure.

My gut feeling is that neither (1) or (2) should happen in those sequences,
and VFP faults should not happen in these sequences because the kernel
should not contain VFP code except in particular controlled locations.

For things like kprobes which allow a trap to be set at a function's entry
point we do have a problem: if we try to backtrace from this point, the
backtracer will see we are in that function and will assume that the
function's state saving code has already executed.  It might be simple
to work around this particular case by making the unwinder intelligent
enough to realise that if backtracing from the first instruction of a
function, none of the function's state save code can have executed yet.
