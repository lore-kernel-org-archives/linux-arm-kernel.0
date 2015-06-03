From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 03 Jun 2015 14:36:09 +0100
Subject: [PATCH v2 0/4] arm64: alternative patching rework
In-Reply-To: <20150602175902.GF3080@e104818-lin.cambridge.arm.com>
References: <1433152062-21907-1-git-send-email-marc.zyngier@arm.com>
 <20150602174715.GE3080@e104818-lin.cambridge.arm.com>
 <20150602175902.GF3080@e104818-lin.cambridge.arm.com>
Message-ID: <556F02C9.9020706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 02/06/15 18:59, Catalin Marinas wrote:
> On Tue, Jun 02, 2015 at 06:47:15PM +0100, Catalin Marinas wrote:
>> On Mon, Jun 01, 2015 at 10:47:38AM +0100, Marc Zyngier wrote:
>>> The current alternative instruction framework is not kind to branches,
>>> potentially leading to all kind of hacks in the code that uses
>>> alternatives. This series expands it to deal with immediate and
>>> conditional branches.
>>>
>>> This is a rewrite of fef7f2b20103, which got reverted in b9a95e85bbc
>>> as it was breaking unsuspecting branches inside an alternate
>>> sequence. It now also deals with conditional branches (instead of just
>>> asserting a BUG).
>>>
>>> Another nit is addressed by the last patch, where GAS gets confused by
>>> the combinaison of a .inst directive (as used by the msr_s/mrs_s
>>> pseudo-instruction), a label, and a .if directive evaluating said
>>> label. As this is exactly what the alternative framework uses to
>>> detect length mismatch, this patch reverts to using a pair of .org
>>> directives in a creative way. To make this a bit easier,
>>> alternative-asm.h is folded into alternative.h.
>>>
>>> This has been tested on v4.1-rc5.
>>>
>>> Marc Zyngier (4):
>>>   arm64: insn: Add aarch64_{get,set}_branch_offset
>>>   arm64: alternative: Allow immediate branch as alternative instruction
>>>   arm64: alternative: Merge alternative-asm.h into alternative.h
>>>   arm64: alternative: Work around .inst assembler bugs
>>
>> Applied, thanks.
> 
> Applied, but not pushed out yet. Testing on Juno gives:
> 
> alternatives: patching kernel code
> BUG: failure at /work/Linux/linux-2.6-aarch64/arch/arm64/kernel/alternative.c:59/branch_insn_requires_update()!
> Kernel panic - not syncing: BUG!
> CPU: 0 PID: 10 Comm: migration/0 Not tainted 4.1.0-rc4+ #224
> Hardware name: Juno (DT)
> Call trace:
> [<ffffffc00008992c>] dump_backtrace+0x0/0x11c
> [<ffffffc000089a58>] show_stack+0x10/0x1c
> [<ffffffc0005b49b4>] dump_stack+0x88/0xc8
> [<ffffffc0005b38a8>] panic+0xe0/0x220
> [<ffffffc00008e3b0>] __apply_alternatives+0x1ac/0x1cc
> [<ffffffc000123aa8>] multi_cpu_stop+0xf8/0x120
> [<ffffffc000123d60>] cpu_stopper_thread+0xb0/0x148
> [<ffffffc0000d12ec>] smpboot_thread_fn+0x150/0x274
> [<ffffffc0000cdedc>] kthread+0xd8/0xf0
> SMP: failed to stop secondary CPUs
> 
> 
> I haven't investigated yet, I'll have a look tomorrow.

I reproduced this. Two issues:

- the workaround for CONFIG_ARM64_ERRATUM_845719 is written with two 
alternate sequences, and the first one branches in to the second. 
Exactly what this series disallows... I'll post a rewrite of this 
sequence in a minute.

- there is a small bug that the above also triggers, as it branches 
just *after* the last instruction of the sequence. This doesn't 
generate any relocation problem, and can be accepted. Can you fold the 
patchlet below into the second patch of the series?

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index df4bf15..221b983 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -49,7 +49,7 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
                return 1;
 
        replptr = (unsigned long)ALT_REPL_PTR(alt);
-       if (pc >= replptr && pc < (replptr + alt->alt_len))
+       if (pc >= replptr && pc <= (replptr + alt->alt_len))
                return 0;
 
        /*

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
