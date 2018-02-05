From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 5 Feb 2018 18:10:00 +0000
Subject: [PATCH v3 04/41] KVM: arm64: Rework hyp_panic for VHE and non-VHE
In-Reply-To: <be470bdb-258e-6b4d-b409-e230d2d90888@arm.com>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-5-christoffer.dall@linaro.org>
 <be470bdb-258e-6b4d-b409-e230d2d90888@arm.com>
Message-ID: <908db9b3-87a7-51bf-6c96-16488c0c827d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/18 18:04, Julien Grall wrote:
> On 12/01/18 12:07, Christoffer Dall wrote:
>> @@ -436,37 +446,31 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 
>> spsr, u64 elr, u64 par,
>> ???????????????? read_sysreg(hpfar_el2), par, vcpu);
>> ? }
>> -static void __hyp_text __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
>> -??????????????????????? struct kvm_vcpu *vcpu)
>> +static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
>> +???????????????? struct kvm_cpu_context *host_ctxt)
>> ? {
>> +??? struct kvm_vcpu *vcpu;
>> +??? vcpu = host_ctxt->__hyp_running_vcpu;
>> +
>> +??? __deactivate_traps(vcpu);
>> +??? __sysreg_restore_host_state(host_ctxt);
> 
> I was about to ask why you keep this function around as it does nothing 
> in VHE case. But I see that this will actually restore some values in a 
> later patch.

Actually, I just misread the code. Sorry for the noise.

Cheers,

-- 
Julien Grall
