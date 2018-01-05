From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 Jan 2018 14:57:16 +0000
Subject: [PATCH v2 11/11] arm64: Implement branch predictor hardening for
 affected Cortex-A CPUs
In-Reply-To: <5A4F8FCD.3000903@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-12-git-send-email-will.deacon@arm.com>
 <5A4F8FCD.3000903@arm.com>
Message-ID: <763aac27-0866-024f-d72a-637cf545350e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/18 14:46, James Morse wrote:
> Hi Marc, Will,
> 
> (SOB-chain suggests a missing From: tag on this and patch 7)
> 
> On 05/01/18 13:12, Will Deacon wrote:
>> Cortex-A57, A72, A73 and A75 are susceptible to branch predictor aliasing
>> and can theoretically be attacked by malicious code.
>>
>> This patch implements a PSCI-based mitigation for these CPUs when available.
>> The call into firmware will invalidate the branch predictor state, preventing
>> any malicious entries from affecting other victim contexts.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
>> diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
>> index 06a931eb2673..2e9146534174 100644
>> --- a/arch/arm64/kernel/bpi.S
>> +++ b/arch/arm64/kernel/bpi.S
>> @@ -53,3 +53,27 @@ ENTRY(__bp_harden_hyp_vecs_start)
>>  	vectors __kvm_hyp_vector
>>  	.endr
>>  ENTRY(__bp_harden_hyp_vecs_end)
>> +ENTRY(__psci_hyp_bp_inval_start)
> 
>> +	sub	sp, sp, #(8 * 18)
> 
> Where does 18 come from? Isn't this storing 9 sets of 16 bytes?

Or 18 registers of 8 bytes each.

> 
>> +	stp	x16, x17, [sp, #(16 * 0)]
>> +	stp	x14, x15, [sp, #(16 * 1)]
>> +	stp	x12, x13, [sp, #(16 * 2)]
>> +	stp	x10, x11, [sp, #(16 * 3)]
>> +	stp	x8, x9, [sp, #(16 * 4)]
>> +	stp	x6, x7, [sp, #(16 * 5)]
>> +	stp	x4, x5, [sp, #(16 * 6)]
>> +	stp	x2, x3, [sp, #(16 * 7)]
> 
>> +	stp	x0, x1, [sp, #(18 * 8)]
> 
> 16->18 typo?

/me bashes head against keyboard, as this is likely to generate less
crap then me trying to write something half correct...

The fun part is that the Seattle box I booted yesterday with that crap
is still happily churning along. I guess I'm corrupting something that
really doesn't matter...

> 
> 
>> +	mov	x0, #0x84000000
>> +	smc	#0
>> +	ldp	x16, x17, [sp, #(16 * 0)]
>> +	ldp	x14, x15, [sp, #(16 * 1)]
>> +	ldp	x12, x13, [sp, #(16 * 2)]
>> +	ldp	x10, x11, [sp, #(16 * 3)]
>> +	ldp	x8, x9, [sp, #(16 * 4)]
>> +	ldp	x6, x7, [sp, #(16 * 5)]
>> +	ldp	x4, x5, [sp, #(16 * 6)]
>> +	ldp	x2, x3, [sp, #(16 * 7)]
> 
>> +	ldp	x0, x1, [sp, #(18 * 8)]
>> +	add	sp, sp, #(8 * 18)
> 
> (and here?)

Yup.

Thanks for pointing that out. I'll fetch a brown paper bag.

	M.
-- 
Jazz is not dead. It just smells funny...
