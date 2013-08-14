From: andre.przywara@calxeda.com (Andre Przywara)
Date: Wed, 14 Aug 2013 22:20:03 +0200
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <CAL_Jsq+vGd7+pw6YX0YNHO5rVSoiHCHbtXXdZ-3grnEcAOc38Q@mail.gmail.com>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <CAL_Jsq+vGd7+pw6YX0YNHO5rVSoiHCHbtXXdZ-3grnEcAOc38Q@mail.gmail.com>
Message-ID: <520BE673.9010801@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 08:54 PM, Rob Herring wrote:
> On Wed, Aug 14, 2013 at 4:22 AM, Andre Przywara
> <andre.przywara@calxeda.com> wrote:
>> Guest kernels with CONFIG_L2X0 set (for instance Highbank or OMAP4)
>> will trigger SMCs to handle the L2 cache controller (PL310).
>> This will currently inject #UNDEFs and eventually stop the guest.
>>
>> We don't need explicit L2 cache controller handling on A15s anymore,
>> so it is safe to simply ignore these calls and proceed with the next
>> instruction.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@calxeda.com>
>> ---
>>   arch/arm/kvm/handle_exit.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>
> At least for highbank, we can fix this in the kernel:

Yes, and we should do. But that won't fix older guest kernels, say 
Ubuntu 12.10 or the like. And I think this is a use case for 
virtualization, so we need both, guest and host fix.

Regards,
Andre

>
> diff --git a/arch/arm/mach-highbank/highbank.c
> b/arch/arm/mach-highbank/highbank.c
> index 1894dcf..b5d0375 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -77,8 +77,10 @@ static void __init highbank_init_irq(void)
>   {
>          irqchip_init();
>
> -       if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
> -               highbank_scu_map_io();
> +       if (!of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
> +               return;
> +
> +       highbank_scu_map_io();
>
>   #ifdef CONFIG_CACHE_L2X0
>          /* Enable PL310 L2 Cache controller */
>
>>
>> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
>> index df4c82d..2cbe6a0 100644
>> --- a/arch/arm/kvm/handle_exit.c
>> +++ b/arch/arm/kvm/handle_exit.c
>> @@ -50,8 +50,28 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>          return 1;
>>   }
>>
>> +/*
>> + * OMAP4 and Highbank machines do a SMC call to handle the L2 cache
>> + * controller. They put 0x102 in r12 to request this functionality.
>> + * This is not needed on A15s, so we can safely ignore it in KVM guests.
>> + */
>> +static int kvm_ignore_l2x0_call(struct kvm_vcpu *vcpu)
>> +{
>> +       unsigned long fn_nr = *vcpu_reg(vcpu, 12) & ~((u32) 0);
>> +
>> +       if (fn_nr == 0x102) {
>> +               kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>> +               return 1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   {
>> +       if (kvm_ignore_l2x0_call(vcpu))
>> +               return 1;
>> +
>>          kvm_inject_undefined(vcpu);
>>          return 1;
>>   }
>> --
>> 1.7.12.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
