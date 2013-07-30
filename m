From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 30 Jul 2013 12:07:58 +0800
Subject: [PATCH] ARM(64): KVM: add signed type cast for comparation
In-Reply-To: <20130730034531.GC5471@cbox>
References: <51ECA4EC.3000408@asianux.com> <20130730034531.GC5471@cbox>
Message-ID: <51F73C1E.2030505@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 11:45 AM, Christoffer Dall wrote:
> On Mon, Jul 22, 2013 at 11:20:12AM +0800, Chen Gang wrote:
>> 'len' is 'unsigned long' which is never less than zero.
>>
>> So need a related type cast for comparation.
>>
>> The related warning (when building ARM64 with allmodconfig):
>>
>>   arch/arm64/kvm/../../../arch/arm/kvm/mmio.c:82:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
> 
> Hmmm, interesting, I don't get this error with my compiler.
> 
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/kvm/mmio.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>> index b8e06b7..626dfc8 100644
>> --- a/arch/arm/kvm/mmio.c
>> +++ b/arch/arm/kvm/mmio.c
>> @@ -79,7 +79,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  	}
>>  
>>  	len = kvm_vcpu_dabt_get_as(vcpu);
>> -	if (unlikely(len < 0))
>> +	if (unlikely((long)len < 0))
>>  		return len;
>>  
>>  	is_write = kvm_vcpu_dabt_iswrite(vcpu);
>> -- 
>> 1.7.7.6
> 
> I think the proper fix is to declare len as an int instead.  I'll queue
> that instead.
> 

Yeah, it is fine to me (better than my original fix).

Thanks.
-- 
Chen Gang
