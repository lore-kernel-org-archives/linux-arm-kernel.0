From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 14 Aug 2013 11:39:21 +0200
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <c8a1944576151990b3315183acee02be@www.loen.fr>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr>
Message-ID: <520B5049.3020803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 11:32 AM, Marc Zyngier wrote:
> On 2013-08-14 10:22, Andre Przywara wrote:
>> Guest kernels with CONFIG_L2X0 set (for instance Highbank or OMAP4)
>> will trigger SMCs to handle the L2 cache controller (PL310).
>> This will currently inject #UNDEFs and eventually stop the guest.
>>
>> We don't need explicit L2 cache controller handling on A15s anymore,
>> so it is safe to simply ignore these calls and proceed with the next
>> instruction.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@calxeda.com>
>
> Hold on.
>
> Are you trying to run A9 guests on KVM? Sorry, but that's not a
> supported mode of operation just yet.

No, I don't. I just run guests with kernels that would support A9 also. 
If you select Highbank in your .config, you will get CACHE_L2X0 and the 
kernel will do SMCs - regardless of the CPU you are running on. Those 
SMCs are ignored by the firmware on Midway.

I agree that the proper solution would be to detect at run-time in the 
(guest) kernel whether you actually need the PL310 handling, but for the 
time being and to support older kernels we will need this fix.

For me this fixes "qemu -machine midway --enable-kvm".

Regards,
Andre.

>
> So, until we have a proper framework to deal with multiple CPUs, the
> only valid configuration is A15-on-A15.
>
>> ---
>>   arch/arm/kvm/handle_exit.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
>> index df4c82d..2cbe6a0 100644
>> --- a/arch/arm/kvm/handle_exit.c
>> +++ b/arch/arm/kvm/handle_exit.c
>> @@ -50,8 +50,28 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
>> struct kvm_run *run)
>>   	return 1;
>>   }
>>
>> +/*
>> + * OMAP4 and Highbank machines do a SMC call to handle the L2 cache
>> + * controller. They put 0x102 in r12 to request this functionality.
>> + * This is not needed on A15s, so we can safely ignore it in KVM
>> guests.
>> + */
>> +static int kvm_ignore_l2x0_call(struct kvm_vcpu *vcpu)
>> +{
>> +	unsigned long fn_nr = *vcpu_reg(vcpu, 12) & ~((u32) 0);
>> +
>> +	if (fn_nr == 0x102) {
>> +		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>
> And what if I run mach-foo which uses r12 to request bar services from
> secure mode? Is it safe to ignore it? We need something much better than
> just testing random registers to guess what the guest wants.
>
>>   static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   {
>> +	if (kvm_ignore_l2x0_call(vcpu))
>> +		return 1;
>> +
>>   	kvm_inject_undefined(vcpu);
>>   	return 1;
>>   }
>
>           M.
>
