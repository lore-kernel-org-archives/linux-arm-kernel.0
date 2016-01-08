From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Fri, 8 Jan 2016 11:09:44 -0800
Subject: [PATCH] arm64: net: bpf: don't BUG() on large shifts
In-Reply-To: <20160108154423.GC11228@arm.com>
References: <1452015543-6790-1-git-send-email-rabin@rab.in>
 <20160108154423.GC11228@arm.com>
Message-ID: <20160108190943.GA11561@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 03:44:23PM +0000, Will Deacon wrote:
> On Tue, Jan 05, 2016 at 06:39:03PM +0100, Rabin Vincent wrote:
> > Attempting to generate UBFM/SBFM instructions with shifts that can't be
> > encoded in the immediate fields of the opcodes leads to a trigger of a
> > BUG() in the instruction generation code.  As the ARMv8 ARM says: "The
> > shift amounts must be in the range 0 to one less than the register width
> > of the instruction, inclusive."  Make the JIT reject unencodable shifts
> > instead of crashing.
> 
> I moaned about those BUG_ONs when they were introduced:
> 
>   https://lkml.org/lkml/2014/7/17/438
> 
> The response then was that the verifier would catch these issues so
> there was nothing to worry about. Has something changed so that is no
> longer the case? Do we need to consider a different way of rejecting
> invalid instructions at the encoding stage rather than bringing down the
> kernel?

that discussion lead to replacement of all BUG_ONs in
arch/arm64/net/bpf_jit_comp.c with pr_err_once(), but looks like
arch/arm64/kernel/insn.c wasn't addressed.
The amount of BUG_ONs there is indeed overkill regardless of what
verifier and other JITs do. btw, x64 JIT doesn't have runtime BUG_ONs.
