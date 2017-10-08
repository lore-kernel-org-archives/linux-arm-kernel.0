From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 08 Oct 2017 22:18:08 +0100
Subject: [stable:PATCH] arm64: Rework valid_user_regs (v3.16)
In-Reply-To: <1468844845-6129-4-git-send-email-james.morse@arm.com>
References: <1468844845-6129-1-git-send-email-james.morse@arm.com>
 <1468844845-6129-4-git-send-email-james.morse@arm.com>
Message-ID: <1507497488.2677.97.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-18 at 13:27 +0100, James Morse wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> commit dbd4d7ca563fd0a8949718d35ce197e5642d5d9d upstream.
> 
> We validate pstate using PSR_MODE32_BIT, which is part of the
> user-provided pstate (and cannot be trusted). Also, we conflate
> validation of AArch32 and AArch64 pstate values, making the code
> difficult to reason about.
> 
> Instead, validate the pstate value based on the associated task. The
> task may or may not be current (e.g. when using ptrace), so this must be
> passed explicitly by callers. To avoid circular header dependencies via
> sched.h, is_compat_task is pulled out of asm/ptrace.h.
> 
> To make the code possible to reason about, the AArch64 and AArch32
> validation is split into separate functions. Software must respect the
> RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
> policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
> architected meaning writes may be permitted (potentially with additional
> validation).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [ rebased for v3.16
>   This avoids a user-triggerable Oops() if a task is switched to a mode
>   not supported by the kernel (e.g. switching a 64-bit task to AArch32).
> 
>   v3.16 does not support SETEND, support for this was added by
>   2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks") in v3.20
>   This backport forces the kernel endianness on userspace.
> 
>   Added a DBG_SPSR_SS define hidden by #ifdefs to avoid conflicts with
>   other backports.
> ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: <stable@vger.kernel.org> #3.16.x
[...]

Belatedly queued this up for 3.16.

Ben.

-- 
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171008/2cd3880d/attachment.sig>
