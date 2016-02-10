From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 10 Feb 2016 14:23:29 +0000
Subject: [PATCH] arm64: Rework valid_user_regs
In-Reply-To: <20160210123110.GD2632@leverpostej>
References: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
 <20160210115853.GG1052@arm.com> <20160210123110.GD2632@leverpostej>
Message-ID: <CAFEAcA-3mgxu6hNSOLhFMmfzB705xyZTyfa5eiRWX6MOnYMVvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2016 at 12:31, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Feb 10, 2016 at 11:58:53AM +0000, Will Deacon wrote:
>> I think we should err on the side of caution and nuke SS and IL for both
>> native and compat too, although that seems a odds with the PSR_s mask.
>> I wonder how relevant those PSR groups are in ARMv8...
>
> Ok.

If you nuke SS does that have any side effects in the case
of (for instance) interactions between ptrace single step
and ptrace syscall tracing? (ie do we ever end up in a situation
where the ptracer can read a PSR for the debuggee which has
SS set? if so then it should be able to write back the PSR
it has just read without any bits being unset.)

Clearing IL should be ok, though it's pretty harmless for
the user process to have IL set, it will just cause an exception.
(Userspace can't end up with IL set unless we allow it to by
doing an exception-return to EL0 with an IL-set SPSR.)

> I couldn't spot anything in the ARM ARM regarding PSR bit groups,; I was
> cargo-culting from the existing code. I'm more than happy to make the
> PSR_* groups an aarch32/compat thing.

It's not clear to me that they make much sense for 32-bit either.
NZCVQ are in PSR_f, but GE are in PSR_s. I and F are in
PSR_c but A is in PSR_x. Presumably we need to leave them in
the header file for back-compat with userspace, but I suspect
any kernel code using them would benefit from using constants
that more clearly reflect what it's doing.

(For instance, why do we clear NZCVQ on entry to a signal handler
but not GE? Harmless, since the calling convention doesn't require
any particular value for any of those flags on function entry,
but an odd inconsistency.)

thanks
-- PMM
