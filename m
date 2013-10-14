From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Oct 2013 10:12:29 +0200
Subject: [RFC v2 PATCH 2/4] ARM64: add support for kernel mode NEON in
 atomic context
In-Reply-To: <BF9D971A-6CB6-4135-BCBD-349B080E6BAA@arm.com>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381344634-14917-3-git-send-email-ard.biesheuvel@linaro.org>
 <20131011171446.GA18859@arm.com>
 <B07F01F7-2FCE-4161-BAF4-1183E1B07F4A@linaro.org>
 <C2D74641-A4F0-4CFB-A06C-AE79C05CCD1A@arm.com>
 <alpine.LFD.2.03.1310111546560.3023@syhkavp.arg>
 <BF9D971A-6CB6-4135-BCBD-349B080E6BAA@arm.com>
Message-ID: <CAKv+Gu_1xyNesOaBvhMfi7fj9Ec8hM_B9451i9jmpkCv_mVRUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2013 00:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 11 Oct 2013, at 21:09, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

[...]

>>
>> I think it is more important to establish the API semantics here.
>> Implementation may vary afterwards.
>>
>> The difference right now between kernel_neon_begin() and
>> __kernel_neon_begin_atomic() is that the later can be stacked while the
>> former cannot.
>
> How much stacking do we need?  If we limit the nesting to two levels
> (process and IRQ context), we could pre-allocate per-CPU
> fpsimd_state structures for interrupt context and always use the same
> API. About softirqs, do we need another level of nesting?
>

Softirq context is required as well, so that implies two additional
fpsimd_states of 512 bytes each. If we can afford that, then sure, why
not?

>> Maybe the API should be kernel_neon_begin() and
>> kernel_neon_begin_partial(nb_regs), the former being a simple alias to
>> the later with the full register set as argument.  And then the actual
>> register saving method (whether it is an atomic context or not, the
>> number of registers, etc.) could be handled and optimized internally
>> instead of exposing such implementation constraints to users of the API.
>
> It could be more efficient to always specify the number of registers to
> be saved/restored even for kernel_neon_begin().  But I haven't paid much
> attention to the register use in the actual crypto algorithms.
>

To elaborate a bit: WPA-CCMP uses AES in CCM mode executed in softirq
context. I have included a reference implementation using 4 NEON
registers only, which makes sense in this case as the CCM transform
itself cannot be parallelized.

On the other hand, AES in XTS mode (dm-crypt) is fully parallelizable,
always executes from a kernel thread and always operates on a sector.
In this case, using the entire register file allows an 8 way
interleaved (*) implementation with all the round keys (between 11 and
15 16-byte keys) cached in registers.

The bottom line is that even if the crypto instructions can be used in
a meaningful way with only 2 or 4 registers, it is highly likely that
using more registers will result in higher performance [at least in
the AES case]

For the plain NEON case, I have written an implementation that keeps
the entire S-box (256 bytes) in registers. This should perform quite
well [assuming 4 register wide tbl/tbx lookups are not too costly],
but only in the cases where the cost of loading the S-box can be
amortized over multiple operations. This implies no core AES cipher
using plain NEON, but doing the CCM might be feasible, even if we have
to stack the whole register file in that case.

I agree that always specifying the number of registers used is
probably a meaningful addition, and in fact this is what I have
implemented in the v3 that I sent yesterday. The only difference
between Nico's suggestion and my implementation is that the number of
registers is declared at the time that the stack area is reserved so
we don't waste a lot of space.

Regards,
Ard.


* I am assuming some level of interleaving will be required to get
optimal performance from these instructions, but whether 8 is the
sweet spot is TBD
