From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 16 Jan 2017 16:31:23 +0000
Subject: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
In-Reply-To: <a7261d6b-0074-7345-d380-ef0dd335dd56@redhat.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
 <20170116133231.GO3699@e103592.cambridge.arm.com>
 <20170116151156.GI28060@E107787-LIN>
 <a7261d6b-0074-7345-d380-ef0dd335dd56@redhat.com>
Message-ID: <20170116163123.GQ3699@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 03:47:55PM +0000, Pedro Alves wrote:
> On 01/16/2017 03:11 PM, Yao Qi wrote:
> > 
> >> > 
> >> > gdb must already re-detect the vector length on stop, since the target
> >> > could have called the prctl() in the meantime.
> > Yes, gdb assumes the vector length may be changed, so it re-detects on
> > every stop, but I don't see the need for gdb to change the vector length.
> > 
> 
> Do we need to consider inferior function calls here?
> 
> Say the program is stopped in code that assumes "vector length N", and
> the user does "print some_function_that_assumes_some_other_vector_length ()".
> 
> Is that a use case we need to cover?
> 
> If so, to make it work correctly, the debugger needs to be able to change the
> vector length to the length assumed by that called function, and then
> restore it back after the call completes (or is aborted).
> 
> I have no idea whether the debugger will be able to figure
> out a function's assumed vector length from debug info or some such.

I think the proposed ptrace interface can support this -- i.e., it
should provide everything needed to save off the VL and register state,
switch VL, do something else, then restore the VL and state (if not,
that's a bug).

My current position is that determining what vector length is
required by what function or binary is a 100% userspace problem, though.

ELF/DWARF could have annotations about this, though it wouldn't
necessarily be per-function -- you might require a whole image to be
built for the same vector length (if any).

Cheers
---Dave
