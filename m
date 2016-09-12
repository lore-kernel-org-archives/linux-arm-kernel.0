From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 12 Sep 2016 16:30:15 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <57D6C33D.9020003@arm.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
 <20160912111749.GB3958@e103592.cambridge.arm.com>
 <57D6C33D.9020003@arm.com>
Message-ID: <20160912153015.GD3958@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 04:01:17PM +0100, Szabolcs Nagy wrote:
> On 12/09/16 12:17, Dave Martin wrote:

[...]

> >> On 09/09/2016 05:21 PM, Dave Martin wrote:

[...]

> >>> I wonder whether we should make the signal stack size runtime
> >>> discoverable through sysconf() instead...
> > 
> > I will likely suggest this for the future, but of course it doesn't help
> > for current binaries.
> > 
> > 
> > Note that MINSIGSTKSZ stared life wrong for arm64, and has since gone
> > through a few ABI breaking changes.  I don't condone this, but we have
> > form in this area :/
> > 
> > sigaltstack() already fails with ENOMEM for software that passes
> > ss_size = MINSIGSTKSZ, and is built against glibc<2.22 [1], [2], running
> > on linux>=4.3 [3], which is an ABI break in case where sigaltstack() is
> > otherwise guaranteed to succeed.
> > 
> 
> yes, this was abi breaking change.
> 
> if glibc does not care about existing binaries
> that use sigaltstack with MINSIGSTKSZ then it can
> increase the size, but i think the kernel should
> not change the abi (there are other libcs and libc
> independent runtime systems on linux for aarch64
> with their own sigaltstack setup, not all of them
> may care about SVE).
> 
> i assume the kernel can avoid saving SVE regs when
> they are not used by the process.

I can (and do), in my patches (not posted yet).

The real issue here is that a recently updated shared library might be
optimised to use SVE, where the program using it is an older, SVE-
unaware binary.

(think of an optimised math library using some new fancy SVE-based
number crunching internally).

> 
> > 
> > The bottom line here is that the sigaltstack() API is broken with regard
> > to extensibility, so we cannot extend the amount of signal state without
> > breaking something.
> > 
> 
> extending signal state can break things independently
> of sigaltstack.
> 
> binaries with strict guarantees about worst case stack
> usage can change behaviour.

Indeed, but this is not a new issue.  Software must run with enough
stack in order to be portable, but there is no portable way to determine
how much stack is needed.

> fortunately glibc PTHREAD_STACK_MIN is huge on aarch64
> so applications using it are unlikely to break because
> of the increased signal state.
> (this also means it's impossible to have threads with
> tiny stacks on glibc, so large amount of threads means
> large amount of commit charge.)

Again, not a new problem.

[...]

Cheers
---Dave
