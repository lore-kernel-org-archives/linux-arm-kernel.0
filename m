From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 18:33:48 +0100
Subject: [PATCH 0/7] arm64: PSR <-> SPSR_ELx mapping fixes
In-Reply-To: <20180625144421.11511-1-mark.rutland@arm.com>
References: <20180625144421.11511-1-mark.rutland@arm.com>
Message-ID: <20180704173347.GA9668@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, Jun 25, 2018 at 03:44:14PM +0100, Mark Rutland wrote:
> The SPSR_ELx format has diverged from the AArch32-native SPSR format since the
> addition of DIT. Thus, we need to map between the two for certain compat
> operations.
> 
> Also, when we added support for DIT, we forgot to account for this in
> valid_user_regs(), causing PSTATE.DIT to be cleared upon sigreturn.
> 
> These patches (based on v4.18-rc2) fix those issues, cleaning up the COMPAT_PSR
> definitions to try to avoid confusiong in future.
> 
> The COMPAT_PSR_ definitions are now used for the AArch32-native SPR format
> (i.e. they are the compat userspace view), with PSR_AA32_ definitions used for
> the AArch64 view of the PSR for AArch32 tasks.

I applied this, but it doesn't even build with defconfig :(

How much testing has this seen? I also get some other errors because code
is trying to refer to COMPAT definitions that you've removed. So I've dropped
all of this for now.

arch/arm64/include/asm/ptrace.h: Assembler messages:
arch/arm64/include/asm/ptrace.h:71: Error: unknown mnemonic `static' -- `static inline unsigned long compat_psr_to_pstate(const unsigned long psr)'
arch/arm64/include/asm/ptrace.h:72: Error: junk at end of line, first unrecognised character is `{'
arch/arm64/include/asm/ptrace.h:73: Error: unknown mnemonic `unsigned' -- `unsigned long pstate'
arch/arm64/include/asm/ptrace.h:77: Error: unknown mnemonic `if' -- `if (psr&0x00200000)'
arch/arm64/include/asm/ptrace.h:78: Error: unknown mnemonic `pstate' -- `pstate |=0x01000000'
arch/arm64/include/asm/ptrace.h:80: Error: unknown mnemonic `return' -- `return pstate'
arch/arm64/include/asm/ptrace.h:81: Error: junk at end of line, first unrecognised character is `}'
arch/arm64/include/asm/ptrace.h:83: Error: unknown mnemonic `static' -- `static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)'
arch/arm64/include/asm/ptrace.h:84: Error: junk at end of line, first unrecognised character is `{'
arch/arm64/include/asm/ptrace.h:85: Error: unknown mnemonic `unsigned' -- `unsigned long psr'
arch/arm64/include/asm/ptrace.h:89: Error: unknown mnemonic `if' -- `if (pstate&0x01000000)'
arch/arm64/include/asm/ptrace.h:90: Error: unknown mnemonic `psr' -- `psr |=0x00200000'
arch/arm64/include/asm/ptrace.h:92: Error: unknown mnemonic `return' -- `return psr'
arch/arm64/include/asm/ptrace.h:93: Error: junk at end of line, first unrecognised character is `}'
/tmp/ccvDpb9g.s: Error: symbol definition loop encountered at `pstate'
/tmp/ccvDpb9g.s: Error: invalid operands (*GAS `expr' section* and *ABS* sections) for `&' when setting `psr'
/tmp/ccvDpb9g.s: Error: Invalid operation on symbol
/tmp/ccvDpb9g.s: Error: can't resolve value for symbol `pstate'
make[2]: *** [arch/arm64/crypto/sha1-ce-core.o] Error 1

Will
