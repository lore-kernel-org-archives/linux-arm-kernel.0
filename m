From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 3 Apr 2017 11:01:28 +0100
Subject: [RFC PATCH v2 00/41] Scalable Vector Extension (SVE) core support
In-Reply-To: <20170403094501.GN3750@e103592.cambridge.arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu_JUqQu7nUB3MfJrpHL19NTSzGBDmZqLejBx8pNkwSq+A@mail.gmail.com>
 <20170403094501.GN3750@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu8vUq0A8BEuLHT8e3w9xJ4fbQ3j7K+mVwJafbQP3Eku5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2017 at 10:45, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Mar 31, 2017 at 04:28:16PM +0100, Ard Biesheuvel wrote:
>> On 22 March 2017 at 14:50, Dave Martin <Dave.Martin@arm.com> wrote:
>>
>> Hi Dave,
>>
>> > The Scalable Vector Extension (SVE) [1] is an extension to AArch64 which
>> > adds extra SIMD functionality and supports much larger vectors.
>> >
>> > This series implements core Linux support for SVE.
>> >
>> [...]
>> > KERNEL_MODE_NEON (non-)support
>> > ------------------------------
>> >
>> > "arm64/sve: [BROKEN] Basic support for KERNEL_MODE_NEON" is broken.
>> > There are significant design issues here that need discussion -- see the
>> > commit message for details.
>> >
>> > Options:
>> >
>> >  * Make KERNEL_MODE_NEON a runtime choice, and disable it if SVE is
>> >    present.
>> >
>> >  * Fully SVE-ise the KERNEL_MODE_NEON code: this will involve complexity
>> >    and effort, and may involve unfavourable (and VL-dependent) tradeoffs
>> >    compared with the no-SVE case.
>> >
>> >    We will nonetheless need something like this if there is a desire to
>> >    support "kernel mode SVE" in the future.  The fact that with SVE,
>> >    KERNEL_MODE_NEON brings the cost of kernel-mode SVE but only the
>> >    benefits of kernel-mode NEON argues in favour of this.
>> >
>> >  * Make KERNEL_MODE_NEON a dynamic choice, and have clients run fallback
>> >    C code instead if at runtime on a case-by-case basis, if SVE regs
>> >    would otherwise need saving.
>> >
>> >    This is an interface break, but all NEON-optimised kernel code
>> >    necessarily requires a fallback C implementation to exist anyway, and
>> >    the number of clients is not huge.
>> >
>> > We could go for a stopgap solution that at least works but is suboptimal
>> > for SVE systems (such as the first choice above), and then improve it
>> > later.
>> >
>>
>> Without having looked at the patches in detail yet, let me reiterate
>> my position after we discussed this when this series was sent out the
>> first time around.
>>
>> - The primary use case for kernel mode NEON is special purpose
>> instructions, i.e., AES is 20x faster when using the NEON, simply
>> because that is how one accesses the logic gates that implement the
>> AES algorithm. There is nothing SIMD or FP in nature about AES.
>> Compare the CRC extensions, which use scalar registers and
>> instructions. Of course, there are a couple of exceptions in the form
>> of bit-slicing algorithms, but in general, like general SIMD, I don't
>> think it is highly likely that SVE in kernel mode is something we will
>> have a need for in the foreseeable future.
>
> Certainly there is no immediate need for this, and if we decide we never
> need it then that helps us avoid some complexity.
>
> My main concern is around the extra save/restore cost, given that if
> the SVE registers are live then save/restore of the full SVE vectors
> is needed even if only FPSIMD is used in the meantime.
>
>> - The current way of repeatedly stacking/unstacking NEON register
>> contents in interrupt context is highly inefficient, given that we are
>> usually interrupting user mode, not kernel mode, and so stacking once
>> and unstacking when returning from the exception (which is how we
>> usually deal with it) would be much better. So changing the current
>> implementation to perform the eager stack/unstack only when a kernel
>> mode NEON call is already in progress is likely to improve our current
>> situation already, regardless of whether such a change is needed to
>> accommodate SVE. Note that to my knowledge, the only in-tree users of
>> kernel mode NEON operate in process context or softirq context, never
>> in hardirq context.
>
> Reassuring.
>
>> Given the above, I think it is perfectly reasonable to conditionally
>> disallow kernel mode NEON in hardirq context. The crypto routines that
>> rely on it can easily be fixed up (I already wrote the patches for
>> that). This would only be necessary on SVE systems, and the reason for
>> doing so is that - given how preserving and restoring the NEON
>> register file blows away the upper SVE part of the registers - whoever
>> arrives at the SVE-aware preserve routine first should be allowed to
>> run to completion. This does require disabling softirqs during the
>> time the preserved NEON state is being manipulated but that does not
>> strike me as a huge price to pay. Note that both restrictions
>> (disallowing kernel mode NEON in hardirq context, and the need to
>> disable softirqs while manipulating the state) could be made runtime
>> dependent on whether we are actually running on an SVE system.
>
> Given that we already bail out of kernel_neon_begin() with a WARN() if
> the hardware lacks FPSIMD, I'm not sure it would be worse to do the same
> if SVE is present.
>
> However, we should probably abstract that check: currently, drivers
> seemt to be using a cocktail of Kconfig dependencies,
> MODULE_DEVICE_TABLE() and runtime hwcap checks in order to deduce
> whether kernel_neon_begin() is safe to use.
>

Not quite. The Kconfig dependencies are about
CONFIG_KERNEL_MODE_NEON=y being set, without which it is pretty
pointless to build the modules that depend on it.

The hwcap dependencies are mostly about the actual instructions
themselves, i.e., AES, PMULL, SHA1/2 etc

> Would you be happy with a single API for checking whether
> kernel_neon_begin() works?  Maintaining this check in every driver
> doesn't feel very scalable.
>

Yes, that makes sense, but it is unrelated to hwcap. I'd like to see a
kernel_neon_allowed() that would return '!IS_ENABLED(CONFIG_SVE) ||
!(elf_hwcap & HWCAP_SVE) || !in_irq()' at some point, although I
understand you want to remove the last part for now.
To short-circuit some decisions in the driver when
kernel_neon_allowed() is always true (as it would be currently),
something like kernel_neon_need_fallback() comes to mind.

>
> This would allow SVE to disable KERNEL_MODE_NEON without having to make
> them conflict in Kconfig.  This wouldn't be our end goal, but it allows
> the dependency to be decoupled while we figure out a better solution.
>

I still don't think there is a need to disable kernel mode NEON
altogether. But we can defer that decision until later, but prepare
the existing code to deal with that in the mean time.

As I mentioned, I already looked into this a while ago, so I can
quickly respin the changes to the crypto code to take this into
account.
