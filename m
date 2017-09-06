From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 6 Sep 2017 15:40:56 +0100
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015EA4DE@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015EA4DE@DGGEMA503-MBX.china.huawei.com>
Message-ID: <79163d5d-90cf-9a94-457e-80cfffc0415f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/17 15:10, gengdongjiu wrote:
> Hi, Vladimir
> 
>>>> Do you see effect of "PAN is unexpectedly enabled"?
>>> In fact I did not encounter this case, but I think it can exist.
>>> I think if host OS dynamically disable PAN, it wants the host kernel access the user space address space not through copy_to/from_user
>> API.
>>> Now if it is unexpectedly enabled, when host kernel still accesses the user space address,  it will happen MMU fault exception.
>>
>> And this is expected! The only allowed channel for kernel <-> user is uaccess API.
>>
>> I guess that you have test (and that great!) which violates that rule (for testing purpose, why not?) and now you are trying to fit kernel into
>> it...
> 
> 
> If you think that makes sense for it, we do not consider the paste.PAN in the world-switch.
> For the pstate.UAO issue, do you agree my fixing or you have other suggestion?  Also to other reviewer. Thanks.

It would help if you give precise description on "pstate.UAO issue".

Thanks
Vladimir

> 
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 9341376..c3dd761 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -21,6 +21,8 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_hyp.h>
> 
> +#include <asm/exec.h>
> 
>  /* Yes, this does nothing, on purpose */
>  static void __hyp_text __sysreg_do_nothing(struct kvm_cpu_context *ctxt) { }
> 
> @@ -121,8 +123,13 @@ static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
>         write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],spsr);
>  }
> 
> +static void __hyp_text __sysreg_restore_state_vhe(struct kvm_cpu_context *ctxt)
> +{
> +    uao_thread_switch(current);
> +}
> +
>  static hyp_alternate_select(__sysreg_call_restore_host_state,
> -                           __sysreg_restore_state, __sysreg_do_nothing,
> +                           __sysreg_restore_state, __sysreg_restore_state_vhe,
>                             ARM64_HAS_VIRT_HOST_EXTN);
> 
>  void __hyp_text __sysreg_restore_host_state(struct kvm_cpu_context *ctxt)
> 
> 
>>
>> Cheers
>> Vladimir
>>
>>>
>>>
>>>>
>>>> Cheers
>>>> Vladimir
>>>>
>>>>>
>>>>>>
>>>>>> Cheers
>>>>>> Vladimir
>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> .
>>>>
>>>
>>>
> 
