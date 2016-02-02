From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 Feb 2016 13:42:08 +0000
Subject: [PATCH v2 18/21] arm64: KVM: Introduce hyp_alternate_value helper
In-Reply-To: <20160201144103.GX1478@cbox>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-19-git-send-email-marc.zyngier@arm.com>
 <20160201144103.GX1478@cbox>
Message-ID: <56B0B230.6070600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 14:41, Christoffer Dall wrote:
> On Mon, Jan 25, 2016 at 03:53:52PM +0000, Marc Zyngier wrote:
>> We already have hyp_alternate_select() to define a function pointer
>> that gets changed by a kernel feature or workaround.
>>
>> It would be useful to have a similar feature that resolves in a
>> direct value, without requiring a function call. For this purpose,
>> introduce hyp_alternate_value(), which returns one of two values
>> depending on the state of the alternative.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/hyp/hyp.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/hyp/hyp.h b/arch/arm64/kvm/hyp/hyp.h
>> index 44eaff7..dc75fdb 100644
>> --- a/arch/arm64/kvm/hyp/hyp.h
>> +++ b/arch/arm64/kvm/hyp/hyp.h
>> @@ -144,6 +144,17 @@ typeof(orig) * __hyp_text fname(void)					\
>>  	return val;							\
>>  }
>>  
>> +#define hyp_alternate_value(fname, orig, alt, cond)			\
>> +typeof(orig) __hyp_text fname(void)					\
>> +{									\
>> +	typeof(alt) val = orig;						\
>> +	asm volatile(ALTERNATIVE("nop		\n",			\
>> +				 "mov	%0, %1	\n",			\
>> +				 cond)					\
>> +		     : "+r" (val) : "r" ((typeof(orig))alt));		\
>> +	return val;							\
>> +}
>> +
>>  void __vgic_v2_save_state(struct kvm_vcpu *vcpu);
>>  void __vgic_v2_restore_state(struct kvm_vcpu *vcpu);
>>  
>> -- 
>> 2.1.4
>>
> I'm really not convinced that this is more readable than simply defining
> a function where needed.  Perhaps the thing that needs a definition is
> the "asm volatile(ALTERNATIVE(...))" part?  I also don't see why any of
> this is specific to KVM or Hyp ?

I can easily factor out the whole asm volatile part. What I'm trying to
avoid is an additional function call, but maybe we shouldn't need to
worry about the overhead on page faults altogether?

I'll drop it for now, and we can reconsider it later.

	M.
-- 
Jazz is not dead. It just smells funny...
