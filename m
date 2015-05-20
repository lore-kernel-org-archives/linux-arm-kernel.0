From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 May 2015 17:39:47 +0100
Subject: [PATCH v6 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <1429561187-3661-4-git-send-email-dave.long@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-4-git-send-email-dave.long@linaro.org>
Message-ID: <20150520163946.GC29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 04:19:44PM -0400, David Long wrote:
> Add support for basic kernel probes(kprobes) and jump probes
> (jprobes) for ARM64.
> 
> Kprobes utilizes software breakpoint and single step debug
> exceptions supported on ARM v8.
> 
> A software breakpoint is placed at the probe address to trap the
> kernel execution into the kprobe handler.
> 
> ARM v8 supports enabling single stepping before the break exception
> return (ERET), with next PC in exception return address (ELR_EL1). The
> kprobe handler prepares an executable memory slot for out-of-line
> execution with a copy of the original instruction being probed, and
> enables single stepping. The PC is set to the out-of-line slot address
> before the ERET. With this scheme, the instruction is executed with the
> exact same register context except for the PC (and DAIF) registers.

I wonder whether it would be simpler to use another software breakpoint
after the out of line instruction copy. You won't run the instructions
that change the PC anyway.

Since an unconditional branch instruction within the kernel address
space can reach any point in the kernel (and modules), could we go a
step further and avoid the software breakpoint altogether, just generate
a branch instruction to the original location (after the software
breakpoint)?

As for simulating/emulating instructions, could we actually avoid it for
most of them where we can generate a similar instruction with the
corrected offset? If the out of line slot is somewhere within the kernel
data section, I think many of them can be re-encoded (e.g. branches).

-- 
Catalin
