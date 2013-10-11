From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Oct 2013 20:35:18 +0100
Subject: [RFC v2 PATCH 2/4] ARM64: add support for kernel mode NEON in
 atomic context
In-Reply-To: <B07F01F7-2FCE-4161-BAF4-1183E1B07F4A@linaro.org>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381344634-14917-3-git-send-email-ard.biesheuvel@linaro.org>
 <20131011171446.GA18859@arm.com>
 <B07F01F7-2FCE-4161-BAF4-1183E1B07F4A@linaro.org>
Message-ID: <C2D74641-A4F0-4CFB-A06C-AE79C05CCD1A@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Oct 2013, at 18:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 11 okt. 2013, at 19:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> On Wed, Oct 09, 2013 at 07:50:32PM +0100, Ard Biesheuvel wrote:
>>> --- a/arch/arm64/include/asm/neon.h
>>> +++ b/arch/arm64/include/asm/neon.h
>>> @@ -8,7 +8,38 @@
>>> * published by the Free Software Foundation.
>>> */
>>> 
>>> +#include <linux/hardirq.h>
>>> +#include <linux/types.h>
>>> +#include <asm/fpsimd.h>
>>> +
>>> #define cpu_has_neon()        (1)
>>> 
>>> +#define DEFINE_NEON_STACK_REGS(a, num)                    \
>>> +    struct {                            \
>>> +        struct fpsimd_partial_state regs;            \
>>> +        __uint128_t vregs[(num) > 32 ? 32 : ((num) + 1) & ~1U];    \
>>> +    } a = { .regs.num_regs = sizeof(a.vregs) / sizeof(__uint128_t) }
>>> +
>>> +#define DEFINE_NEON_STACK_REGS_ALL(name)    DEFINE_NEON_STACK_REGS(name, 32)
>>> +
>>> void kernel_neon_begin(void);
>>> void kernel_neon_end(void);
>>> +
>>> +static inline void __kernel_neon_begin_atomic(struct fpsimd_partial_state *regs)
>>> +{
>>> +    if (!in_interrupt())
>>> +        kernel_neon_begin();
>>> +    else
>>> +        fpsimd_save_partial_state(regs);
>>> +}
>>> +
>>> +static inline void __kernel_neon_end_atomic(struct fpsimd_partial_state *regs)
>>> +{
>>> +    if (!in_interrupt())
>>> +        kernel_neon_end();
>>> +    else
>>> +        fpsimd_load_partial_state(regs);
>>> +}
>> 
>> The _atomic suffix is a bit misleading (you basically mean no user
>> context). I wonder whether it's better to have some _fast/_slow variants
>> instead. Looking at the other two patches, you only need 2 or 4
>> registers to do the crypto stuff but if you are not in_interrupt(), you
>> basically save and restore the full NEON bank. I would say for such
>> cases just make kernel_neon_begin_fast() call which is safe in all
>> contexts and much faster.
> 
> I agree that the name is a bit misleading.
> 
> Regarding fast/slow: if you take the core aes cipher as an example, it
> will likely be called from a loop somewhere, and (assuming lazy restore
> gets merged at some point) you may be stacking and unstacking 2 or 4
> registers many times while kernel_neon_begin() would just stack them
> once and let the lazy restore unstack them only when needed.
> 
> This is probably a detail where arm and arm64 will be implemented
> somewhat differently.  I would still like to align the api between the
> two, if possible, so intrinsics or gcc vectorized code can be shared
> easily.  However, as ARM has fewer use cases where using only 2
> registers makes sense, (memcpy perhaps?) and already has lazy restore
> wired up, I personally feel hooking into the lazy restore in the
> !in_interrupt() case is still the best solution there.

Lazy saving/restoring on context switch may not be beneficial on arm64
and I don't want to enable it until I see some real user space
benchmarks (not kernel crypto API benchmarks).

The way kernel_neon_begin() is currently implemented on arm64 just saves
the whole register bank, so being called in a loop it will be worse.
What you could do is to save the register bank in kernel_neon_begin()
only the first time, set a TIF flag and restore them when returning to
user.  This way you can call it multiple times but only save/restore
once.

Catalin
