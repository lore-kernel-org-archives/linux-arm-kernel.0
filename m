From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 03 Sep 2013 12:25:08 +0100
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <20130903101332.GA26613@localhost.localdomain>
References: <20130903101332.GA26613@localhost.localdomain>
Message-ID: <5225C714.3090504@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/13 11:13, Dave Martin wrote:
> On Mon, Sep 02, 2013 at 12:24:23PM +0100, Ben Dooks wrote:
>> With the last ack added, the following series is ready to be pulled.
>>
>> The following changes since commit fa8218def1b1a16f0a410e2c1c767b4738cc81fa:
>>
>>    Merge tag 'regmap-v3.11-rc7' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
>> (2013-08-27 10:10:30 -0700)
>>
>> are available in the git repository at:
>>
>>
>>    git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v3
>>
>> for you to fetch changes up to 5217543fe4605fa91065acf5141d88949cd3da1e:
>>
>>    ARM: signal: sigreturn_codes should be endian neutral to work in BE8
>> (2013-09-02 11:53:53 +0100)
>>
>> ----------------------------------------------------------------
>> Ben Dooks (19):
>>        ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
>>        ARM: asm: Add ARM_BE8() assembly helper
>>        ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
>>        ARM: set BE8 if LE in head code
>>        ARM: pl01x debug code endian fix
>>        ARM: twd: data endian fix
>>        ARM: smp_scu: data endian fixes
>>        highbank: enable big-endian
>>        fix highbank
>>        mvebu: support running big-endian
>>        vexpress: add big endian support
>>        ARM: alignment: correctly decode instructions in BE8 mode.
>>        ARM: traps: use<asm/opcodes.h>  to get correct instruction order
>
> As I repoerted in [1], this is patch broken for CONFIG_THUMB2_KERNEL due
> to a typo:
>
> arch/arm/kernel/traps.c: In function 'do_undefinstr':
> arch/arm/kernel/traps.c:411:5: error: 'instr2' undeclared (first use in this function)
>       instr2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
>       ^
> arch/arm/kernel/traps.c:411:5: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/kernel/traps.c:410:9: warning: unused variable 'inst2' [-Wunused-variable]
>       u16 inst2;
>           ^
> make[1]: *** [arch/arm/kernel/traps.o] Error 1
>
>
> The following should be enough to fix it:
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index da070db..d3806aa 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -407,7 +407,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>   		if (thumb_mode(regs)) {
>   			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>   			if (is_wide_instruction(instr)) {
> -				u16 inst2;
> +				u16 instr2;
>   				instr2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
>   				instr = __opcode_thumb32_compose(instr, instr2);
>   			}


Sorry, I thought that had been fixed, thanks for reminding me.

I have fixed it and now on:

	git://git.baserock.org/delta/linux baserock/311-rc7/be/core-v4

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
