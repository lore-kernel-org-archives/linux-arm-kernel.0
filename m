From: dave.long@linaro.org (David Long)
Date: Thu, 21 May 2015 00:44:45 -0400
Subject: [PATCH v6 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <20150520163946.GC29424@e104818-lin.cambridge.arm.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-4-git-send-email-dave.long@linaro.org>
 <20150520163946.GC29424@e104818-lin.cambridge.arm.com>
Message-ID: <555D62BD.5040403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/15 12:39, Catalin Marinas wrote:
> On Mon, Apr 20, 2015 at 04:19:44PM -0400, David Long wrote:
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>> Kprobes utilizes software breakpoint and single step debug
>> exceptions supported on ARM v8.
>>
>> A software breakpoint is placed at the probe address to trap the
>> kernel execution into the kprobe handler.
>>
>> ARM v8 supports enabling single stepping before the break exception
>> return (ERET), with next PC in exception return address (ELR_EL1). The
>> kprobe handler prepares an executable memory slot for out-of-line
>> execution with a copy of the original instruction being probed, and
>> enables single stepping. The PC is set to the out-of-line slot address
>> before the ERET. With this scheme, the instruction is executed with the
>> exact same register context except for the PC (and DAIF) registers.
>
> I wonder whether it would be simpler to use another software breakpoint
> after the out of line instruction copy. You won't run the instructions
> that change the PC anyway.

We put quite a bit of work into making single-step work.  I don't see 
any obvious advantage to trying to switch to a software breakpoint. 
Both are debug exceptions but SS does leave open the possibility of 
maybe eventually running some instructions that do change the PC.

>
> Since an unconditional branch instruction within the kernel address
> space can reach any point in the kernel (and modules), could we go a
> step further and avoid the software breakpoint altogether, just generate
> a branch instruction to the original location (after the software
> breakpoint)?

Wouldn't a branch instruction have to make use of a register in order to 
span the whole address space?  How could you do that and have all the 
registers unmolested when you land back after the original probe point? 
  The thing that really kills this though is the fact we need to be able 
to run the pre and post functions before and *after* the XOL stepping.

>
> As for simulating/emulating instructions, could we actually avoid it for
> most of them where we can generate a similar instruction with the
> corrected offset? If the out of line slot is somewhere within the kernel
> data section, I think many of them can be re-encoded (e.g. branches).
>

Again, do we get enough displacement for this to always work?  A quick 
look at the ARMv8 ARM makes me think we get +/-128M offset for a branch 
and only +/-1M for a load literal.  For any given instruction type I 
don't think it works unless it works for all possible offsets.

-dl
