From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Sep 2014 11:58:45 +0100
Subject: [PATCH] arm64: insn: Add return statements after BUG_ON()
In-Reply-To: <20140916164953.GE32073@arm.com>
References: <1410885753-25025-1-git-send-email-broonie@kernel.org>
 <20140916164953.GE32073@arm.com>
Message-ID: <20140919105843.GC2295@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 05:49:53PM +0100, Will Deacon wrote:
> On Tue, Sep 16, 2014 at 05:42:33PM +0100, Mark Brown wrote:
> > Following a recent series of enhancements to the insn code the ARMv8
> > allnoconfig build has been generating a large number of warnings in the
> > form of:
> > 
> > arch/arm64/kernel/insn.c:689:8: warning: 'insn' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > This is because BUG() and related macros can be compiled out so we get
> > execution paths which normally result in a panic compiling out to noops
> > instead.
> > 
> > I wasn't able to immediately identify a sensible return value to use in
> > these cases so just return 0 - this is all "should never happen" code so
> > hopefully it never has a practical impact.
> 
> Hmm, I had a similar complaint when we merged the code. I'd much rather see
> those BUG statements removed entirely, and have an error return code back to
> the jit. However, the counter argument was that the jitted code has already
> been verified at this point, so any errors really are fatal.

It's BPF, ftrace and jump label all using the insn.c code. What's funny,
ftrace.c passes the type as true/false rather than an enum (not sure
how/when we missed this).

> So, I think your patch is probably the best thing we can do without
> reopening that discussion.

We can merge this patch for now but I would rather return an error. It
may be better if we actually return a fault generating instruction (BRK)
rather than 0 like the AARCH64_BREAK_FAULT defined here:

http://lkml.kernel.org/g/1410853730-16470-1-git-send-email-dborkman at redhat.com

-- 
Catalin
