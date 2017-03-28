From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 28 Mar 2017 14:24:54 +0100
Subject: [PATCH v2 7/9] arm64: KVM: Do not corrupt registers on failed
 64bit CP read
In-Reply-To: <20170328124600.GG31156@cbox>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-8-marc.zyngier@arm.com> <20170328124600.GG31156@cbox>
Message-ID: <3a34a883-5c08-3a73-0b4a-f3830e6e8b08@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/17 13:46, Christoffer Dall wrote:
> On Mon, Mar 27, 2017 at 05:03:43PM +0100, Marc Zyngier wrote:
>> If we fail to emulate a mrrc instruction, we:
>> 1) deliver an exception,
>> 2) spit a nastygram on the console,
>> 3) write back some garbage to Rt/Rt2
>>
>> While 1) and 2) are perfectly acceptable, 3) is out of the scope of
>> the architecture... Let's mimick the code in kvm_handle_cp_32 and
>> be more cautious.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 4e5d4eee8cec..1080a76e960f 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1678,20 +1678,18 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
>>  		params.regval |= vcpu_get_reg(vcpu, Rt2) << 32;
>>  	}
>>  
>> -	if (!emulate_cp(vcpu, &params, target_specific, nr_specific))
>> -		goto out;
>> -	if (!emulate_cp(vcpu, &params, global, nr_global))
>> -		goto out;
>> -
>> -	unhandled_cp_access(vcpu, &params);
>> +	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
>> +	    !emulate_cp(vcpu, &params, global, nr_global)) {
> 
> super nit: I choked a bit on this contruct, any objections to adding a
> comment like the following above:
> 
> 	/*
> 	 * Try to emulate the coprocessor access using the target
> 	 * specific table first, and using the global table aftwards.
> 	 * If either of the tables contains a handler, handle the
> 	 * potential register operation in the case of a read and return
> 	 * with success.
> 	 */
> 
> Too much?
> 
> (If not, I can also add this when applying).

No, that's great. Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
