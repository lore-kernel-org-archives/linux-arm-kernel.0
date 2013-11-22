From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 22 Nov 2013 19:37:13 +0000
Subject: [PATCH] ARM: unwinder: Handle Stackoverflow in unwind_exec_insn
In-Reply-To: <CAPoNrtuuHOB5d+vo-wGJ=5JQG=K0ZdaAv2Nyfxnit=WAWzXegg@mail.gmail.com>
References: <1383731448-847-1-git-send-email-a.anurag@samsung.com>
 <20131108132119.GB2602@localhost.localdomain>
 <CAPoNrtuuHOB5d+vo-wGJ=5JQG=K0ZdaAv2Nyfxnit=WAWzXegg@mail.gmail.com>
Message-ID: <20131122193703.GA2286@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 12:28:57PM +0530, Anurag Aggarwal wrote:
> Thanks for your input Dave,
> 
> I think there is another way to avoid the stack overflow and reduce
> the number of checks also,
> 
> Stack overflow will cause a problem only when we are backtracking the
> last set of registers.
> i.e when the difference between current SP and top of stack is less
> than or equal to number of registers

Apologies, it looks like I failed to respond to this earlier...


Although that will usually be correct, there is no rule in the ABI to
guarantee it.

> we can create two unwind_exec_insn, one without checks and one with checks.
> 
> then we call the correct function from unwind_frame depending on the
> difference of SP and top of stack.
> 
> This will reduce the amount of checks every time we read a set of
> registers from stack

That sounds like it might duplicate a lot of code, to optimise based on
assumptions that may not always be true, for what really should not be a
hot path in the kernel.

If you can find a tidy way of doing it, it would be certainly worth
reviewing, but I still think it would be simpler just to do a simple
bounds check for every word read from the stack -- it should be
impossible for that to go wrong, even if some of the bounds checks
are not stictly required.

Cheers
---Dave
