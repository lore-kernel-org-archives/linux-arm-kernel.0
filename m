From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Wed, 25 Oct 2017 15:33:32 +0100
Subject: [RFC PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
In-Reply-To: <20171025125727.GH19485@e103592.cambridge.arm.com>
References: <1508758664-24186-1-git-send-email-Dave.Martin@arm.com>
 <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
 <87tvypiyg8.fsf@linaro.org>
 <20171024113805.GF19485@e103592.cambridge.arm.com>
 <87y3o09tkw.fsf@e105548-lin.cambridge.arm.com>
 <20171025125727.GH19485@e103592.cambridge.arm.com>
Message-ID: <59F0A0BC.1090606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/17 13:57, Dave Martin wrote:
> On Tue, Oct 24, 2017 at 09:30:55PM +0100, Richard Sandiford wrote:
>> I think the uses via libc wrappers should be OK, since the SVE PCS says
>> that all SVE state is clobbered by normal function calls.  I think we
>> can be relatively confident that the compilers implement this correctly,
>> since it's the natural extension of the base AArch64 PCS (which only
>> preserves the low 64 bits of V8-V15).
>>
>> Perhaps one concern would be LTO, since we then rely on the syscall asm
>> statement having the correct clobber lists.  And at the moment there's
>> no syntax for saying that a register R is clobbered above X bits.
>> (Alan's working on a GCC patch that could be reused for this if necessary.)
>
> I wonder whether the lack of a precise clobber will discourage people
> from writing a correct clobber list for SVCs -- the kernel guarantees to
> preserve V0-V31, so listing z0-z31 as clobbered would resulting
> unnecessary spilling of V8-V15[63:0] around SVC (as required by the
> ARMv8 base PCS).
>
> If SVC is always in out-of-line asm though, this isn't an issue.  I'm
> not sure what glibc does.

glibc assumes that the libc code is not lto'd.

it has syscall asm files as well as inline asm with svc,
the later does not have magic sve clobber, but it should
not matter as long as no sve is used in glibc.

gcc runtimes (libstdc++, libgomp, libitm,..) have some
raw syscalls (mainly futex) but on aarch64 it's a call
to syscall() in libc, not inline asm.

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
