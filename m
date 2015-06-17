From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Jun 2015 14:14:52 +0100
Subject: [PATCH v3 07/10] limit number of VCPUs on demand
In-Reply-To: <55816DC6.4060604@arm.com>
References: <1434540121-21283-1-git-send-email-andre.przywara@arm.com>
 <1434540121-21283-8-git-send-email-andre.przywara@arm.com>
 <55816DC6.4060604@arm.com>
Message-ID: <558172CC.3050601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 01:53 PM, Marc Zyngier wrote:
> On 17/06/15 12:21, Andre Przywara wrote:
>> Currently the ARM GIC checks the number of VCPUs against a fixed
>> limit, which is GICv2 specific. Don't pretend we know better than the
>> kernel and let's get rid of that explicit check.
>> Instead be more relaxed about KVM_CREATE_VCPU failing with EINVAL,
>> which is the way the kernel communicates having reached a VCPU limit.
>> If we see this and have at least brought up one VCPU already
>> successfully, then don't panic, but limit the number of VCPUs instead.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

...

>> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
>> index 7780251..c1cf51d 100644
>> --- a/arm/kvm-cpu.c
>> +++ b/arm/kvm-cpu.c
>> @@ -47,12 +47,19 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>>  	};
>>  
>>  	vcpu = calloc(1, sizeof(struct kvm_cpu));
>> -	if (!vcpu)
>> +	if (!vcpu) {
>> +		errno = ENOMEM;
>>  		return NULL;
>> +	}
> 
> Isn't errno already set when calloc fails?

Ah yes, that seems to be true at least for glibc or UNIX 98, according
to the manpage. I was misguided by the fact that calloc is not a
syscall. So I can drop this hunk.

Thanks,
Andre.
