From: james.morse@arm.com (James Morse)
Date: Wed, 30 Mar 2016 17:46:41 +0100
Subject: [PATCH] arm64: KVM: Register CPU notifiers when the kernel runs
 at HYP
In-Reply-To: <56FBFF12.60109@arm.com>
References: <1459353370-589-1-git-send-email-james.morse@arm.com>
 <56FBFF12.60109@arm.com>
Message-ID: <56FC02F1.5060804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/16 17:30, Marc Zyngier wrote:
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 6accd66d26f0..cf0184edf4f5 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -1084,9 +1092,13 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
>>  				    unsigned long cmd,
>>  				    void *v)
>>  {
>> -	if (cmd == CPU_PM_EXIT &&
>> -	    __hyp_get_vectors() == hyp_default_vectors) {
>> -		cpu_init_hyp_mode(NULL);
>> +	if (cmd == CPU_PM_EXIT) {
>> +		if (is_kernel_in_hyp_mode()) {
>> +			cpu_init_stage2(NULL);
>> +		} else {
>> +			if (__hyp_get_vectors() == hyp_default_vectors)
>> +				cpu_init_hyp_mode(NULL);
>> +		}
> 
> Any reason why we can't isolate that snippet in a separate function and
> use it in both locations?

I thought I did that ... bother, wrong branch.

We can argue about the name, I called it 'cpu_hyp_reinit()', which pairs up with
'cpu_hyp_reset()' in a rebased version of the kexec/hibernate hyp-shutdown code.
(cpu_ seems to be the prefix for per-cpu functions in this file)

v2 shortly,


Thanks/Sorry,

James
