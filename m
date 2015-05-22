From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 May 2015 12:00:08 +0100
Subject: [PATCH v6 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <555D62BD.5040403@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-4-git-send-email-dave.long@linaro.org>
 <20150520163946.GC29424@e104818-lin.cambridge.arm.com>
 <555D62BD.5040403@linaro.org>
Message-ID: <20150522110007.GV29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 12:44:45AM -0400, David Long wrote:
> On 05/20/15 12:39, Catalin Marinas wrote:
> >On Mon, Apr 20, 2015 at 04:19:44PM -0400, David Long wrote:
> >>Add support for basic kernel probes(kprobes) and jump probes
> >>(jprobes) for ARM64.
> >>
> >>Kprobes utilizes software breakpoint and single step debug
> >>exceptions supported on ARM v8.
> >>
> >>A software breakpoint is placed at the probe address to trap the
> >>kernel execution into the kprobe handler.
> >>
> >>ARM v8 supports enabling single stepping before the break exception
> >>return (ERET), with next PC in exception return address (ELR_EL1). The
> >>kprobe handler prepares an executable memory slot for out-of-line
> >>execution with a copy of the original instruction being probed, and
> >>enables single stepping. The PC is set to the out-of-line slot address
> >>before the ERET. With this scheme, the instruction is executed with the
> >>exact same register context except for the PC (and DAIF) registers.
> >
> >I wonder whether it would be simpler to use another software breakpoint
> >after the out of line instruction copy. You won't run the instructions
> >that change the PC anyway.
> 
> We put quite a bit of work into making single-step work.  I don't see any
> obvious advantage to trying to switch to a software breakpoint. Both are
> debug exceptions but SS does leave open the possibility of maybe eventually
> running some instructions that do change the PC.

I'm not trying to get this re-written, just as a potential workaround
for the unexpected single-step error reported but I need to read some
more before I understand it properly (and I can see patches already for
fixing this).

> >Since an unconditional branch instruction within the kernel address
> >space can reach any point in the kernel (and modules), could we go a
> >step further and avoid the software breakpoint altogether, just generate
> >a branch instruction to the original location (after the software
> >breakpoint)?
> 
> Wouldn't a branch instruction have to make use of a register in order to
> span the whole address space?  How could you do that and have all the
> registers unmolested when you land back after the original probe point?  The
> thing that really kills this though is the fact we need to be able to run
> the pre and post functions before and *after* the XOL stepping.

A "b #imm" would be able to cover a wide range (+/-128MB), but, as you
said, it doesn't help with the post function call.

Any plans to post an updated version with the "unexpected single-step
error" fixed?

-- 
Catalin
