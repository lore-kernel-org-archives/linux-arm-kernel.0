From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Jul 2013 14:54:20 +0100
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y
In-Reply-To: <1373685501-1620-1-git-send-email-jld@mozilla.com>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
Message-ID: <20130715135420.GG10000@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jed,

On Sat, Jul 13, 2013 at 04:18:20AM +0100, Jed Davis wrote:
> There is currently some inconsistency about the "frame pointer" on ARM.
> r11 is the register with assemblers recognize and disassemblers often
> print as "fp", and which is sufficient for stack unwinding when using
> the APCS frame pointer option; but when unwinding with the Exception
> Handling ABI, the register GCC uses when a constant offset won't suffice
> (or when -fno-omit-frame-pointer is used; see kernel/sched/Makefile in
> particular) is r11 on ARM and r7 on Thumb.
> 
> Correspondingly, arch/arm/include/uapi/arm/ptrace.h defines ARM_fp to
> refer to r11, but arch/arm/kernel/unwind.c uses "FP" to mean either r11
> or r7 depending on Thumbness, and it is unclear what other cases such as
> the "fp" in struct stackframe should be doing.
> 
> Effects of this are probably limited to failure of EHABI unwinding when
> starting from a function that uses r7 to restore its stack pointer, but
> the possibility for further breakage (which would be invisible on
> non-Thumb kernels) is worrying.
> 
> With this change, it is hoped, r7 is consistently referred to as "r7",
> and "fp" always means r11; this costs a few extra ifdefs, but it should
> help prevent future issues.

I'm struggling to understand exactly the problem that this patch is trying
to address. If it's just a code consistency issue, I don't think it's worth
it (I actually find it less confusing the way we currently have things) but
if there is a real bug, perhaps you could provide a testcase?

Cheers,

Will
