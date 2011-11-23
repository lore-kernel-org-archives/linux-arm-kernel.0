From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 23 Nov 2011 11:50:12 +0000
Subject: [PATCH 2/4] ARM: extract out insn generation code from ftrace
In-Reply-To: <CAH+eYFA2nhwXCU99RWyv1tncdz77dNHKqyX9bzSE31iepTRFYw@mail.gmail.com>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-2-git-send-email-rabin@rab.in>
 <20111122120252.GE2066@localhost.localdomain>
 <CAH+eYFBz_aEeC3DwGF2mdpVepburzCBJqD0n1LFjL1y5dqOXHw@mail.gmail.com>
 <20111122135627.GH2066@localhost.localdomain>
 <CAH+eYFA2nhwXCU99RWyv1tncdz77dNHKqyX9bzSE31iepTRFYw@mail.gmail.com>
Message-ID: <20111123115002.GA2050@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:55:49PM +0530, Rabin Vincent wrote:
> On Tue, Nov 22, 2011 at 19:26, Dave Martin <dave.martin@linaro.org> wrote:
> > On Tue, Nov 22, 2011 at 07:02:13PM +0530, Rabin Vincent wrote:
> >> It's not used on Thumb-2. ?This is only used by the function graph
> >> tracer and that depends on !THUMB2_KERNEL.
> >
> > I assume there's no special reason why this doesn't work with a Thumb-2
> > kernel, other than that it simply hasn't implemented yet?
> 
> The function graph tracer expects to get a pointer to the saved return
> address of the function (on the stack).  It changes this to its own
> return_hooker function where it records the exit from the function and
> jumps to the real return address.
> 
> We do this for ARM (the instruction set) by building with frame pointers,
> and the function prologues always save the registers in the expected
> order and the epilogues restore them out from the saved locations.
> 
> However, with Thumb-2, we don't get frame pointers even if we ask for
> them.  So to support Thumb-2 we'd probably need a way to find and modify
> the LR without it being at a fixed location (MIPS does something similar
> IIRC).  I haven't really looked into it.

The unwind tables contain the information required to find the link
register.  This is how the backtracer works in Thumb-2 kernels or with
CONFIG_ARM_UNWIND.   This adds some complexity, but it also has some
advantages such as elimiating the runtime stack and instruction overhead
associated with maintaining a framepointer chain.

Really, "find/change frame's stored return address" is a generic
operation which is closely related to stack unwinding, and would best
be implemented along with the unwinder code.  Ideally, ftrace should
not need to know or care _how_ this is accomplished.  Indeed, at this
level the operation isn't even arch-specific.

I will take a look at the ARM unwind/backtrace code and think about
whether this could be factored out or exposed in a helpful way.
Certainly we shouldn't implement a second unwind table parser in
ftrace...

Are there any other dependencies on framepointers, or is that the only
thing?

Cheers
---Dave
