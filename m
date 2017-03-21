From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 17:26:06 +0000
Subject: [PATCH v3 01/25] arm64: hyp-stub: Implement HVC_RESET_VECTORS
 stub hypercall
In-Reply-To: <20170321170407.GD21829@e104818-lin.cambridge.arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-2-marc.zyngier@arm.com>
 <20170321170407.GD21829@e104818-lin.cambridge.arm.com>
Message-ID: <11a10d32-700f-d969-556a-4d1748c2e92f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 17:04, Catalin Marinas wrote:
> On Mon, Mar 06, 2017 at 02:24:34PM +0000, Marc Zyngier wrote:
>> Let's define a new stub hypercall that resets the HYP configuration
>> to its default: hyp-stub vectors, and MMU disabled.
>>
>> Of course, for the hyp-stub itself, this is a trivial no-op.
>> Hypervisors will have a bit more work to do.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/virt.h |  9 +++++++++
>>  arch/arm64/kernel/hyp-stub.S  | 13 ++++++++++++-
>>  2 files changed, 21 insertions(+), 1 deletion(-)
> [...]
>> +ENTRY(__hyp_reset_vectors)
>> +	str	lr, [sp, #-16]!
>> +	mov	x0, #HVC_RESET_VECTORS
>> +	hvc	#0
>> +	ldr	lr, [sp], #16
>> +	ret
>> +ENDPROC(__hyp_reset_vectors)
> 
> Why do we need to specifically preserve lr across the hvc call? Is it
> corrupted by the EL2 code (if yes, are other caller-saved registers that
> need preserving)? I don't see something similar in the arch/arm code.

Yeah, that's another oddity. The KVM code uses it as a temp register,
but that feels quite wrong, now that you mention it. If should be saved
there, and definitely not in the stubs.

Let me grab a hammer, and I'll set that one straight.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
